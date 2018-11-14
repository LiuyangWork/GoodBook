//
//  AddBookViewController.m
//  GoodBook
//
//  Created by 刘阳 on 2017/6/5.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "AddBookViewController.h"

@interface AddBookViewController ()

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
    [btn1 setTitle:@"返回" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont fontWithName:@"Bauhaus ITC" size:14];
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn1 addTarget:self action:@selector(retu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(320 - 50, 20, 44, 20)];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn2 addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)retu{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sure{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
