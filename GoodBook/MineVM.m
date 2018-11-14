//
//  MineVM.m
//  GoodBook
//
//  Created by liuy on 2018/1/23.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "MineVM.h"
#import "MineCell.h"

@interface MineVM()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MineVM

- (instancetype)initWithViewControlelr:(UIViewController *)viewController {
    self = [super init];
    
    if (self) {
        self.viewController = viewController;
        [self.viewController.view addSubview:self.collectionView];
        
    }
    
    return self;
}

- (void)registerCell {
    [_collectionView registerClass:[MineCell class] forCellWithReuseIdentifier:[MineCell cellID]];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.delaysContentTouches = NO;
        
        [_collectionView registerClass:[MineCell class] forCellWithReuseIdentifier:[MineCell cellID]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
//        [self registerCell];
    }
    return _collectionView;
}

#pragma DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MineCell cellID] forIndexPath:indexPath];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}
#pragma Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    
    if (indexPath.row == 0) {
        size = CGSizeMake(screenWidth , [MineCell cellHeight]);
    }
    else {
        size = CGSizeMake(screenWidth, 50);
    }
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

@end
