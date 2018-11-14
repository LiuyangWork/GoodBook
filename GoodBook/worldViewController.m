//
//  worldViewController.m
//  GoodBook
//
//  Created by liuy on 2017/8/29.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "worldViewController.h"
#import <CoreText/CoreText.h>

@interface worldViewController () <UITextViewDelegate>

@property (nonatomic,strong) UITextView *tv;

@end

@implementation worldViewController

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
    // Do any additional setup after loading the view.
    //create a text layer
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CATextLayer *textLayer = [CATextLayer layer];
    CGRect frame = self.view.frame;
    frame.origin.y += 20;
    textLayer.frame = frame;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
//    [self.view.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vevarius in, facilisis pulvinar ";
    
    //create attributed string
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
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
    [string setAttributes:attribs range:NSMakeRange(6, 10)];
    
    //release the CTFont we created earlier
    CFRelease(fontRef);
    
    //set layer text
    textLayer.string = string;
    
    
    
    //create gradient layer and add it to our container view
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(50, 50, 100, 100);
    [self.view.layer addSublayer:gradientLayer];
    
    //set gradient colors
//    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    //set locations
    gradientLayer.locations = @[@0.0, @0.5, @1.0];

    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    
    _tv = [[UITextView alloc]initWithFrame:CGRectMake(50, 200, 200, 100)];
    _tv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_tv];
    _tv.keyboardAppearance = UIKeyboardAppearanceAlert;
    
    //键盘工具栏
    UIToolbar *keyboardDoneButtonView=[[UIToolbar alloc]init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *cancleButton =[[UIBarButtonItem alloc]initWithTitle:@"取消"style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked)];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]initWithTitle:@"完成"style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    keyboardDoneButtonView.items = @[cancleButton,space,doneButton];
    _tv.inputAccessoryView=keyboardDoneButtonView;
    
    //换行改为完成
//    _tv.returnKeyType =UIReturnKeyDone;
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
         [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        return NO;
    }
    return YES;
}

//点击编辑以外区域
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)doneClicked{
    [_tv setSelectedTextRange:[_tv textRangeFromPosition:_tv.beginningOfDocument toPosition:_tv.endOfDocument]];
//    [self.view endEditing:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
