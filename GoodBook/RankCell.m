//
//  RankCell.m
//  GoodBook
//
//  Created by liuy on 2018/9/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "RankCell.h"

@implementation RankCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.myLabel];
        [self.contentView addSubview:self.myImage];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.myLabel];
        [self.contentView addSubview:self.myImage];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resetData:(RankModel *)model {
    self.myLabel.text = model.title;
}

#pragma mark lazy load

- (UILabel *)myLabel {
    if (!_myLabel) {
        _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
        _myLabel.text = @"我是label";
    }
    return _myLabel;
}

- (UIImageView *)myImage {
    if (!_myImage) {
        _myImage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 50, 50)];
        _myImage.image = [UIImage imageNamedFromBundle:@"defaultHeader"];
    }
    return _myImage;
}

@end
