//
//  MIFIPlayerViewController.h
//  GoodBook
//
//  Created by liuyang on 2019/9/2.
//  Copyright © 2019 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MIFIPlayerViewController : UIViewController

@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithUrls:(NSArray *)urls currentIndex:(NSInteger)currentIndex;

@end

NS_ASSUME_NONNULL_END
