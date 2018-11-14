//
//  RankViewController.m
//  GoodBook
//
//  Created by 刘阳 on 2017/6/8.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "RankViewController.h"
#import "RankVC2.h"
#import "FLAnimatedImage.h"
#import <CommonCrypto/CommonDigest.h>
#import "RankViewModel.h"
#import "RankTableViewDelegate.h"
#import "GBBaseViewController.h"


@interface RankViewController () <CALayerDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, UITableViewDelegate> {
}

@property(nonatomic,copy)UIImageView *imgView;
@property(nonatomic,copy)NSTimer *timer;

@property (nonatomic, strong) RankViewModel *rankViewModel;
@property (nonatomic, strong) RankTableViewDelegate *rankTableViewDelegate;
@property (nonatomic, strong) RankVC2 *VC;

@end

extern NSInteger CellHeight;

@implementation RankViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"排行榜" image:[UIImage imageNamed:@"bio_red"] selectedImage:[UIImage imageNamed:@"bio_red"]];
        
        if (IsIphoneX) {
            [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -25)];
            [self.tabBarItem setImageInsets:UIEdgeInsetsMake(-12, 0, 12, 0)];
        }
    }
    return self;
}

- (void)dealloc{
    NSLog(@"vc1销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    

    
    
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(80, 100, 50, 50)];
//    [btn2 setTitle:@"SD" forState:UIControlStateNormal];
//    btn2.backgroundColor = [UIColor grayColor];
//    [btn2 addTarget:self action:@selector(downloadImage) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
    
    
    
//    [self prepareUI];
    
    //调用js
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [webView stringByEvaluatingJavaScriptFromString:@"jsFunction"];
    
//    [self testImage];
    
    
//    NSCache *ca = [[NSCache alloc] init];
//    [ca setObject:@"hello" forKey:@"kkk"];
//
//    [ca objectForKey:@"kkk"];
    
//    MD5
//    NSLog(@"md5: %@", [self md5:@"hello"]);
   
    

}

- (void)initUI {
//    [self.view addSubview:self.imgView];
    [self.view addSubview:self.rankTableView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, SafeAreaTopHeight, 50, 50)];
    [btn setTitle:@"AF" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(getDataFromNet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(80, SafeAreaTopHeight, 100, 50)];
    [btn2 setTitle:@"Transition" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor grayColor];
    [btn2 addTarget:self action:@selector(transition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)transition {
    self.VC = [[RankVC2 alloc] init];
    
//    [self.navigationController pushViewController:self.VC animated:YES];
    
    [self presentViewController:self.VC animated:YES completion:nil];
}

- (NSString *)md5:(NSString *)key {
    unsigned char result[16];
    
    const char *cKey = key.UTF8String;
    
    CC_MD5(cKey, (CC_LONG)strlen(cKey), result);
    
    NSString *resultStr = @"";
    
    for (int i = 0; i < 16; i++) {
        resultStr = [resultStr stringByAppendingFormat:@"%02x", result[i]];
    }
    
    return resultStr;
}

- (void)testImage {
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535802462830&di=b3e667a3ba15a28a305a14b402914f3c&imgtype=0&src=http%3A%2F%2Fent.yunnan.cn%2Fimages%2Fattachement%2Fjpg%2Fsite2%2F20171227%2F002324a0b89c1bad81c11e.jpg"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 200, 300)];;
    iv.contentMode = UIViewContentModeScaleAspectFill;
    
    //SD
    [iv sd_setImageWithURL:url];
    //AF
//    [iv setImageWithURL:url];
    
    [self.view addSubview:iv];
}

- (void)prepareUI {
    FLAnimatedImageView *gifImageView = [[FLAnimatedImageView alloc] init];
    FLAnimatedImage *image = [UIImage gifImageNamedFromBundle:@"Loading.gif"];
    gifImageView.animatedImage = image;
    
    UIImage *post = [UIImage imageWithCGImage:image.posterImage.CGImage scale:[UIScreen mainScreen].scale orientation:image.posterImage.imageOrientation];
    
    CGSize size = post.size;
    
    CGRect frame = gifImageView.frame;
    frame.size = size;
    frame.origin.y = 200;
    gifImageView.frame = frame;
    
    [self.view addSubview:gifImageView];
    
    NSString *imgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517916913&di=19ffe437bde3bcd7fbccc7402b5413bd&imgtype=jpg&er=1&src=http%3A%2F%2Fc4.haibao.cn%2Fimg%2F600_0_100_0%2F1504086079.9233%2F26419e83b548a522088d69cbef85ed6d.jpg";
    
    UIImageView *imageTest = [[UIImageView alloc] initWithFrame:CGRectMake(0, 350, 200, 200)];
    [imageTest sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamedFromBundle:@"defaultHeader"]];
    [self.view addSubview:imageTest];
}

- (void)ccc {
    NSString *path = [[NSBundle mainBundle] resourcePath];
//    NSString *imagePath = [path stringByAppendingPathComponent:@"resource.bundle"];
    NSString *imagePath;
//    imagePath = [path stringByAppendingString:@"/aaa.JPG"];
    imagePath = [path stringByAppendingString:@"/resource.bundle/images/mineHouse@2x.webp"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        NSLog(@"hello");
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (image) {
        NSLog(@"world");
    }
}

#pragma mark - SDWebImage

- (void)downloadImage {
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533807578493&di=ccc7658e7840b862a3d390c9f710ba24&imgtype=0&src=http%3A%2F%2Fent.yunnan.cn%2Fimages%2Fattachement%2Fjpg%2Fsite2%2F20171227%2F002324a0b89c1bad81c11e.jpg"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager loadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
    }];
    
}



