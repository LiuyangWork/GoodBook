//
//  MineCell.m
//  GoodBook
//
//  Created by liuy on 2018/1/23.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "MineCell.h"

@interface MineCell()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UIImageView *houseImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *nameButton;

@end

@implementation MineCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self prepareUI];
        [self setConstrains];
//        [self.backgroundView.layer addSublayer:self.gradientLayer];
        
        
    }
    
    return self;
}

- (void)prepareUI {
//    [self.layer addSublayer:self.gradientLayer];
//    self.layer.zPosition = -1;
//    self.contentView.layer.zPosition = 1;
    
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.houseImageView];
    [self.bgImageView addSubview:self.iconImageView];
    [self.bgImageView addSubview:self.nameButton];
}

- (void)setConstrains {
    WS(weakSelf);
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-20 - 24, 0, 0, 0));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(15);
        make.top.centerY.equalTo(weakSelf.iconImageView);
    }];
    
    [self.houseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bgImageView.mas_left).offset(150);
        make.bottom.mas_equalTo(weakSelf.bgImageView.mas_bottom);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(121);
    }];
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageFromLayer:self.gradientLayer];
    }
    return _bgImageView;
}

- (UIImageView *)houseImageView {
    if (!_houseImageView) {
        _houseImageView = [[UIImageView alloc] init];
        _houseImageView.image = [UIImage imageNamedFromBundle:@"mineHouse"];
    }
    return _houseImageView;
}

- (UIButton *)nameButton {
    if (!_nameButton) {
        _nameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [_nameButton setTitle:@"请登录" forState:UIControlStateNormal];
    }
    return _nameButton;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(0, 0, screenWidth, self.contentView.bounds.size.height);
        _gradientLayer.colors = @[
                             (__bridge id)ColorOfHex(0xFF884C).CGColor,
                             (__bridge id)ColorOfHex(0xED594B).CGColor,
                             (__bridge id)ColorOfHex(0xE6454A).CGColor
                             ];
        _gradientLayer.startPoint = CGPointMake(1, 0.5);
        _gradientLayer.endPoint = CGPointMake(0, 0.5);
    }
    return _gradientLayer;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"headIcon"];
        _iconImageView.backgroundColor = [UIColor whiteColor];
    }
    return _iconImageView;
}

+ (NSString *)cellID {
    return @"MineCellID";
}

+ (CGFloat)cellHeight {
    return 150;
}

@end
