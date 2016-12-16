//
//  TestViewController.h
//  AppRTC
//
//  Created by Longxun on 16/6/15.
//  Copyright © 2016年 ISBX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
@property(nonatomic, strong)UserInfo *personDic;
@property (nonatomic, strong)NSString  *toId;
@property (nonatomic, strong)NSString *roomId;
@property (nonatomic) BOOL iscall;
@property (nonatomic) BOOL isVideo;
@end
