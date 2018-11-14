//
//  NewViewController.m
//  GoodBook
//
//  Created by 刘阳 on 2017/6/4.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "NewViewController.h"
#import "MJRefresh.h"
#import "ProgressHUD.h"
#import "AddBookViewController.h"
#import "LoginManager.h"
#import "LoginVC.h"

typedef void (^delayBlock)();

@interface NewViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, screenWidth, screenHeight - SafeAreaTopHeight - 49)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    

    //下拉刷新、上拉加载
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerTarget)];
    [_tableview.mj_header beginRefreshing];
//    _tableview.mj_header.automaticallyChangeAlpha = YES;
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerTarget)];
}

- (instancetype)init{
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image: [UIImage imageNamed:@"users two-2"] selectedImage:[UIImage imageNamed:@"users two-2_red"]];
    return [super init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)loginButtonClicked {
    LoginVC *loginVC = [[LoginVC alloc] init];
    
    [self.navigationController pushViewController:loginVC animated:YES];
}

//懒加载
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"hello";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",(int)indexPath.row);
}

- (void)setNavigationBar{
    
    self.title = @"我的222";
    self.navigationItem.title = @"我的";
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 20, 50, 50)];
    loginButton.backgroundColor = [UIColor redColor];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:loginButton];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
//    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, SafeAreaTopHeight)];
//    _navigationView.backgroundColor = [UIColor redColor];
//    [self.navigationController.navigationBar addSubview:_navigationView];
//
//    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, screenWidth, 45)];
//    [addBtn setImage:[UIImage imageNamed:@"plus circle-1"] forState:UIControlStateNormal];
//    [addBtn setTitle:@"新增书评" forState:UIControlStateNormal];
//    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [addBtn addTarget:self action:@selector(addBookView) forControlEvents:UIControlEventTouchUpInside];
//
//    [_navigationView addSubview:addBtn];
}

- (void)addBookView{
    AddBookViewController *abvc = [[AddBookViewController alloc]init];
    
    [self presentViewController:abvc animated:YES completion:nil];
}

- (void)Delay:(double)time delayTimeBlock:(delayBlock)block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

//下拉刷新
- (void)headerTarget{
    NSLog(@"%@",@"header_target");
    [ProgressHUD show:@"Loading"];
    
    [self Delay:1 delayTimeBlock:^{
        // 结束刷新
        [_tableview.mj_header endRefreshing];
        [ProgressHUD showSuccess:@"Successfully loaded."];
    }];
    
}

- (void)footerTarget{
    
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
