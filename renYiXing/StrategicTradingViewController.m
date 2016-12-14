//
//  StrategicTradingViewController.m
//  柴火圈
//
//  Created by JOYSW on 16/7/13.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "StrategicTradingViewController.h"

@implementation StrategicTradingViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"策略交易";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
    
    
    
    
    
    
    
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
