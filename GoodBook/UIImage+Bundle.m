//
//  UIImage+Bundle.m
//  GoodBook
//
//  Created by liuy on 2018/1/25.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "UIImage+Bundle.h"
#import "UIImageView+WebCache.h"
//#import "UIImage+WebP.h"
#import "FLAnimatedImage.h"

@implementation UIImage (Bundle)

+ (UIImage *)imageNamedFromBundle:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *imagePath = [path stringByAppendingPathComponent:@"resource.bundle/images"];
    UIImage *image = [self getImageWithPath:imagePath imageName:name];
    
    return image;
}

+ (FLAnimatedImage *)gifImageNamedFromBundle:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSString *imagePath = [path stringByAppendingPathComponent:@"resource.bundle/images"];
    FLAnimatedImage *gifImage =  [self getGifImageWithPath:imagePath imageName:name];
    
    return gifImage;
}

+ (UIImage *)getImageWithPath:(NSString *)imagePath imageName:(NSString *)imageName {
    NSString *filePath = [imagePath stringByAppendingFormat:@"/%@", imageName];
    UIImage *image = nil;
    
    image = [UIImage imageWithContentsOfFile:filePath];
    if (image) {
        return image;
    }
    
    image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingString:@".jpg"]];
    if (image) {
        return image;
    }
    
    image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingString:@".png"]];
    if (image) {
        return image;
    }
    
    image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingString:@".bmp"]];
    if (image) {
        return image;
    }
    
    //webp
    image = [self getWebpImageWithPath:imagePath imageName:imageName];
    if (image) {
        return image;
    }
    
    return [UIImage new];
}

+ (FLAnimatedImage *)getGifImageWithPath:(NSString *)imagePath imageName:(NSString *)imageName {
    NSString *filePath = @"";
    FLAnimatedImage *gifImage = nil;
    NSData *data = nil;
    
    //图片名不能包含.
    if ([imageName hasSuffix:@".gif"]) {
        imageName = [imageName componentsSeparatedByString:@"."].firstObject;
    }
        
    filePath = [imagePath stringByAppendingFormat:@"/%@.gif", imageName];
    data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
        gifImage = [FLAnimatedImage animatedImageWithGIFData:data];
        
        if (gifImage) {
            return gifImage;
        }
    }
    
    filePath = [imagePath stringByAppendingFormat:@"/%@@%1.0fx.gif", imageName, [UIScreen mainScreen].scale];
    data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
        gifImage = [FLAnimatedImage animatedImageWithGIFData:data];
        
        if (gifImage) {
            return gifImage;
        }
    }
    
    return nil;
}

- (void)isGifImage {
    
}

+ (UIImage *)getWebpImageWithPath:(NSString *)imagePath imageName:(NSString *)imageName {
    NSString *filePath = [imagePath stringByAppendingFormat:@"/%@", imageName];
    CGFloat scale = [[UIScreen mainScreen] scale];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        if (scale > 1) {
            filePath = [imagePath stringByAppendingFormat:@"/%@@%1.0fx.webp", imageName, scale];
        }
        
        if (scale == 2 && ![fileManager fileExistsAtPath:filePath]) {
            filePath = [imagePath stringByAppendingFormat:@"/%@@3x.webp", imageName];
            scale = 3;
        }
    }

    if ([fileManager fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            UIImage *image = nil;///////[UIImage sd_imageWithWebPData:data];
            UIImage *scaleImage = [UIImage imageWithCGImage:image.CGImage scale:scale orientation:image.imageOrientation];
            
            return scaleImage;
        }
    }
    return nil;
}

@end
