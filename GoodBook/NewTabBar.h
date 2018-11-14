//
//  NewTabBar.h
//  GoodBook
//
//  Created by 刘阳 on 2017/7/9.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewTabBar;

@protocol NewTabBarDelegate <NSObject>

@optional
//加号按钮的点击事件
- (void)tabBarDidPlusBtnClick:(NewTabBar *)tabBar;

@end


@interface NewTabBar : UITabBar

//代理
@property (nonatomic, weak) id<NewTabBarDelegate> myDelegate;

@end
