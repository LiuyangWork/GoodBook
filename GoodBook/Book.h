//
//  Book.h
//  GoodBook
//
//  Created by 刘阳 on 2017/6/6.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Book : NSObject

@property (nonatomic, copy) NSString *BookName;
@property (nonatomic, copy) NSString *BookEditor;
@property (nonatomic, copy) NSString *BookAuthor;
@property (nonatomic, strong) UIImage *BookImage;

@end
