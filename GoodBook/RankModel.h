//
//  RankModel.h
//  GoodBook
//
//  Created by liuy on 2018/9/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject

@property (nonatomic,strong) NSString *title;

- (RankModel *)initWithDict:(NSDictionary *)dict;

@end
