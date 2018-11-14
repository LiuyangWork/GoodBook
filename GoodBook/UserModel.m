//
//  UserModel.m
//  GoodBook
//
//  Created by liuy on 2018/1/22.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (UserModel *)shareInstance {
    static UserModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserModel alloc] init];
    });
    return instance;
}

@end
