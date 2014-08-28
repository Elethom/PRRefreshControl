//
//  PRRefreshControl.h
//  PRRefreshControlDemo
//
//  Created by Elethom Hunter on 8/28/14.
//  Copyright (c) 2014 Project Rhinestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRRefreshControl : UIControl

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat verticalOffset;

- (UIView *)contentView;

- (void)beginRefreshing;
- (void)endRefreshing;

- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDragging;

@end
