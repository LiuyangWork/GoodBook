//
//  AppDelegate.m
//  GoodBook
//
//  Created by 刘阳 on 2017/6/3.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "AppDelegate.h"
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

void handleException(NSException *ex) {
    NSLog(@"Ex: %@", ex.name);
    NSLog(@"Ex: %@", ex.reason);
    [[UIApplication sharedApplication].delegate performSelector:@selector(handleEx)];
}

- (void) handleEx{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"哈哈" message:@"傻逼了把" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
    
    // 重新启动RunLoop
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"-------点击了好的");
    exit(0);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //flutter
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
    [self.flutterEngine runWithEntrypoint:nil];
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
    
   //设置捕捉异常的回调
    NSSetUncaughtExceptionHandler(handleException);
    
    
    CGRect cg = [UIScreen mainScreen].bounds;
//    self.window = [[UIWindow alloc] initWithFrame:cg];
    
    int a = cg.size.width, b = cg.size.height;
    NSLog(@"%d %d", a, b);
    
    NewTarBarController *newTBC = [NewTarBarController shareInstance];
    
    MyNavigationController *myNC = [[MyNavigationController alloc] initWithRootViewController:newTBC];
    
    //设置窗口的根视图控制器为分栏控制器
    self.window.rootViewController = myNC;
    [self.window makeKeyAndVisible];
    
//    // 设定位置和大小
//    CGRect frame = CGRectMake(50,200,210,210);
//    frame.size = [UIImage imageNamed:@"launch3x.gif"].size;
//    // 读取gif图片数据
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"launch3x" ofType:@"gif"]];
//    // view生成
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
//    webView.userInteractionEnabled = NO;//用户不可交互
//    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    [self.window addSubview:webView];
    
    
//    //分栏控制器
//    UITabBarController *tbc = [UITabBarController new];
////    tbc.view.backgroundColor = [UIColor grayColor];
//    
//    //视图控制器
//    UIViewController *vc1 = [[RankViewController alloc]init];
//    
//    UIViewController *vc2 = [rootViewController new];
//    UIViewController *vc3 = [NewViewController new];
//    
//    UIViewController *vc4 = [[UIViewController alloc]init];
////    UIViewController *vc5 = [[UIViewController alloc]init];
//    
//    
//    
//    vc1.tabBarItem.title = @"首页";
//    vc2.tabBarItem.title = @"首页";
//    vc3.tabBarItem.title = @"首页";
//    vc4.tabBarItem.title = @"首页";
//    
//    //不使用导航控制器
//    tbc.viewControllers = @[vc1,vc2,vc3,vc4];
////    tbc.navigationController
//   
  
    
    
//    //使用导航控制器
//    //用viewController初始化navicationController
//    UINavigationController *nc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
//    UINavigationController *nc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
//    UINavigationController *nc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
//    UINavigationController *nc4 = [[UINavigationController alloc]initWithRootViewController:vc4];
//    UINavigationController *nc5 = [[UINavigationController alloc]initWithRootViewController:vc5];
//    
////    UIImage *img = [UIImage imageNamed:@"bio"];
//    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"排行榜" image:[UIImage imageNamed:@"bio_red"] selectedImage:[UIImage imageNamed:@"bio_red"]];
//    nc1.tabBarItem = item1;
////    nc1.tabBarController.tabBar.tintColor = [UIColor redColor];
//    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"timer 2"] selectedImage:[UIImage imageNamed:@"timer 2_red"]];
//    item2.badgeValue = @"1";
////    item2.badgeValue = nil;
//    nc2.tabBarItem = item2;
////    nc2.tabBarController.tabBar.hidden = YES;
//    
//    nc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"新增" image:[UIImage imageNamed:@"pencil"] selectedImage:[UIImage imageNamed:@"pencil_red"]];
//    nc4.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"圈子" image: [UIImage imageNamed:@"users two-2"] selectedImage:[UIImage imageNamed:@"users two-2_red"]];
//    nc5.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"more"] selectedImage:[UIImage imageNamed:@"more_red"]];
//    
//    tbc.viewControllers = @[nc1,nc2,nc3,nc4,nc5];
    
    
//    UIImageView *launchGifView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 210, 210)];
//    launchGifView.backgroundColor = [UIColor blueColor];
//    [self.window addSubview:launchGifView];
//    [self.window bringSubviewToFront:launchGifView];
//    launchGifView.alpha = 0.99;
//    
//    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//        launchGifView.alpha = 1;
//    } completion:^(BOOL finished) {
//        [launchGifView removeFromSuperview];
//    }];
//    
    
//    UIView *launchGifView = [[UIView alloc]initWithFrame:self.window.frame];
//    //    UIImageView *launchGifView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 210, 210)];
//    //    launchGifView.size = self.window.size;
//    launchGifView.backgroundColor = [UIColor whiteColor];
//    
//    // 设定位置和大小
//    CGRect frame = CGRectMake(0,0,210,210);
//    frame.size = [UIImage imageNamed:@"launch.gif"].size;
    
    // 读取gif图片数据
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"launch" ofType:@"gif"]];
    // view生成
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
//    [webView setCenter:launchGifView.center];
//    webView.userInteractionEnabled = NO;//用户不可交互
//    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    [launchGifView addSubview:webView];
//    
//    
//    [self.window addSubview:launchGifView];
//    [self.window bringSubviewToFront:launchGifView];
//        launchGifView.alpha = 0.99;
//    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//                launchGifView.alpha = 1;
//    } completion:^(BOOL finished) {
//        [launchGifView removeFromSuperview];
//    }];

    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
