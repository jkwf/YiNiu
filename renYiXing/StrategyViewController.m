//
//  StrategyViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/30.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "StrategyViewController.h"
#import "Header.h"

@interface StrategyViewController()
@property(nonatomic , strong)UILabel *balanceLabel;
@property(nonatomic , strong)UILabel *canBalanceLabel;
@end

@implementation StrategyViewController
-(void)viewDidLoad
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"策略宝";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
    
    UIView *yueView = [[UIView alloc]init];
    yueView.backgroundColor = [UIColor colorWithRed:253/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    yueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:yueView];
    
    UILabel *firstlabel = [[UILabel alloc]init];
    firstlabel.text = @"余额（元）";
    firstlabel.textColor = [UIColor whiteColor];
    firstlabel.translatesAutoresizingMaskIntoConstraints = NO;
    [yueView addSubview:firstlabel];
    
    self.balanceLabel = [[UILabel alloc]init];
    self.balanceLabel.text = @"450000";
    self.balanceLabel.textColor = [UIColor whiteColor];
    self.balanceLabel.font = [UIFont systemFontOfSize:45];
    [yueView addSubview:self.balanceLabel];
    
    UIView *yueCanView = [[UIView alloc]init];
//    yueCanView.backgroundColor = [UIColor colorWithRed:253/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    yueCanView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:yueCanView];
    
    UILabel *secondlabel = [[UILabel alloc]init];
    secondlabel.text = @"可用余额（元）";
    secondlabel.textColor = [UIColor blackColor];
    secondlabel.translatesAutoresizingMaskIntoConstraints = NO;
    [yueCanView addSubview:secondlabel];
    
    self.canBalanceLabel = [[UILabel alloc]init];
    self.canBalanceLabel.text = @"400000.00";
    self.canBalanceLabel.textColor = [UIColor colorWithRed:253/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    self.canBalanceLabel.font = [UIFont systemFontOfSize:30];
    [yueCanView addSubview:self.canBalanceLabel];

    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    [yueCanView addSubview:lineView];
    
    
    UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [eyeBtn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"shut"] forState:UIControlStateSelected];
//    eyeBtn.backgroundColor = [UIColor redColor];
    eyeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [eyeBtn addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeBtn];
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor: [UIColor colorWithRed:53/255.0 green:154/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
    rechargeBtn.backgroundColor = [UIColor colorWithRed:49/255.0 green:54/255.0 blue:59/255.0 alpha:1.0];
    rechargeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [rechargeBtn addTarget:self action:@selector(rechargeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rechargeBtn];
    
    UIButton *ransomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ransomBtn setTitle:@"赎回" forState:UIControlStateNormal];
    [ransomBtn setTitleColor:[UIColor colorWithRed:53/255.0 green:154/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
    ransomBtn.backgroundColor = [UIColor colorWithRed:49/255.0 green:54/255.0 blue:59/255.0 alpha:1.0];
    ransomBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [ransomBtn addTarget:self action:@selector(ransomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ransomBtn];
    
    [yueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.mas_equalTo(self.view.bounds.size.height/3);
    }];
    
    [firstlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueView.mas_left).offset(10);
        make.right.equalTo(yueView.mas_right);
        make.top.equalTo(yueView.mas_top).offset(30);
        make.height.mas_equalTo(self.view.bounds.size.height/16);
        
    }];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueView.mas_left).offset(10);
        make.right.equalTo(yueView.mas_right);
        make.top.equalTo(firstlabel.mas_top).offset(30);
        make.height.mas_equalTo(self.view.bounds.size.height/6);
    }];
    
    [yueCanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(yueView.mas_bottom);
        make.height.mas_equalTo(self.view.bounds.size.height/3);
    }];
    
    [secondlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueCanView.mas_left).offset(10);
        make.right.equalTo(yueCanView.mas_right);
        make.top.equalTo(yueCanView.mas_top).offset(30);
        make.height.mas_equalTo(self.view.bounds.size.height/16);
        
    }];
    
    [self.canBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueCanView.mas_left).offset(10);
        make.right.equalTo(yueCanView.mas_right);
        make.top.equalTo(secondlabel.mas_top).offset(30);
        make.height.mas_equalTo(self.view.bounds.size.height/6);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueCanView.mas_left);
        make.right.equalTo(yueCanView.mas_right);
        make.bottom.equalTo(yueCanView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(yueCanView.mas_bottom).offset(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(self.view.bounds.size.width/2);
        make.height.mas_equalTo(self.view.bounds.size.height/10);
    }];
    
    [ransomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(rechargeBtn.mas_top);
        make.bottom.equalTo(rechargeBtn.mas_bottom);
        make.width.mas_equalTo(rechargeBtn.mas_width);
    }];
    
}

-(void)eyeBtnAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(btn.selected)
    {
        self.canBalanceLabel.text = @"******";
    }
    else
    {
        self.canBalanceLabel.text = @"400000.00";
    }
}

-(void)rechargeBtnAction:(UIButton *)btn
{
    NSLog(@"充值");
}

-(void)ransomBtnAction:(UIButton *)btn
{
    NSLog(@"赎回");
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
