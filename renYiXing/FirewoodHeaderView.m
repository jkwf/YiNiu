//
//  FirewoodHeaderView.m
//  柴火圈
//
//  Created by JOYSW on 16/7/14.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "FirewoodHeaderView.h"
#import "Masonry.h"

//static NSInteger height = [[UIScreen mainScreen]bounds].size.height/12;
@implementation FirewoodHeaderView
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSInteger height = [[UIScreen mainScreen]bounds].size.height/10;
        self.contentView.backgroundColor = [UIColor whiteColor];

        self.RecentContactsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.RecentContactsBtn setImage:[UIImage imageNamed:@"circle1"] forState:UIControlStateNormal];
        self.RecentContactsBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.RecentContactsBtn];
        
        UILabel *recentContactsLabel = [[UILabel alloc]init];
        recentContactsLabel.text = @"最近联系人";
        recentContactsLabel.font = [UIFont systemFontOfSize:10];
        recentContactsLabel.textAlignment = NSTextAlignmentCenter;
        recentContactsLabel.textColor = [UIColor grayColor];
        recentContactsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:recentContactsLabel];
        
        self.StockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.StockBtn setImage:[UIImage imageNamed:@"circle2"] forState:UIControlStateNormal];
        self.StockBtn.backgroundColor = [UIColor blueColor];
        self.StockBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.StockBtn];
        
        UILabel *stockLabel = [[UILabel alloc]init];
        stockLabel.text = @"股票圈";
        stockLabel.font = [UIFont systemFontOfSize:10];
        stockLabel.textAlignment = NSTextAlignmentCenter;
        stockLabel.textColor = [UIColor grayColor];
        stockLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:stockLabel];
        
        self.FuturesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.FuturesBtn setImage:[UIImage imageNamed:@"circle3"] forState:UIControlStateNormal];
        self.FuturesBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.FuturesBtn];
        
        UILabel *futuresLabel = [[UILabel alloc]init];
        futuresLabel.text = @"期货圈";
        futuresLabel.font = [UIFont systemFontOfSize:10];
        futuresLabel.textAlignment = NSTextAlignmentCenter;
        futuresLabel.textColor = [UIColor grayColor];
        futuresLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:futuresLabel];
        
        self.OutsideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.OutsideBtn setImage:[UIImage imageNamed:@"circle4"] forState:UIControlStateNormal];
        self.OutsideBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.OutsideBtn];
        
        UILabel *outsideLabel = [[UILabel alloc]init];
        outsideLabel.text = @"外盘圈";
        outsideLabel.font = [UIFont systemFontOfSize:10];
        outsideLabel.textAlignment = NSTextAlignmentCenter;
        outsideLabel.textColor = [UIColor grayColor];
        outsideLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:outsideLabel];
        
        self.StrategyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.StrategyBtn setImage:[UIImage imageNamed:@"circle5"] forState:UIControlStateNormal];
        self.StrategyBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.StrategyBtn];
        
        UILabel *strategyLabel = [[UILabel alloc]init];
        strategyLabel.text = @"策略圈";
        strategyLabel.font = [UIFont systemFontOfSize:10];
        strategyLabel.textAlignment = NSTextAlignmentCenter;
        strategyLabel.textColor = [UIColor grayColor];
        strategyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:strategyLabel];
        
        self.BugBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.BugBtn setImage:[UIImage imageNamed:@"circle6"] forState:UIControlStateNormal];
        self.BugBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.BugBtn];
        
        UILabel *bugLabel = [[UILabel alloc]init];
        bugLabel.text = @"BUG反馈圈";
        bugLabel.font = [UIFont systemFontOfSize:10];
        bugLabel.textAlignment = NSTextAlignmentCenter;
        bugLabel.textColor = [UIColor grayColor];
        bugLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:bugLabel];
        
        self.StrategyAdviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.StrategyAdviceBtn setImage:[UIImage imageNamed:@"circle7"] forState:UIControlStateNormal];
        self.StrategyAdviceBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.StrategyAdviceBtn];
        
        UILabel *strategyAdviceLabel = [[UILabel alloc]init];
        strategyAdviceLabel.text = @"策略建议圈";
        strategyAdviceLabel.font = [UIFont systemFontOfSize:10];
        strategyAdviceLabel.textAlignment = NSTextAlignmentCenter;
        strategyAdviceLabel.textColor = [UIColor grayColor];
        strategyAdviceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:strategyAdviceLabel];
        
        self.myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.myBtn setImage:[UIImage imageNamed:@"circle8"] forState:UIControlStateNormal];
        self.myBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.myBtn];
        
        UILabel *myLabel = [[UILabel alloc]init];
        myLabel.text = @"我的圈";
        myLabel.font = [UIFont systemFontOfSize:10];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.textColor = [UIColor grayColor];
        myLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:myLabel];
        
        self.CustomerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.CustomerBtn setImage:[UIImage imageNamed:@"circle9"] forState:UIControlStateNormal];
        self.CustomerBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.CustomerBtn];
        
        UILabel *customerLabel = [[UILabel alloc]init];
        customerLabel.text = @"客户圈";
        customerLabel.font = [UIFont systemFontOfSize:10];
        customerLabel.textAlignment = NSTextAlignmentCenter;
        customerLabel.textColor = [UIColor grayColor];
        customerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:customerLabel];
        
        [self.RecentContactsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.width.mas_equalTo(height);
            make.height.mas_equalTo(height);
        }];
        
        [recentContactsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.RecentContactsBtn.mas_left);
            make.right.equalTo(self.RecentContactsBtn.mas_right);
            make.top.equalTo(self.RecentContactsBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.StockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.RecentContactsBtn.mas_right).offset(([[UIScreen mainScreen]bounds].size.width-40-height*3)/2);
            make.top.equalTo(self.RecentContactsBtn.mas_top);
            make.bottom.equalTo(self.RecentContactsBtn.mas_bottom);
            make.width.mas_equalTo(height);
        }];
        
        [stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.StockBtn.mas_left);
            make.right.equalTo(self.StockBtn.mas_right);
            make.top.equalTo(self.StockBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.FuturesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.RecentContactsBtn.mas_top);
            make.bottom.equalTo(self.RecentContactsBtn.mas_bottom);
            make.width.mas_equalTo(height);
        }];
        
        [futuresLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.FuturesBtn.mas_left);
            make.right.equalTo(self.FuturesBtn.mas_right);
            make.top.equalTo(self.FuturesBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.OutsideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.RecentContactsBtn.mas_left);
            make.top.equalTo(recentContactsLabel.mas_bottom).offset(10);
            make.right.equalTo(self.RecentContactsBtn.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        [outsideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.OutsideBtn.mas_left);
            make.right.equalTo(self.OutsideBtn.mas_right);
            make.top.equalTo(self.OutsideBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.StrategyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.StockBtn.mas_left);
            make.top.equalTo(self.OutsideBtn.mas_top);
            make.right.equalTo(self.StockBtn.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        [strategyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.StrategyBtn.mas_left);
            make.right.equalTo(self.StrategyBtn.mas_right);
            make.top.equalTo(self.StrategyBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.BugBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.FuturesBtn.mas_left);
            make.top.equalTo(self.OutsideBtn.mas_top);
            make.right.equalTo(self.FuturesBtn.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        [bugLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.BugBtn.mas_left);
            make.right.equalTo(self.BugBtn.mas_right);
            make.top.equalTo(self.BugBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.StrategyAdviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.RecentContactsBtn.mas_left);
            make.top.equalTo(outsideLabel.mas_bottom).offset(10);
            make.right.equalTo(self.RecentContactsBtn.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        [strategyAdviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.StrategyAdviceBtn.mas_left);
            make.right.equalTo(self.StrategyAdviceBtn.mas_right);
            make.top.equalTo(self.StrategyAdviceBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.myBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.StockBtn.mas_left);
            make.top.equalTo(self.StrategyAdviceBtn.mas_top);
            make.right.equalTo(self.StockBtn.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.myBtn.mas_left);
            make.right.equalTo(self.myBtn.mas_right);
            make.top.equalTo(self.myBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        [self.CustomerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.FuturesBtn.mas_left);
            make.top.equalTo(self.StrategyAdviceBtn.mas_top);
            make.right.equalTo(self.FuturesBtn.mas_right);
            make.height.mas_equalTo(height);
        }];
        
        [customerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.CustomerBtn.mas_left);
            make.right.equalTo(self.CustomerBtn.mas_right);
            make.top.equalTo(self.CustomerBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
//        self.RecentContactsView = [[DiyView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height/9)];
//        self.RecentContactsView.backgroundColor = [UIColor whiteColor];
//        self.RecentContactsView.headView.image = [UIImage imageNamed:@"zuijin"];
//        self.RecentContactsView.userNameLabel.text = @"最近联系人";
//        [self.RecentContactsView.rightIcon removeFromSuperview];
//        [self.contentView addSubview:self.RecentContactsView];
//        
//        self.teacherView = [[DiyView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen]bounds].size.height/9+1, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height/9)];
//        self.teacherView.backgroundColor = [UIColor whiteColor];
//        self.teacherView.headView.image = [UIImage imageNamed:@"daoshiquan"];
//        self.teacherView.userNameLabel.text = @"导师圈";
//        [self.teacherView.rightIcon removeFromSuperview];
//        [self.contentView addSubview:self.teacherView];
//        
//        self.myView = [[DiyView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen]bounds].size.height/9*2+2, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height/9)];
//        self.myView.backgroundColor = [UIColor whiteColor];
//        self.myView.headView.image = [UIImage imageNamed:@"wodequan"];
//        self.myView.userNameLabel.text = @"我的圈";
//        [self.myView.rightIcon removeFromSuperview];
//        [self.contentView addSubview:self.myView];
//        
//        self.customerView = [[DiyView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen]bounds].size.height/9*3+3, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height/9)];
//        self.customerView.backgroundColor = [UIColor whiteColor];
//        self.customerView.headView.image = [UIImage imageNamed:@"kehu"];
//        self.customerView.userNameLabel.text = @"客户圈";
//        [self.customerView.rightIcon removeFromSuperview];
//        [self.contentView addSubview:self.customerView];
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height/9*4+14, [[UIScreen mainScreen]bounds].size.width, 30)];
        tempLabel.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
        tempLabel.text = @"  联系人";
        tempLabel.textAlignment = NSTextAlignmentLeft;
        tempLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:tempLabel];
    }
    return self;
}
@end
