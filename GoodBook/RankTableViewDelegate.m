//
//  RankTableViewDelegate.m
//  GoodBook
//
//  Created by liuy on 2018/9/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "RankTableViewDelegate.h"
#import "RankCell.h"
#import "NewTarBarController.h"
#import "GBBaseViewController.h"

static NSString *RankCellID = @"RankCellID";

@implementation RankTableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:RankCellID];
    
    if (!cell) {
        cell = [[RankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RankCellID];
    }
    
    RankModel *model = (RankModel *)self.dataArray[indexPath.row];
    [cell resetData:model];
    
    
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //加载本地html
    NSString *localHtmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *localHtmlStr = [NSString stringWithContentsOfFile:localHtmlPath encoding:NSUTF8StringEncoding error:nil];
    GBBaseViewController *webVC = [[GBBaseViewController alloc] initWithUrl:localHtmlStr];

    //加载url
//    NSString *urlStr = @"https://m.jr.mi.com/";
//    GBBaseViewController *webVC = [[GBBaseViewController alloc] initWithUrl:urlStr];
    
    [[NewTarBarController shareInstance].navigationController pushViewController:webVC animated:YES];
    
//    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [topVC presentViewController:webVC animated:YES completion:nil];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
