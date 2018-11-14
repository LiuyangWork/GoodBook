//
//  RankViewModel.h
//  GoodBook
//
//  Created by liuy on 2018/9/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol RankVMDelegate
//
//- (void)reloadData;
//
//@end

typedef void (^callback) (NSArray *array);

@interface RankViewModel : NSObject

//@property (nonatomic, weak) UIViewController <RankVMDelegate> *rankVC;
//
//- (instancetype)initWithVC:(UIViewController <RankVMDelegate> *)viewController;

- (void)headerRefreshRequestWithCallBacl:(callback)callback;

@end
