//
//  UserModel.h
//  GoodBook
//
//  Created by liuy on 2018/1/22.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *telphone;

+ (Boolean)isLogin;
+ (UserModel *)shareInstance;

@end
