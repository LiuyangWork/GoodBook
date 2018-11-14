//
//  TransitionManager.h
//  GoodBook
//
//  Created by 刘阳 on 2017/7/21.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TransitionType){
    TransitionTypePresent = 0,
    TransitionTypeDismiss
};

@interface TransitionManager : NSObject <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property(nonatomic,assign)TransitionType type;

+ (instancetype)transitionWithTransitionType:(TransitionType)type;
- (instancetype)initWithTransitionType:(TransitionType)type;

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
