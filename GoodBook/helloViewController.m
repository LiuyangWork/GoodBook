//
//  helloViewController.m
//  GoodBook
//
//  Created by liuy on 2017/8/28.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "helloViewController.h"
#import <CoreText/CoreText.h>

@interface helloViewController ()

@end

@implementation helloViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"more"] selectedImage:[UIImage imageNamed:@"more_red"]];
        
        if (IsIphoneX) {
            [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -25)];
            [self.tabBarItem setImageInsets:UIEdgeInsetsMake(-12, 0, 12, 0)];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
//    
//    //path1
//    UIBezierPath *path = [[UIBezierPath alloc]init];
//    [path moveToPoint:CGPointMake(175, 100)];
//    
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:1.8*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
//    
//    
//    
//    //path2
//    CGRect rect = CGRectMake(50, 50, 100, 100);
//    CGSize radii = CGSizeMake(20, 20);
//    //圆角
//    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
//    //create path
//    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
//    
//    //create shape layer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 3;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.path = path2.CGPath;
//    //add it to our view
////    [self.view.layer addSublayer:shapeLayer];
    
    
    CATextLayer *textLayer = [CATextLayer layer];
    CGRect frame = self.view.frame;
    frame.origin.y = 20;
    textLayer.frame = frame;
    [self.view.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //UIFont转换为CGFontRef
    UIFont *font = [UIFont systemFontOfSize:15];
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
//    CGFontRelease(fontRef);
    //choose some text
    //set layer text
//    textLayer.string = @"*******";
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit";
    
    //create attributed string
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];

    
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //set text attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    
    
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 8)];
    
    //release the CTFont we created earlier
//    CFRelease(fontRef);
    
    //set layer text
    textLayer.string = string;
    
    
    if (IsIphoneX) {
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -25)];
        [self.tabBarItem setImageInsets:UIEdgeInsetsMake(-12, 0, 12, 0)];
    }
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