#pragma mark - AFNetWorking

- (void)getDataFromNet {
    //    [self getWeatherDataWithBlock];
    
    //    [self getWeatherDataWithDelegate];
    
    //    [self downloadTask];
    
    //    [self getWeatherDataWithDelegate];
    
    [self testAFNetworkingGet];
    
    //    [self testAFNetworkingDownload];
}

- (void)testAFNetworkingGet {
    NSString *urlStr = @"https://djapi.daojia.com/api/guest/search/result/v3?uid=19118223&useCouponId=348847047736042600&control=1&channel=0&cid=-1&type=1&lat=39.9&rebuild=1&cityid=1&searchstr=%E4%BC%98%E6%83%A0%E5%88%B8&lng=116&sort=0&page=1";
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress: %@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@--%@", [responseObject class], responseObject);
        
        NSLog(@"---current: %@", [NSThread currentThread]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

- (void)testAFNetworkingDownload {
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533807578493&di=ccc7658e7840b862a3d390c9f710ba24&imgtype=0&src=http%3A%2F%2Fent.yunnan.cn%2Fimages%2Fattachement%2Fjpg%2Fsite2%2F20171227%2F002324a0b89c1bad81c11e.jpg"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPSessionManager *downloadManager = [AFHTTPSessionManager manager];
    
    [[downloadManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"download: %@", downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"url: %@", targetPath);
        
        NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *finalPath = [path stringByAppendingPathComponent:response.suggestedFilename];
        
        return [NSURL URLWithString:finalPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"url: %@", filePath);
    }] resume];
    

}

#pragma mark - AF
- (void)downloadTask {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533807578493&di=ccc7658e7840b862a3d390c9f710ba24&imgtype=0&src=http%3A%2F%2Fent.yunnan.cn%2Fimages%2Fattachement%2Fjpg%2Fsite2%2F20171227%2F002324a0b89c1bad81c11e.jpg"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"progress: %@", downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentDirectoryUrl = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentDirectoryUrl URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"File downloaded to: %@", filePath);
    }];
    
    [downloadTask resume];
}

#pragma mark - system
- (void)getWeatherDataWithBlock {
    NSURL *url = [NSURL URLWithString:@"https://www.sojson.com/open/api/weather/json.shtml?city=%E5%8C%97%E4%BA%AC"];
    
    NSMutableURLRequest *muRequest = [[NSMutableURLRequest alloc] initWithURL:url];
//    NSString *args = [NSString stringWithFormat:@"city=%@", @"%E5%8C%97%E4%BA%AC"];
//    muRequest.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
//    muRequest.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:muRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        NSLog(@"%@", dataDict.description);
        
    }];
    
    [sessionDataTask resume];
    
