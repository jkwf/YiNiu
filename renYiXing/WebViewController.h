//
//  testHtmlViewController.h
//  easyTrader
//
//  Created by JOYSW on 16/7/8.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webview;

@property (nonatomic, strong)NSString *urlString;

@end
