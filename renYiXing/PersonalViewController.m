//
//  PersonalViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/30.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "PersonalViewController.h"
#import "Header.h"
#import "turnBackViewController.h"
#import "BodyCardImageViewController.h"

@interface PersonalViewController()
@property(nonatomic , strong)DiyView *nameView;
@property(nonatomic , strong)DiyView *genderView;
@property(nonatomic , strong)DiyView *phoneNumberView;
@property(nonatomic , strong)DiyView *mailView;
@property(nonatomic , strong)DiyView *myRecommandView;
@property(nonatomic , strong)DiyView *bodyCodeView;
@property(nonatomic , strong)DiyView *bankNameView;
@property(nonatomic , strong)DiyView *bankCardleView;
@property(nonatomic , strong)DiyView *bodyImgView;
@property(nonatomic , strong)UIImageView *manImageView;

@end
@implementation PersonalViewController

-(void)updatelayout:(DiyView *)diyView
{
    
    [diyView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(diyView.mas_right).offset(-10);
        make.top.mas_equalTo((diyView.bounds.size.height-self.view.bounds.size.height/36)/2);
        make.width.mas_equalTo(self.view.bounds.size.height/36);
        make.height.mas_equalTo(self.view.bounds.size.height/36);
    }];
    [diyView.headView removeFromSuperview];
    [diyView.userNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(diyView.mas_left).offset(20);
        make.width.mas_equalTo(diyView.bounds.size.width/2);
    }];
 

}

-(void)viewWillLayoutSubviews
{
//    [self.nameView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.nameView.mas_right).offset(-10);
//        make.top.mas_equalTo((self.nameView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
    [self updatelayout:self.nameView];
//    [self updatelayout:self.genderView];
    [self updatelayout:self.phoneNumberView];
    [self updatelayout:self.mailView];
    [self updatelayout:self.myRecommandView];
    [self updatelayout:self.bodyCodeView];
    [self updatelayout:self.bankCardleView];
    [self updatelayout:self.bankNameView];
    [self updatelayout:self.bodyImgView];
    [self.genderView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.genderView.mas_right).offset(-(20+self.view.bounds.size.height/36));
        make.top.mas_equalTo((self.genderView.bounds.size.height-self.view.bounds.size.height/36)/2);
        make.width.mas_equalTo(self.view.bounds.size.height/36);
        make.height.mas_equalTo(self.view.bounds.size.height/36);
    }];
    [self.genderView.headView removeFromSuperview];
    [self.genderView.userNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.genderView.mas_left).offset(20);
        make.width.mas_equalTo(self.genderView.bounds.size.width/3);
    }];
    [self.genderView.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.genderView.rightIcon.mas_left).offset(-10);
        make.top.equalTo(self.genderView.userNameLabel.mas_top);
        make.bottom.equalTo(self.genderView.userNameLabel.mas_bottom);
        make.width.mas_equalTo(20);
    }];

    
}
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"个人信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    self.nameView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.nameView.backgroundColor = [UIColor whiteColor];
    self.nameView.contentLabel.text = @"请输入";
    self.nameView.userNameLabel.text = @"姓名";
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.nameView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.nameView addGestureRecognizer:tap1];
    self.nameView.tag = 1001;
    
    
    self.genderView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15+1, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.genderView.backgroundColor = [UIColor whiteColor];
    self.genderView.rightIcon.image = [UIImage imageNamed:@"selected"];
    self.genderView.rightIcon.userInteractionEnabled = YES;
    self.genderView.userNameLabel.text = @"性别";
    self.genderView.contentLabel.text = @"男";
    self.genderView.contentLabel.textColor = [UIColor blackColor];
    self.genderView.contentLabel.textAlignment = NSTextAlignmentCenter;
    
    self.manImageView = [[UIImageView alloc]init];
    self.manImageView.image = [UIImage imageNamed:@"circle"];
//    manImageView.backgroundColor = [UIColor redColor];
    self.manImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.manImageView.userInteractionEnabled = YES;
    [self.genderView addSubview:self.manImageView];
    [self.manImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.genderView.contentLabel.mas_left).offset(-10);
        make.top.equalTo(self.genderView.rightIcon.mas_top);
        make.bottom.equalTo(self.genderView.rightIcon.mas_bottom);
        make.width.mas_equalTo(self.genderView.rightIcon.mas_width);
    }];
    
    
    UILabel *femanLabel = [[UILabel alloc]init];
    femanLabel.text = @"女";
