//
//  FirewoodDetailViewController.m
//  柴火圈
//
//  Created by JOYSW on 16/7/14.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "FirewoodDetailViewController.h"
#import "Masonry.h"


@interface FirewoodDetailViewController()
@property(nonatomic ,strong)UIImageView *headerImageView;
@property(nonatomic , strong)UILabel *userNameLabel;


@end

@implementation FirewoodDetailViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"详细信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topView];
    
    self.headerImageView = [[UIImageView alloc]init];
//    self.headerImageView.backgroundColor = [UIColor orangeColor];
    self.headerImageView.image = [UIImage imageNamed:self.model.headImageName];
    self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:self.headerImageView];
    
    self.userNameLabel = [[UILabel alloc]init];
//    self.userNameLabel.backgroundColor = [UIColor cyanColor];
    self.userNameLabel.text = self.model.userName;
    self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:self.userNameLabel];
    
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:secondView];
    
    UILabel *secondLabel = [[UILabel alloc]init];
    secondLabel.text = @"昵称:";
    secondLabel.textAlignment = NSTextAlignmentLeft;
    secondLabel.translatesAutoresizingMaskIntoConstraints= NO;
    [secondView addSubview:secondLabel];
    
    UILabel *nickNameLabel = [[UILabel alloc]init];
    nickNameLabel.text = self.model.nickName;
    nickNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [secondView addSubview:nickNameLabel];
    
    
    UIView *thirdView = [[UIView alloc]init];
    thirdView.backgroundColor = [UIColor whiteColor];
    thirdView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:thirdView];
    
    UILabel *thirdLabel = [[UILabel alloc]init];
    thirdLabel.text = @"性别：";
    thirdLabel.textAlignment = NSTextAlignmentLeft;
    thirdLabel.translatesAutoresizingMaskIntoConstraints= NO;
    [thirdView addSubview:thirdLabel];
    
    UILabel *genderLabel = [[UILabel alloc]init];
    genderLabel.text = @"男";
    genderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [thirdView addSubview:genderLabel];
    
    
    UIView *forthView = [[UIView alloc]init];
    forthView.backgroundColor = [UIColor whiteColor];
    forthView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:forthView];
    
    UILabel *forthLabel = [[UILabel alloc]init];
    forthLabel.text = @"手机号：";
    forthLabel.textAlignment = NSTextAlignmentLeft;
    forthLabel.translatesAutoresizingMaskIntoConstraints= NO;
    [forthView addSubview:forthLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"13000000000";
    phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [forthView addSubview:phoneLabel];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setTitle:@"发消息" forState:UIControlStateNormal];
    messageBtn.backgroundColor = [UIColor colorWithRed:42/255.0 green:202/255.0  blue:51/255.0  alpha:1.0];
    messageBtn.layer.cornerRadius = 5;
    [messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    messageBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:messageBtn];
    [messageBtn addTarget:self action:@selector(messageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(74);
        make.height.mas_equalTo(self.view.bounds.size.height/9);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(10);
        make.top.equalTo(topView.mas_top).offset(10);
        make.bottom.equalTo(topView.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.view.bounds.size.height/9-20);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(20);
        make.top.equalTo(self.headerImageView.mas_top);
        make.bottom.equalTo(self.headerImageView.mas_bottom);
        make.width.mas_equalTo(self.view.bounds.size.width/2);
    }];
    
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondView.mas_left).offset(10);
        make.top.equalTo(secondView.mas_top).offset(10);
        make.bottom.equalTo(secondView.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.view.bounds.size.height/8);
    }];
    
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondLabel.mas_right).offset(20);
        make.top.equalTo(secondLabel.mas_top);
        make.bottom.equalTo(secondLabel.mas_bottom);
        make.width.mas_equalTo(self.view.bounds.size.width/2);
    }];
    
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(secondView.mas_bottom).offset(10);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdView.mas_left).offset(10);
        make.top.equalTo(thirdView.mas_top).offset(10);
        make.bottom.equalTo(thirdView.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.view.bounds.size.height/8);
    }];
    
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdLabel.mas_right).offset(20);
        make.top.equalTo(thirdLabel.mas_top);
        make.bottom.equalTo(thirdLabel.mas_bottom);
        make.width.mas_equalTo(self.view.bounds.size.width/2);
    }];
    
    [forthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(thirdView.mas_bottom).offset(10);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    [forthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(forthView.mas_left).offset(10);
        make.top.equalTo(forthView.mas_top).offset(10);
        make.bottom.equalTo(forthView.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.view.bounds.size.height/8);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(forthLabel.mas_right).offset(20);
        make.top.equalTo(forthLabel.mas_top);
        make.bottom.equalTo(forthLabel.mas_bottom);
        make.width.mas_equalTo(self.view.bounds.size.width/2);
    }];
    
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.view.mas_bottom).offset(-self.view.bounds.size.height/6);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    
}

-(void)messageBtnAction:(UIButton *)btn
{
//    XYChatViewController *chatVC = [[XYChatViewController alloc] init];
//    /** push进去后隐藏tabBar */
//    chatVC.hidesBottomBarWhenPushed = YES;
//    chatVC.conversationID = self.userNameLabel.text;
//    [self.navigationController pushViewController:chatVC animated:YES];
    NSLog(@"123");
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
