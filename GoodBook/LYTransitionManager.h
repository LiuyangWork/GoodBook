//
//  LYTransitionManager.h
//  GoodBook
//
//  Created by liuy on 2018/10/20.
//  Copyright © 2018年 liuyang. All rights reserved.
//

//管理类

#import <Foundation/Foundation.h>
#import "LYTransitionAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYTransitionManager : NSObject <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) LYTransitionAnimation *pushAnimation;

@end

NS_ASSUME_NONNULL_END
