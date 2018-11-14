//
//  LoginManager.h
//  GoodBook
//
//  Created by liuy on 2018/1/22.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^loginCallback)(Boolean isSucess);

typedef enum {
    LoginFail = 0,
    LoginSucess
} LoginStatus;

@interface LoginManager : NSObject

@property (nonatomic, assign) LoginStatus loginStatus;

+ (LoginManager *)shareInstance;

+ (void) loginOnVc:(UIViewController *)viewController afterLogin:(loginCallback)afterLogin;

@end
