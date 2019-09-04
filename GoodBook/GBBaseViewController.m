//
//  GBBaseViewController.m
//  GoodBook
//
//  Created by liuyang on 2018/11/7.
//  Copyright © 2018年 liuyang. All rights reserved.
//

#import "GBBaseViewController.h"
#import <WebKit/WebKit.h>

@interface GBBaseViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property(nonatomic, strong) WKUserContentController *userContentController;
@property(nonatomic, strong) WKWebView *mainWebView;
@property(nonatomic, strong) NSString *url;

@end

@implementation GBBaseViewController

- (instancetype)initWithUrl:(NSString *)urlStr {
    if (self = [super init]) {
        self.url = urlStr;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainWebView];
    
    //    native调用js方法
    //    [self.mainWebView evaluateJavaScript:@"jsTest" completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
    //
    //    }];
    
    //添加监听进度条的观察者
    [self.mainWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //不remove会造成内存泄漏
    [self.userContentController removeScriptMessageHandlerForName:@"jsTest"];
    
    [self.mainWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (void)dealloc {
    NSLog(@"GBBaseViewController dealloc");
}

//kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    //进度条
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        NSLog(@"pregress_%f", self.mainWebView.estimatedProgress);
    }
}

#pragma mark - custom function
- (void)loadRequest {
    if (self.url) {
        //加载url
        //        NSURL *url = [NSURL URLWithString:self.url];
        //        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //        [self.mainWebView loadRequest:request];
        
        //加载本地html
        [self.mainWebView loadHTMLString:self.url baseURL:nil];
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"start");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"返回内容");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"finish");
    
    [webView evaluateJavaScript:@"jsFinish()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"call jsFinish() error: %@", error);
        }
        else {
            NSLog(@"call jsFinish() success");
        }
    }];
    
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

//提交发生错误时调用
-  (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"fail");
}

//
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    
}

//https证书自定义处理, 不一定百分百会回调
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//}


#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"js call alert");
    
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(YES);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    completionHandler(prompt);
}

#pragma mark - WKScriptMessageHandler  js调用native方法的回调
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@_%@_%@", message.name, message.body, message.frameInfo);
}

#pragma mark - lazy load
- (WKWebView *)mainWebView {
    if (!_mainWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = self.userContentController;
        
        WKPreferences *preference = [[WKPreferences alloc] init];
        preference.minimumFontSize = 0;
        configuration.preferences = preference;
        
        _mainWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _mainWebView.navigationDelegate = self;
        _mainWebView.UIDelegate = self;
        _mainWebView.allowsBackForwardNavigationGestures = YES;
        
        //        WKBackForwardList *list = [_mainWebView backForwardList];
    }
    return _mainWebView;
}

- (WKUserContentController *)userContentController {
    if (!_userContentController) {
        _userContentController = [[WKUserContentController alloc] init];
        
        //注册一个name为jsTest的js方法，实现WKScriptMessageHandler协议
        //js调用window.webkit.messageHandlers.jsTest.postMessage('body');
        [_userContentController addScriptMessageHandler:self name:@"jsTest"];
    }
    return _userContentController;
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
