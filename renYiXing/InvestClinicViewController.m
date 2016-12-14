//
//  InvestClinicViewController.m
//  柴火圈
//
//  Created by JOYSW on 16/7/13.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "InvestClinicViewController.h"
#import <WebKit/WebKit.h>

@interface InvestClinicViewController()<WKNavigationDelegate>
@property(nonatomic , strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation InvestClinicViewController
-(void)viewDidLoad
{
//    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
//    //    self.navigationController.navigationBar.translucent = NO;
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    //    titleLabel.backgroundColor = [UIColor greenColor];
//    titleLabel.text = @"投资诊所";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = titleLabel;
//    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
//    
//    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
//    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
//    // 我们可以在WKScriptMessageHandler代理中接收到
//    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                      configuration:config];
//    NSURL *path = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://easytrader.joysw.cn/shejiao/html/Investment-clinic.html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
    [self.view addSubview:self.webView];
    
    // 导航代理
    self.webView.navigationDelegate = self;
//    // 与webview UI交互代理
//    self.webView.UIDelegate = self;
    
    // 添加KVO监听
//    [self.webView addObserver:self
//                   forKeyPath:@"loading"
//                      options:NSKeyValueObservingOptionNew
//                      context:nil];
//    [self.webView addObserver:self
//                   forKeyPath:@"title"
//                      options:NSKeyValueObservingOptionNew
//                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 添加进入条
//    self.progressView = [[UIProgressView alloc] init];
//    self.progressView.frame = self.view.bounds;
//    [self.view addSubview:self.progressView];
//    self.progressView.backgroundColor = [UIColor redColor];
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 2);
    // 设置进度条颜色
    [_progressView setTrackTintColor:[UIColor whiteColor]];
    _progressView.progressTintColor = [UIColor blueColor];
    [self.view addSubview:_progressView];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(gofarward)];

    
    
    
}

- (void)goback {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)gofarward {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

// 计算webView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.webView.frame;
                rect.origin.y = 0;
                self.webView.frame = rect;
            }];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
    NSLog(@"开始加载的时候调用。。");
    NSLog(@"%lf",   self.webView.estimatedProgress);
    
    
    
}

// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
