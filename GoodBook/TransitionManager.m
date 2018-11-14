//
//  TransitionManager.m
//  GoodBook
//
//  Created by 刘阳 on 2017/7/21.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "TransitionManager.h"
#import "RankViewController.h"

@implementation TransitionManager

+ (instancetype)transitionWithTransitionType:(TransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case TransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case TransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画start");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画stop");
    switch (_type) {
        case TransitionTypePresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
        }
            break;
        case TransitionTypeDismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
    }
}

@end

