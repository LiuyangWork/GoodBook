//
//  RankVC2.m
//  GoodBook
//
//  Created by 刘阳 on 2017/7/21.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "RankVC2.h"
#import "RankTransitionAnimation.h"

@implementation RankVC2 

- (void)dealloc{
    NSLog(@"vc2销毁了");
}

- (instancetype)init{
    self = [super init];
    
    if (self) {
        //设置代理
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(110, 100, 100, 100);
    [btn setTitle:@"close" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
     [btn addTarget:self action:@selector(btnDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //点击
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [self.view addGestureRecognizer:ges];
    
    //滑动
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizer];
    
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)viewClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//转场动画协议的方法
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [RankTransitionAnimation transitionWithTransitionType:TransitionTypePresent];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [RankTransitionAnimation transitionWithTransitionType:TransitionTypeDismiss];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSLog(@"push");
    
    return [RankTransitionAnimation transitionWithTransitionType:TransitionTypePresent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
//    return nil;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
