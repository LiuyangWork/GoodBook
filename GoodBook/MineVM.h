//
//  MineVM.h
//  GoodBook
//
//  Created by liuy on 2018/1/23.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineVM : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

//@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, weak)UIViewController *viewController;

- (instancetype)initWithViewControlelr:(UIViewController *)viewController;

@end
