//
//  RankViewModel.m
//  GoodBook
//
//  Created by liuy on 2018/9/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "RankViewModel.h"
#import "RankModel.h"

@implementation RankViewModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)headerRefreshRequestWithCallBacl:(callback)callback {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        sleep(2);
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < 15; i++) {
            int x = arc4random() % 100;
            
            NSString *title = [NSString stringWithFormat:@"hello_%d", x];
            
            NSDictionary *dict = @{
                                   @"title": title
                                   };
            
            RankModel *model = [[RankModel alloc] initWithDict:dict];
            [array addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(array);
        });
    });
}

//- (instancetype)initWithVC:(UIViewController<RankVMDelegate> *)viewController {
//    if (self = [super init]) {
//        self.rankVC = viewController;
//    }
//
//    return self;
//}

@end
