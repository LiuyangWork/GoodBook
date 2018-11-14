//
//  UIImage+Bundle.h
//  GoodBook
//
//  Created by liuy on 2018/1/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Bundle)

+ (UIImage *)imageNamedFromBundle:(NSString *)name;

+ (UIImage *)gifImageNamedFromBundle:(NSString *)name;

@end
