//
//  RankCell.h
//  GoodBook
//
//  Created by liuy on 2018/9/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankModel.h"

@interface RankCell : UITableViewCell

@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UIImageView *myImage;

- (void)resetData:(RankModel *)model;

@end
