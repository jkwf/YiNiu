//
//  testHtmlViewController.m
//  easyTrader
//
//  Created by JOYSW on 16/7/8.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController
-(void)viewDidLoad
{
//    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
//    NSURL* url = [NSURL URLWithString:@"http://easytrader.joysw.cn/index.php/mobile/index/mlogin"];//创建URL
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
//    [web loadRequest:request];//加载
//    [self.view addSubview:web];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webview];
    //self.webview.delegate = self;
    //self.urlString = @"http://cs.yuanobao.com:8079/yla-data/static/wzry.html?aid=4f0a8dd6127e440e965b5212e893ba53";
    NSURL* url = [NSURL URLWithString:self.urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    self.webview.scalesPageToFit = YES;
    [self.webview loadRequest:request];
    
}

//返回按钮
-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSString *string = [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    NSLog(@"%@",string);
    return YES;
}
@end
