//
//  PersonalDataViewController.m
//  easyTrader
//
//  Created by JOYSW on 16/7/7.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "Header.h"
#import "HeadImageViewController.h"
#import "NickNameViewController.h"

@interface PersonalDataViewController()


@end

@implementation PersonalDataViewController

//-(void)viewWillLayoutSubviews
//{
//    [self.topView.userNameLabel removeFromSuperview];
//    [self.topView.headView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.topView.rightIcon.mas_left).offset(-10);
//        make.top.equalTo(self.topView.mas_top).offset(10);
//        make.bottom.equalTo(self.topView.mas_bottom).offset(-10);
//        make.width.mas_equalTo(self.topView.bounds.size.height-20);
//    }];
////
////    [self.myConsumptionView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
////        make.right.mas_equalTo(-10);
////        make.top.mas_equalTo((self.myConsumptionView.bounds.size.height-self.view.bounds.size.height/36)/2);
////        make.width.mas_equalTo(self.view.bounds.size.height/36);
////        make.height.mas_equalTo(self.view.bounds.size.height/36);
////    }];
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.nameLabel.text = LoginNickName;
  }


-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"个人资料";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, self.view.bounds.size.width, self.view.bounds.size.height/9)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(tap1Action:)];
    [topView addGestureRecognizer:tap1];
    
    UILabel *headlabel = [[UILabel alloc]init];
    headlabel.translatesAutoresizingMaskIntoConstraints = NO;
    headlabel.text = @"头像";
    [topView addSubview:headlabel];
    self.topView = [[UIImageView alloc]init];
    self.topView.image=[UIImage imageWithData:fetchFile];
    if (!self.topView.image)
    {
        self.topView.image =[UIImage imageNamed:@"headImage"];
    }

    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:self.topView];
    
    UIImageView *rightIcon = [[UIImageView alloc]init];
    rightIcon.image = [UIImage imageNamed:@"right"];
    rightIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:rightIcon];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(10);
        make.top.equalTo(topView.mas_top).offset(10);
        make.bottom.equalTo(topView.mas_bottom).offset(-10);
        make.width.mas_equalTo(100);
    }];
    
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-10);
        make.top.equalTo(topView.mas_top).offset((topView.frame.size.height/4*3)/2);
        make.width.mas_equalTo(topView.frame.size.height/4);
        make.height.mas_equalTo(topView.frame.size.height/4);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-topView.frame.size.height/4-20);
        make.top.equalTo(topView.mas_top).offset(10);
        make.bottom.equalTo(topView.mas_bottom).offset(-10);
        make.width.mas_equalTo(topView.frame.size.height-20);
    }];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/9+1, self.view.bounds.size.width, self.view.bounds.size.height/13)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(tap2Action:)];
    [bottomView addGestureRecognizer:tap2];
    [self.view addSubview:bottomView];
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.translatesAutoresizingMaskIntoConstraints = NO;
    namelabel.text = @"昵称";
    [bottomView addSubview:namelabel];
    
    self.nameLabel = [[UILabel alloc]init];
    
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:self.nameLabel];
    
    UIImageView *rightIcon1 = [[UIImageView alloc]init];
    rightIcon1.image = [UIImage imageNamed:@"right"];
    rightIcon1.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:rightIcon1];
    
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(10);
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        make.width.mas_equalTo(100);
    }];
    
    [rightIcon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-10);
        make.top.equalTo(bottomView.mas_top).offset((bottomView.bounds.size.height-self.view.frame.size.height/36)/2);
        make.width.mas_equalTo(self.view.frame.size.height/36);
        make.height.mas_equalTo(self.view.frame.size.height/36);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-bottomView.frame.size.height/4-20);
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        make.width.mas_equalTo(bottomView.frame.size.width/2);
    }];
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)tap1Action:(UITapGestureRecognizer *)tap
{
    HeadImageViewController *headVc = [[HeadImageViewController alloc]init];
    
    headVc.headerImageBlock=^(UIImage *headerImage){
    
        self.topView.image=headerImage;
        
        if (_personalDataBlock)
        {
            _personalDataBlock(headerImage);
        }
        
    };
    
    [self.navigationController pushViewController:headVc animated:NO];
    NSLog(@"1");
}

-(void)tap2Action:(UITapGestureRecognizer *)tap
{
    NickNameViewController *nameVc = [[NickNameViewController alloc]init];
    nameVc.textName = self.nameLabel.text;
    [self.navigationController pushViewController:nameVc animated:NO];
    NSLog(@"2");
}
#pragma mark 头像地址
- (NSString *)headerImgFilePathWithImgName{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"userHeader.png"];
    
//    NSLog(@"------=========%@",fullPathToFile);
    
    return fullPathToFile;
}


@end
