//
//  UIView+DJLoading.m
//  Jiazheng
//
//  Created by iBlock on 2017/3/6.
//  Copyright © 2017年 58. All rights reserved.
//

#import "UIView+DJLoading.h"
#import <objc/runtime.h>
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

@implementation UIView (DJLoading)

static char JZAssociateLoadingView;
static CGFloat DJLoadingOffset = 0;

- (void)setDjLoadingView:(UIView *)djLoadingView {
    if (djLoadingView) {
        objc_setAssociatedObject(self, &JZAssociateLoadingView, djLoadingView, OBJC_ASSOCIATION_RETAIN);
    } else {
        objc_setAssociatedObject(self, &JZAssociateLoadingView, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (UIView *)djLoadingView {
    id value=objc_getAssociatedObject(self, &JZAssociateLoadingView);
    if(value)return value;
    return nil;
}
- (void)ShowLoadingNoAutoDismiss {
    [self ShowLoadingWithFrame:self.bounds autoDismiss:NO];
}
- (void)ShowLoading {
    [self ShowLoadingWithFrame:self.bounds autoDismiss:true];
}

- (void)ShowLoadingWithFrame:(CGRect)frame autoDismiss:(BOOL)autoDismiss{
    if (!self.djLoadingView) {
        FLAnimatedImage *image = [UIImage gifImageNamedFromBundle:@"Loading.gif"];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.animatedImage = image;
        UIImage *post = [UIImage imageWithCGImage:image.posterImage.CGImage scale:[UIScreen mainScreen].scale orientation:image.posterImage.imageOrientation];
        CGSize size = post.size;
        if (screenWidth <= 375) {
            size.width = size.width *0.8;
            size.height = size.height *0.8;
            CGRect frame = imageView.frame;
            frame.size = size;
            imageView.frame = frame;
//            imageView.size = size;
        }
        UIView *maskView = [[UIView alloc] init];
        maskView.backgroundColor = [UIColor whiteColor];
        maskView.frame = frame;
        [maskView addSubview:imageView];
        if (DJLoadingOffset != 0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(maskView);
                make.centerY.equalTo(maskView).mas_offset(DJLoadingOffset);
                make.size.mas_equalTo(size);
            }];
            DJLoadingOffset = 0;
        } else {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(maskView);
                make.size.mas_equalTo(size);
            }];
        }
        self.djLoadingView = maskView;
        [self addSubview:self.djLoadingView];
        imageView.alpha = 0;
        [UIView animateWithDuration:1 animations:^{
            imageView.alpha = 1;
        }];
        if(autoDismiss){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self DismissLoading];
        });
        }
    }
}

- (void)ShowLoadingWithCenterOffset:(CGFloat)offset {
    DJLoadingOffset = offset;
    [self ShowLoadingWithFrame:self.bounds autoDismiss:true];
}

- (void)DismissLoading {
    if (self.djLoadingView) {
        [self.djLoadingView removeFromSuperview];
        self.djLoadingView = nil;
    }
}

@end
