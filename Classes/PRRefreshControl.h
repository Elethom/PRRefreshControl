//
//  PRRefreshControl.h
//  PRRefreshControl
//
//  Created by Elethom Hunter on 8/28/14.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRRefreshControl : UIControl

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat verticalOffset;

@property (nonatomic, assign) UIEdgeInsets scrollViewContentInset;

@property (readonly, nonatomic, weak) UIView *contentView;
@property (readonly, nonatomic, weak) UIImageView *arrowImageView;
@property (readonly, nonatomic, weak) UIActivityIndicatorView *activityIndicator;

- (void)beginRefreshing;
- (void)endRefreshing;

@end
