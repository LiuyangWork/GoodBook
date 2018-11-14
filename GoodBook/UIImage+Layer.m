//
//  UIImage+UIImage_Layer.m
//  GoodBook
//
//  Created by liuy on 2018/1/24.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "UIImage+Layer.h"

@implementation UIImage (Layer)

+ (UIImage *)imageFromLayer:(CALayer *)layer {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
