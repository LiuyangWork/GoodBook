//
//  rootViewController.m
//  GoodBook
//
//  Created by 刘阳 on 2017/6/4.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "rootViewController.h"

#define VALUE  0
#define ColorOfHex(value) [UIColor colorWithRed:((value&0xFF0000)>>16)/255.0 green:((value&0xFF00)>>8)/255.0 blue:(value&0xFF)/255.0 alpha:1.0]

@interface rootViewController ()
@property(nonatomic,copy)UIImageView *planeView;

@property (nonatomic, copy) UIImageView *hourHand;
@property (nonatomic, copy) UIImageView *minuteHand;
@property (nonatomic, copy) UIImageView *secondHand;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation rootViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"timer 2"] selectedImage:[UIImage imageNamed:@"timer 2_red"]];
        
        if (IsIphoneX) {
            [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -25)];
            [self.tabBarItem setImageInsets:UIEdgeInsetsMake(-12, 0, 12, 0)];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
//    [self.view addGestureRecognizer:tap];
    UIImage *image = [UIImage imageNamed:@"plane"];

    _planeView = [[UIImageView alloc]initWithImage:image];
    [_planeView setFrame:CGRectMake(50, 150, 50, 20)];
    [self.view addSubview:_planeView];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
//    CGPoint centerPoint = CGPointMake(200, 200);
//    _hourHand.center = centerPoint;
    _secondHand = [[UIImageView alloc]initWithImage:image];
     [_secondHand setFrame:CGRectMake(200, 200, 50, 20)];
    _secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    
    [self.view addSubview:_secondHand];
//    [self.view addSubview:_minuteHand];
//    [self.view addSubview:_secondHand];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
//    iv.image = [UIImage imageFromColor:[UIColor colorWithCGColor:ColorOfHex(0xF5F7FA).CGColor]];
    UIColor *color = ColorOfHex(0xF5F7FA);
    iv.backgroundColor = color;
    [self.view addSubview:iv];
    

}

- (void)viewDidAppear:(BOOL)animated{
    [self fly];
    [self bezier];
    [self rotation];
}

- (void)tick{
//    NSLog(@"timer");
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
//    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
//    //calculate hour hand angle //calculate minute hand angle
//    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
//    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
//    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
//    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
}

- (void)bezier{
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 300)];
    [bezierPath addCurveToPoint:CGPointMake(300, 300) controlPoint1:CGPointMake(75, 150) controlPoint2:CGPointMake(225, 450)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 50, 20);
    shipLayer.position = CGPointMake(0, 300);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"plane"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
}

- (void)rotation{
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 50, 20);
    shipLayer.position = CGPointMake(50, 350);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"plane"].CGImage;
    [self.view.layer addSublayer:shipLayer];
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 10.0;
    animation.byValue = @(M_PI * 10);
    [shipLayer addAnimation:animation forKey:nil];
}

- (void)fly{
    
    CGPoint originalCenter = _planeView.center;
    
    [UIView animateKeyframesWithDuration:3 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            [self.planeView setCenter:CGPointMake(self.planeView.center.x + 100, self.planeView.center.y - 10)];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.04 animations:^{
            [self.planeView setTransform:CGAffineTransformMakeRotation((-M_PI_4/2))];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.4 animations:^{
            [self.planeView setCenter:CGPointMake(self.planeView.center.x + 150, self.planeView.center.y - 100)];
            [self.planeView setAlpha:0.5];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.51 relativeDuration:0.01 animations:^{
            [self.planeView setTransform:CGAffineTransformIdentity];
            [self.planeView setCenter:CGPointMake(0, self.planeView.center.y)];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.3 animations:^{
            [self.planeView setAlpha:1];
            [self.planeView setCenter:originalCenter];
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"complete");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapEvent:(UITapGestureRecognizer *)gesture
{
    static int flag = 1;
    if (flag)
    {
        // 初始化3D变换,获取默认值
        CATransform3D perspectiveTransform = CATransform3DIdentity;
        
        // 缩放变换
        perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.5, 0.5, 0.5);
        
        [UIView animateWithDuration:0.3 animations:^{
            if (VALUE)
            {
                // 导航控制器的view
                self.navigationController.view.transform = CATransform3DGetAffineTransform(perspectiveTransform);
            }
            else
            {
                // 自身controller的view
                self.view.transform = CATransform3DGetAffineTransform(perspectiveTransform);
            }
        }];
        
        flag = 0;
    }
    else
    {
        // 初始化3D变换,获取默认值
        CATransform3D perspectiveTransform = CATransform3DIdentity;
        
        // 缩放变换
        perspectiveTransform = CATransform3DScale(perspectiveTransform, 1, 1, 1);
        
        [UIView animateWithDuration:0.3 animations:^{
            if (VALUE)
            {
                // 导航控制器的view
                self.navigationController.view.transform = CATransform3DGetAffineTransform(perspectiveTransform);
            }
            else
            {
                // 自身controller的view
                self.view.transform = CATransform3DGetAffineTransform(perspectiveTransform);
            }
        }];
        
        flag = 1;
    }
}

@end
