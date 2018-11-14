//
//  NewTabBar.m
//  GoodBook
//
//  Created by 刘阳 on 2017/7/9.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "NewTabBar.h"

@interface NewTabBar()

//加号按钮
@property (nonatomic,weak) UIButton *plusBtn;

@end

@implementation NewTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加加号按钮
        UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];//[UIButton buttonWithType:UIButtonTypeCustom];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"plus circle-1"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"pencil_red"] forState:UIControlStateHighlighted];
        
//        [plusBtn sizeToFit];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.items.count + 1;
    CGFloat w = self.bounds.size.width / count;
    CGFloat h = self.bounds.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSLog(@"***subviews: %lu", self.subviews.count);
    int i = 0;
    for(UIView *btn in self.subviews) {
        
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                i += 1;
            }
            x = i * w;
            btn.frame = CGRectMake(x, y, w, h);
            i++;
        }
        
        //设置加号按钮位置
        self.plusBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 70 * 0.5 - 10 - (IsIphoneX ? 34 : 0));
    }

}

- (void)plusBtnClick{
    if ([self.myDelegate respondsToSelector:@selector(tabBarDidPlusBtnClick:)]) {
        [self.myDelegate tabBarDidPlusBtnClick:self];
    }
}

@end
