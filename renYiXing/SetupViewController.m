//
//  SetupViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/30.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "SetupViewController.h"
#import "SDAutoLayout.h"
#import "UIView+SDExtension.h"
#import "MainViewController.h"
@interface SetupViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation SetupViewController

-(void)viewDidLoad
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor gainsboroColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    _dataArray=@[@"修改密码",@"新消息提醒",@"数据清除"];
    [self tableView];
}

#pragma mark  -- 创建tableView ----
-(UITableView*)tableView
{

    if (!_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64,self.view.sd_width, 200) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.rowHeight=40;
        _tableView.scrollEnabled=NO;
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor=[UIColor darkGrayColor];
    }
    
    cell.textLabel.text=[_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            NSLog(@"修改密码");
            break;
        case 1:
              NSLog(@"新消息提醒");
            break;
        case 2:
              NSLog(@"数据清除");
            break;
            
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 20;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.sd_width, 80)];
    backView.backgroundColor=[UIColor gainsboroColor];
    UIButton *logoutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame=CGRectMake(0,10, self.view.sd_width, 50);
    [logoutBtn setTitle:@"注销登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    logoutBtn.backgroundColor=[UIColor whiteColor];
    [logoutBtn addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:logoutBtn];
    return backView;
    
}

#pragma mark    --  注销登录    --
-(void)logoutClick:(UIButton *)sender
{

    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userID"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"nickName"];
    
    MainViewController *mainVC=[[MainViewController alloc]init];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:mainVC];
    ApplicationDelegate.window.rootViewController=navigation;
    NSLog(@"注销登录");
    
}

@end