//    femanLabel.backgroundColor = [UIColor redColor];
    femanLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.genderView addSubview:femanLabel];
    
    [femanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.genderView.mas_right).offset(-10);
        make.top.equalTo(self.genderView.rightIcon.mas_top);
        make.bottom.equalTo(self.genderView.rightIcon.mas_bottom);
        make.width.mas_equalTo(self.genderView.contentLabel.mas_width);
    }];
    
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.genderView];
    
    UITapGestureRecognizer *manSelected = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(manSelectedAction)];
    [self.manImageView addGestureRecognizer:manSelected];
    
    UITapGestureRecognizer *femanSelected = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(femanSelectedAction)];
    [self.genderView.rightIcon addGestureRecognizer:femanSelected];
    
    
    
    self.phoneNumberView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15*2+2, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.phoneNumberView.backgroundColor = [UIColor whiteColor];
    self.phoneNumberView.userNameLabel.text = @"手机号";
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.phoneNumberView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.phoneNumberView addGestureRecognizer:tap2];
    self.phoneNumberView.tag = 1002;
    
    self.mailView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15*3+3, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.mailView.backgroundColor = [UIColor whiteColor];
    self.mailView.userNameLabel.text = @"邮箱";
    self.mailView.contentLabel.text = @"请输入";
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.mailView];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.mailView addGestureRecognizer:tap3];
    self.mailView.tag = 1003;
    
    self.myRecommandView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15*4+4, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.myRecommandView.backgroundColor = [UIColor whiteColor];
    self.myRecommandView.userNameLabel.text = @"我的推荐人";
    self.myRecommandView.rightIcon.image = [UIImage imageNamed:@"white"];
    self.myRecommandView.contentLabel.text = @"潇洒哥";
    self.myRecommandView.contentLabel.textColor = [UIColor blackColor];
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.myRecommandView];
    
    self.bodyCodeView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15*5+4+10, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.bodyCodeView.backgroundColor = [UIColor whiteColor];
    self.bodyCodeView.userNameLabel.text = @"身份证号";
    self.bodyCodeView.contentLabel.text = @"请输入";
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bodyCodeView];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.bodyCodeView addGestureRecognizer:tap4];
    self.bodyCodeView.tag = 1004;
    
    self.bankNameView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15*6+5+10, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.bankNameView.backgroundColor = [UIColor whiteColor];
    self.bankNameView.userNameLabel.text = @"开户卡名称";
    self.bankNameView.contentLabel.text = @"请输入";
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bankNameView];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.bankNameView addGestureRecognizer:tap5];
    self.bankNameView.tag = 1005;
    
    self.bankCardleView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15*7+6+10, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.bankCardleView.backgroundColor = [UIColor whiteColor];
    self.bankCardleView.userNameLabel.text = @"银行卡号";
    self.bankCardleView.contentLabel.text = @"6224＊＊5642";
    self.bankCardleView.contentLabel.font = [UIFont systemFontOfSize:14];
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bankCardleView];
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.bankCardleView addGestureRecognizer:tap6];
    self.bankCardleView.tag = 1006;
    
    self.bodyImgView = [[DiyView alloc]initWithFrame:CGRectMake(0, 74+self.view.bounds.size.height/15*8+6+20, self.view.bounds.size.width, self.view.bounds.size.height/15)];
    self.bodyImgView.backgroundColor = [UIColor whiteColor];
    self.bodyImgView.userNameLabel.text = @"手持身份证照片";
    self.bodyImgView.contentLabel.text = @"未上传";
    //    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bodyImgView];
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.bodyImgView addGestureRecognizer:tap7];
    self.bodyImgView.tag = 1007;
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.layer.cornerRadius = 5;
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor colorWithRed:78/255.0 green:179/255.0 blue:214/255.0 alpha:1.0]];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.bodyImgView.mas_bottom).offset(30);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
//    [self.view layoutIfNeeded];
    
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    turnBackViewController *turnBackVc = [[turnBackViewController alloc]init];
    BodyCardImageViewController *bodyCardImageVc = [[BodyCardImageViewController alloc]init];
    __weak PersonalViewController *bs = self;
    turnBackVc.block = ^(NSString *string)
    {
//        bs.nameView.contentLabel.text = string;
        switch (tap.view.tag) {
            case 1001:
                bs.nameView.contentLabel.text = string;

                break;
            case 1002:
                bs.phoneNumberView.contentLabel.text = string;

                break;
            case 1003:
                bs.mailView.contentLabel.text = string;

                break;
            case 1004:
                bs.bodyCodeView.contentLabel.text = string;

                break;
            case 1005:
                bs.bankNameView.contentLabel.text = string;

                break;
            case 1006:
                bs.bankCardleView.contentLabel.text = string;
                break;
            
            default:
                break;
        }

    };
   
NSLog(@"%ld",tap.view.tag);
switch (tap.view.tag) {
    case 1001:
        turnBackVc.titleStr = @"姓名";
        turnBackVc.textFieldStr = self.nameView.contentLabel.text;
        [self.navigationController pushViewController:turnBackVc animated:NO];
        break;
    case 1002:
        turnBackVc.titleStr = @"手机号";
        turnBackVc.textFieldStr = self.phoneNumberView.contentLabel.text;
        [self.navigationController pushViewController:turnBackVc animated:NO ];
        break;
    case 1003:
        turnBackVc.titleStr = @"邮箱";
        turnBackVc.textFieldStr = self.mailView.contentLabel.text;
        [self.navigationController pushViewController:turnBackVc animated:NO ];
        break;
    case 1004:
        turnBackVc.titleStr = @"身份证号";
        turnBackVc.textFieldStr = self.bodyCodeView.contentLabel.text;
        [self.navigationController pushViewController:turnBackVc animated:NO ];
        break;
    case 1005:
        turnBackVc.titleStr = @"开户行卡号";
        turnBackVc.textFieldStr = self.bankNameView.contentLabel.text;
        [self.navigationController pushViewController:turnBackVc animated:NO ];
        break;
    case 1006:
        turnBackVc.titleStr = @"银行卡号";
        turnBackVc.textFieldStr = self.bankCardleView.contentLabel.text;
        [self.navigationController pushViewController:turnBackVc animated:NO ];
        break;
    case 1007:
        turnBackVc.titleStr = @"手持身份证照片";
        [self.navigationController pushViewController:bodyCardImageVc animated:NO ];
        break;
        
    default:
        break;
}
}


-(void)manSelectedAction
{
    self.manImageView.image = [UIImage imageNamed:@"selected"];
    self.genderView.rightIcon.image = [UIImage imageNamed:@"circle"];
    
}

-(void)femanSelectedAction
{
    self.manImageView.image = [UIImage imageNamed:@"circle"];
    self.genderView.rightIcon.image = [UIImage imageNamed:@"selected"];
    
}

-(void)submitBtnAction
{
    NSLog(@"确定");
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
