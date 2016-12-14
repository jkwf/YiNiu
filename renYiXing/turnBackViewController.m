//
//  turnBackViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/7/1.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "turnBackViewController.h"
#import "Header.h"

@implementation turnBackViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = [NSString stringWithFormat:@"%@",self.titleStr];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
    
    UIView *tempView = [[UIView alloc]init];
    tempView.backgroundColor = [UIColor whiteColor];
    tempView.translatesAutoresizingMaskIntoConstraints = NO;
    tempView.layer.cornerRadius = 5;
    [self.view addSubview:tempView];
    
    self.textBackField = [[UITextField alloc]init];
//    self.textBackField.backgroundColor = [UIColor redColor];
    if ([self.textFieldStr isEqualToString:@"请输入"])
    {
        self.textBackField.placeholder = [NSString stringWithFormat:@"%@%@",self.textFieldStr,self.titleStr];
    }
    else
    {
        self.textBackField.text = self.textFieldStr;
    }
    self.textBackField.translatesAutoresizingMaskIntoConstraints = NO;
    [tempView addSubview:self.textBackField];
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.cornerRadius = 5;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:78/255.0 green:179/255.0 blue:214/255.0 alpha:1.0]];
    saveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:saveBtn];
    
    [saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.textBackField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
    }];
    
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tempView.mas_left);
        make.right.equalTo(tempView.mas_right);
        make.top.equalTo(tempView.mas_bottom).offset(20);
        make.height.mas_equalTo(tempView.mas_height);
    }];
    
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)saveBtnAction
{
    //    当返回到第一个界面的时候 我们进行对本类的block回调
    //    本类的block实现 在第一个界面的类里面
    
    //    判断block 的实现是否存在 如果不存在 相当于为nil 我们则不进判断条件进行回调
    if (self.block != nil)
    {
        self.block(_textBackField.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
