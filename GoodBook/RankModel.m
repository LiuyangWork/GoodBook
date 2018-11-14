//
//  RankModel.m
//  GoodBook
//
//  Created by liuy on 2018/9/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "RankModel.h"

@implementation RankModel

- (RankModel *)initWithDict:(NSDictionary *)dict {
    if (self = [super init] ) {
        self.title = dict[@"title"];
    }
    
    return self;
}

@end
