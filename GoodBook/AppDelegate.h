//
//  AppDelegate.h
//  GoodBook
//
//  Created by 刘阳 on 2017/6/3.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import "rootViewController.h"
#import "NewViewController.h"
#import "RankViewController.h"
#import "NewTarBarController.h"

//@interface AppDelegate : UIResponder <UIApplicationDelegate>
@interface AppDelegate : FlutterAppDelegate

    @property (strong, nonatomic) UIWindow *window;

    @property (nonatomic, strong) FlutterEngine *flutterEngine;

@end

