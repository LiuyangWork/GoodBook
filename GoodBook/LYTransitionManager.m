//
//  LYTransitionManager.m
//  GoodBook
//
//  Created by liuy on 2018/10/20.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "LYTransitionManager.h"

@implementation LYTransitionManager

- (LYTransitionAnimation *)pushAnimation {
    if (!_pushAnimation) {
        _pushAnimation = [[LYTransitionAnimation alloc] init];
        
    }
    return _pushAnimation;
}

@end
