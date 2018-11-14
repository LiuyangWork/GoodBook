//
//  UIView+DJLoading.h
//  Jiazheng
//
//  Created by iBlock on 2017/3/6.
//  Copyright © 2017年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DJLoading)

@property (nonatomic, strong) UIView *djLoadingView;

- (void)ShowLoading;
- (void)ShowLoadingNoAutoDismiss;
- (void)ShowLoadingWithFrame:(CGRect)frame autoDismiss:(BOOL)autoDismiss;
- (void)ShowLoadingWithCenterOffset:(CGFloat)offset;
- (void)DismissLoading;

@end
