//
//  WithdrawDepositViewController.m
//  柴火圈
//
//  Created by JOYSW on 16/7/13.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "WithdrawDepositViewController.h"
@interface WithdrawDepositViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tab;
    NSArray *_arr;
}
@end
@implementation WithdrawDepositViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"充值提现";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
    tab = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tab.delegate = self;
    tab.dataSource = self;
    tab.rowHeight = 44;
    tab.sectionFooterHeight = 10;
    tab.sectionHeaderHeight = 0;
    [self.view addSubview:tab];
    
    
    _arr = @[@"充值",@"提现",@"任意币"];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _arr[indexPath.row + indexPath.section*2];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//充值
            
        }else{//提现
            
        }
    }else{//任意币
        
    }
}




-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
