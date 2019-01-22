//
//  NewTarBarController.m
//  GoodBook
//
//  Created by 刘阳 on 2017/7/9.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "NewTarBarController.h"
#import "NewTabBar.h"
#import "RankViewController.h"
#import "rootViewController.h"
#import "NewViewController.h"
#import "helloViewController.h"
#import "worldViewController.h"
#import "MineViewController.h"
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>
#import "AppDelegate.h"

@interface NewTarBarController () <NewTabBarDelegate> {
    RankViewController *_vc1;
    rootViewController *_vc2;
    worldViewController *_vc3;
    MineViewController *_vc4;
}

@end

@implementation NewTarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
    FlutterViewController *_vcFlutter = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:@"" bundle:nil];
    _vcFlutter.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"more"] selectedImage:[UIImage imageNamed:@"more_red"]];
    
//    [_vcFlutter setInitialRoute:@"/test"];
    
    if (IsIphoneX) {
        [_vcFlutter.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -25)];
        [_vcFlutter.tabBarItem setImageInsets:UIEdgeInsetsMake(-12, 0, 12, 0)];
    }
    
    _vc1 = [RankViewController new];
    _vc2 = [rootViewController new];
    _vc3 = [worldViewController new];
    _vc4 = [MineViewController new];
    
    self.viewControllers = @[_vc1,_vc2,_vcFlutter,_vc4];
    // Do any additional setup after loading the view.
    
    //@property(nonatomic,readonly) UITabBar *tabBar
    //tabbar是readonly的,所以只能通过KVC赋值,不能直接更改
    //为什么在这里更改系统的tabBar,在这里系统的tabBar还没有值
    
    NewTabBar *tabBar = [[NewTabBar alloc] init];
    tabBar.myDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

+ (NewTarBarController *)shareInstance {
    static NewTarBarController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NewTarBarController alloc] init];
    });
    return instance;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tabBarDidPlusBtnClick:(NewTabBar *)tabBar{
    UIView *plusView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    plusView.backgroundColor = [UIColor redColor];
    [self.view addSubview:plusView];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [plusView removeFromSuperview];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
