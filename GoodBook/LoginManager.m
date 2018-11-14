//
//  LoginManager.m
//  GoodBook
//
//  Created by liuy on 2018/1/22.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "LoginManager.h"
#import "LoginVC.h"

@implementation LoginManager

+ (LoginManager *)shareInstance {
    static LoginManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LoginManager alloc] init];
    });
    
    return instance;
}

+ (void)loginOnVc:(UIViewController *)viewController afterLogin:(loginCallback)afterLogin {
    LoginVC *loginVC = [[LoginVC alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [viewController presentViewController:navigationController animated:YES completion:^{
        
    }];
}

@end
