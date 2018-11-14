//
//  WeatherModel.h
//  GoodBook
//
//  Created by liuy on 2018/8/8.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *sunrise;
@property (nonatomic, strong) NSString *high;
@property (nonatomic, strong) NSString *low;
@property (nonatomic, strong) NSString *notice;

@end