//    [sessionDataTask cancel];
}

- (void)getWeatherDataWithDelegate {
    NSURL *url = [NSURL URLWithString:@"https://www.sojson.com/open/api/weather/json.shtml?city=%E5%8C%97%E4%BA%AC"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSURLSessionConfiguration *configution = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configution delegate:self delegateQueue:queue];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    [task resume];
    
    
    //
//    NSURLSessionDownloadTask *downTask = [session downloadTaskWithResumeData:nil ];
//    NSURLSessionDownloadTaskResumeData
//    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:nil fromData:nil];
    
}

#pragma mark - NSURLSessionDataDelegate
// 1.接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    
    NSLog(@"receive");
}
//2.接收到服务器的数据
//AF转发
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"handle");
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
    
    NSLog(@"%@", dict.description);
    
}
//3.任务完成时调用
//AF转发
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"complete");
    if (error == nil) {
        
    }
    else {
        
    }
}

//AF转发
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
    
    NSLog(@"***protectionspace:%@", challenge.protectionSpace);
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    NSURL *url = [NSURL URLWithString:@"JumpTest://hello"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
    
    return;
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    /*
    NSURL *imgUrl = [NSURL URLWithString:@"https://user.daojia.com/user/getImgcode?mobile=13000000000"];
    
//    [self.imgView sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRefreshCached];
    
    NSData *data = [NSData dataWithContentsOfURL:imgUrl];
    [self.imgView setImage:[UIImage imageWithData:data]];
    
    //请求数据
    [self headerRefreshAction];*/
    
    
    self.VC = [[RankVC2 alloc] init];
//    self.VC.view.backgroundColor = [UIColor blueColor];
    
    //1.
//    [self addChildViewController:self.VC];
//    [self.view addSubview:self.VC.view];
//
//    [self.VC didMoveToParentViewController:self];
    
    //2.
    NSArray *aa = self.navigationController.viewControllers;
    
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回去" style:UIBarButtonItemStyleDone target:self action:@selector(reBack)];
    
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    self.navigationController.navigationItem.rightBarButtonItem = leftBtnItem;
    self.navigationItem.title = @"next";
    self.navigationController.navigationItem.title = @"nexxx";
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headIcon"]];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    
//    [self.navigationController pushViewController:self.VC animated:YES];
    
    //3.
    [self presentViewController:self.VC animated:YES completion:nil];
   
   
}

- (void)reBack {
    NSLog(@"reback");
}

#pragma mark rankTableView refresh
- (void)headerRefreshAction {
    [self.rankViewModel headerRefreshRequestWithCallBacl:^(NSArray *array) {
        [self.rankTableView.mj_header endRefreshing];
        
        self.rankTableViewDelegate.dataArray = [NSMutableArray arrayWithArray:array];
        
        [self.rankTableView reloadData];
    }];
}

- (void)footerRefreshAction {
    [self.rankViewModel headerRefreshRequestWithCallBacl:^(NSArray *array) {
        [self.rankTableView.mj_footer endRefreshing];
        
        [self.rankTableViewDelegate.dataArray addObjectsFromArray:array];
        
        [self.rankTableView reloadData];
    }];
}

#pragma mark lazy load
- (UITableView *)rankTableView {
    if (!_rankTableView) {
        _rankTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight + 50, screenWidth, 500) style:UITableViewStylePlain];
        
        _rankTableView.backgroundColor = ColorOfHex(0xf1f2f3);
        
        _rankTableView.dataSource = self.rankTableViewDelegate;
        _rankTableView.delegate = self.rankTableViewDelegate;
        
        _rankTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
        _rankTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
        
    }
    return _rankTableView;
}

- (RankViewModel *)rankViewModel {
    if (!_rankViewModel) {
        _rankViewModel = [[RankViewModel alloc] init];
    }
    return _rankViewModel;
}

- (RankTableViewDelegate *)rankTableViewDelegate {
    if (!_rankTableViewDelegate) {
        _rankTableViewDelegate = [[RankTableViewDelegate alloc] init];
    }
    return _rankTableViewDelegate;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 80, 30)];
        _imgView.backgroundColor = [UIColor blueColor];
    }
    return _imgView;
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
