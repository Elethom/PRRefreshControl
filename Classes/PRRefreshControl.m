//
//  PRRefreshControl.m
//  PRRefreshControlDemo
//
//  Created by Elethom Hunter on 8/28/14.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import "PRRefreshControl.h"

typedef NS_ENUM(NSUInteger, PRRefreshControlState) {
    PRRefreshControlStateNormal,
    PRRefreshControlStateReady,
    PRRefreshControlStateRefreshing
};

CGFloat kPRRefreshControlHeight = 50.f;

@interface PRRefreshControl ()

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets scrollViewContentInset;

@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, assign) PRRefreshControlState refreshState;

- (void)addScrollViewInset;
- (void)removeScrollViewInset;

@end

@implementation PRRefreshControl

- (void)beginRefreshing
{
    self.refreshing = YES;
    self.refreshState = PRRefreshControlStateRefreshing;
    [self addScrollViewInset];
}

- (void)endRefreshing
{
    self.refreshing = NO;
    [self removeScrollViewInset];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.refreshState = PRRefreshControlStateNormal;
    });
}

- (void)addScrollViewInset
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.1f animations:^{
        UIEdgeInsets contentInset = self.scrollViewContentInset;
        contentInset.top += self.height;
        weakSelf.scrollView.contentInset = contentInset;
    }];
}

- (void)removeScrollViewInset
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.1f animations:^{
        UIEdgeInsets contentInset = self.scrollViewContentInset;
        weakSelf.scrollView.contentInset = contentInset;
    }];
}

- (void)setRefreshState:(PRRefreshControlState)refreshState
{
    switch (refreshState) {
        case PRRefreshControlStateNormal:
        {
            self.arrowImageView.hidden = NO;
            [UIView animateWithDuration:.2f animations:^{
                self.arrowImageView.transform = CGAffineTransformIdentity;
            }];
            [self.activityIndicator stopAnimating];
            break;
        }
        case PRRefreshControlStateReady:
        {
            self.arrowImageView.hidden = NO;
            [UIView animateWithDuration:.2f animations:^{
                self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI);
            }];
            [self.activityIndicator stopAnimating];
            break;
        }
        case PRRefreshControlStateRefreshing:
        {
            self.arrowImageView.hidden = YES;
            self.arrowImageView.transform = CGAffineTransformIdentity;
            [self.activityIndicator startAnimating];
            break;
        }
    }
    _refreshState = refreshState;
}

#pragma mark - Life cycle

- (id)init
{
    self = [self initWithFrame:CGRectMake(0, - kPRRefreshControlHeight, 320.f, kPRRefreshControlHeight)];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = kPRRefreshControlHeight;
        
        UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
        contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                        UIViewAutoresizingFlexibleHeight);
        self.contentView = contentView;
        [self addSubview:contentView];
        
        CGPoint center = contentView.center;
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PRRefreshControl.bundle/Arrow"]];
        arrowImageView.center = center;
        arrowImageView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                           UIViewAutoresizingFlexibleRightMargin |
                                           UIViewAutoresizingFlexibleTopMargin |
                                           UIViewAutoresizingFlexibleBottomMargin);
        self.arrowImageView = arrowImageView;
        [contentView addSubview:arrowImageView];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.center = center;
        activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                              UIViewAutoresizingFlexibleRightMargin |
                                              UIViewAutoresizingFlexibleTopMargin |
                                              UIViewAutoresizingFlexibleBottomMargin);
        self.activityIndicator = activityIndicator;
        [contentView addSubview:activityIndicator];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if ([newSuperview isKindOfClass:UIScrollView.class]) {
        self.scrollView = (UIScrollView *)newSuperview;
    }
    
    UIScrollView *scrollView = self.scrollView;
    
    self.scrollViewContentInset = scrollView.contentInset;
    self.frame = CGRectMake(- self.scrollViewContentInset.left,
                            - self.height,
                            CGRectGetWidth(scrollView.frame),
                            self.height);
    CGPoint center = self.contentView.center;
    center.y += self.verticalOffset;
    self.arrowImageView.center = center;
    self.activityIndicator.center = center;
    
    [scrollView addObserver:self
                 forKeyPath:@"frame"
                    options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                    context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.scrollView) {
        UIScrollView *scrollView = self.scrollView;
        if ([keyPath isEqualToString:@"frame"]) {
            self.frame = CGRectMake(- scrollView.contentInset.left,
                                    - self.height,
                                    CGRectGetWidth([change[NSKeyValueChangeNewKey] CGRectValue]),
                                    self.height);
        }
    }
}

- (void)scrollViewDidScroll
{
    UIScrollView *scrollView = self.scrollView;
    UIEdgeInsets contentInset = self.scrollViewContentInset;
    CGFloat offset = scrollView.contentOffset.y + contentInset.top;
    if (self.isRefreshing) {
        contentInset.top += MIN(MAX(0, - offset), self.height);
        scrollView.contentInset = contentInset;
    } else if (scrollView.isDragging) {
        if (offset < - self.height) {
            self.refreshState = PRRefreshControlStateReady;
        } else {
            self.refreshState = PRRefreshControlStateNormal;
        }
    }
}

- (void)scrollViewDidEndDragging
{
    UIScrollView *scrollView = self.scrollView;
    UIEdgeInsets contentInset = self.scrollViewContentInset;
    CGFloat offset = scrollView.contentOffset.y + contentInset.top;
    if (!self.refreshing) {
        if (offset < - self.height) {
            [self beginRefreshing];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        } else {
            self.refreshState = PRRefreshControlStateNormal;
        }
    }
}

@end
