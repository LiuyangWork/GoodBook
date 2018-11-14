//
//  MineViewController.m
//  GoodBook
//
//  Created by liuy on 2018/1/23.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@property (nonatomic, strong) UIView *navigationView;

@end

@implementation MineViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image: [UIImage imageNamed:@"users two-2"] selectedImage:[UIImage imageNamed:@"users two-2_red"]];
        
        if (IsIphoneX) {
            [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -25)];
            [self.tabBarItem setImageInsets:UIEdgeInsetsMake(-12, 0, 12, 0)];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mineVM = [[MineVM alloc] initWithViewControlelr:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    
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
