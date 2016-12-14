//
//  FirstViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "FirstViewController.h"
#import "HomeViewController.h"
#import "OptionalViewController.h"
#import "QuotationViewController.h"
#import "TransactionViewController.h"
#import "device.h"
#import "DIYButton.h"
#import "BackBtn.h"

@interface FirstViewController (){
    UILabel *_titleLabel;
}



@property(nonatomic,strong)HomeViewController *homeVc;
@property(nonatomic , strong)OptionalViewController *optionalVc;
@property(nonatomic , strong)QuotationViewController *quotationVc;
@property(nonatomic , strong)TransactionViewController *transactionVc;
@property(nonatomic , strong)DIYButton *homeBtn;
@property(nonatomic , strong)DIYButton *optionalBtn;
@property(nonatomic , strong)DIYButton *quotationBtn;
@property(nonatomic , strong)DIYButton *transactionBtn;
@property(nonatomic , strong)UIView *leftTabBarView;
@end

@implementation FirstViewController


// 添加子控制器方法
- (void)addChildController
{
    // 添加主页界面控制器
    self.homeVc = [[HomeViewController alloc] init];
    [self addChildViewController:self.homeVc];  // 把主页控制器添加到主控制器内
    self.homeVc.view.frame = CGRectMake(0,64, KSWidth, KSHeight-64-49);
    //    self.recommandVC.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_homeVc.view];
    
    // 添加界面控制器
    self.optionalVc = [[OptionalViewController alloc] init];
    [self addChildViewController:_optionalVc];  // 把控制器添加到主控制器内
    self.optionalVc.view.frame = CGRectMake(0, 64, KSWidth, KSHeight-64-49);
//    self.chartsVC.view.backgroundColor = [UIColor whiteColor];
    // 暂时先不隐藏 看后期效果
    self.optionalVc.view.hidden = YES;
    [self.view addSubview:_optionalVc.view];
    
    // 添加界面控制器
    self.quotationVc = [[QuotationViewController alloc] init];
    [self addChildViewController:_quotationVc];  // 把控制器添加到主控制器内
    self.quotationVc.view.frame = CGRectMake(0, 64, KSWidth, KSHeight-64-49);
//    self.livingVC.view.backgroundColor = [UIColor greenColor];
    // 暂时先不隐藏 看后期效果
    self.quotationVc.view.hidden = YES;
    [self.view addSubview:_quotationVc.view];
    
    // 添加界面控制器
    self.transactionVc = [[TransactionViewController alloc] init];
    [self addChildViewController:_transactionVc];
    self.transactionVc.view.frame = CGRectMake(0, 64, KSWidth, KSHeight-64-49);
//    self.forumVC.view.backgroundColor = [UIColor blueColor];
    // 暂时先不隐藏 看后期效果
    self.transactionVc.view.hidden = YES;
    [self.view addSubview:_transactionVc.view];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
//    隐藏返回按钮
//    self.navigationItem.hidesBackButton = YES;
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
    self.navigationItem.leftBarButtonItem = nil;
    
    self.title = @"柴火圈";
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    _titleLabel.text =  @"柴火圈";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = _titleLabel;
    
    self.homeBtn = [DIYButton buttonWithType:UIButtonTypeCustom];
    self.homeBtn.frame = CGRectMake(0, KSHeight-49, KSWidth/4, 49);
    self.homeBtn.textLable.text = @"首页";
    self.homeBtn.textLable.textColor = [UIColor cyanColor];
    //    self.recommandBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.homeBtn.iconImageView.image = [UIImage imageNamed:@"tab1-2"];
    self.homeBtn.selectIconImageView.image = [UIImage imageNamed:@"tab1-1"];
    [self.homeBtn addTarget:self action:@selector(homeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.homeBtn];
    
    self.optionalBtn = [DIYButton buttonWithType:UIButtonTypeCustom];
    self.optionalBtn.frame = CGRectMake(KSWidth/4, KSHeight-49, KSWidth/4, 49);
    self.optionalBtn.textLable.text = @"自选";
    self.optionalBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.optionalBtn.iconImageView.image = [UIImage imageNamed:@"tab2-1"];
    self.optionalBtn.selectIconImageView.image = [UIImage imageNamed:@"tab2-2"];
    [self.optionalBtn addTarget:self action:@selector(optionalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    self.chartsBtn.hidden = YES;
    [self.view addSubview:self.optionalBtn];

    self.quotationBtn = [DIYButton buttonWithType:UIButtonTypeCustom];
    self.quotationBtn.frame = CGRectMake(KSWidth/2, KSHeight-49, KSWidth/4, 49);
    self.quotationBtn.textLable.text = @"行情";
    self.quotationBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.quotationBtn.iconImageView.image = [UIImage imageNamed:@"tab3-1"];
    self.quotationBtn.selectIconImageView.image = [UIImage imageNamed:@"tab3-2"];
    [self.quotationBtn addTarget:self action:@selector(quotationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    self.chartsBtn.hidden = YES;
    [self.view addSubview:self.quotationBtn];
    
    self.transactionBtn = [DIYButton buttonWithType:UIButtonTypeCustom];
    self.transactionBtn.frame = CGRectMake(KSWidth/4*3, KSHeight-49, KSWidth/4, 49);
    self.transactionBtn.textLable.text = @"交易";
    self.transactionBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.transactionBtn.iconImageView.image = [UIImage imageNamed:@"tab4-1"];
    self.transactionBtn.selectIconImageView.image = [UIImage imageNamed:@"tab4-2"];
    [self.transactionBtn addTarget:self action:@selector(transactionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    self.chartsBtn.hidden = YES;
    [self.view addSubview:self.transactionBtn];
    
    [self addChildController];
    
    
}
-(void)leftBarButtonAction
{
//    //注销用户
//    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)homeBtnAction:(DIYButton *)btn
{
    self.homeBtn.selected = NO;
    self.optionalBtn.selected = NO;
    self.quotationBtn.selected = NO;
    self.transactionBtn.selected = NO;
    self.homeBtn.textLable.textColor = [UIColor cyanColor];
    self.optionalBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.quotationBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.transactionBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.homeVc.view.hidden = NO;
    self.optionalVc.view.hidden = YES;
    self.quotationVc.view.hidden = YES;
    self.transactionVc.view.hidden = YES;
    
    _titleLabel.text = @"柴火圈";
    
    
}

-(void)optionalBtnAction:(DIYButton *)btn{
    
    self.homeBtn.selected = YES;
    self.optionalBtn.selected = YES;
    self.quotationBtn.selected = NO;
    self.transactionBtn.selected = NO;
    self.homeBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.optionalBtn.textLable.textColor = [UIColor cyanColor];
    self.quotationBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.transactionBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.homeVc.view.hidden = YES;
    self.optionalVc.view.hidden = NO;
    self.quotationVc.view.hidden = YES;
    self.transactionVc.view.hidden = YES;
    _titleLabel.text = @"自选";
}

-(void)quotationBtnAction:(DIYButton *)btn
{
        self.homeBtn.selected =YES;
    self.optionalBtn.selected = NO;
    self.quotationBtn.selected = YES;
    self.transactionBtn.selected = NO;
    self.homeBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.optionalBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.quotationBtn.textLable.textColor = [UIColor cyanColor];
    self.transactionBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.homeVc.view.hidden = YES;
    self.optionalVc.view.hidden = YES;
    self.quotationVc.view.hidden = NO;
    self.transactionVc.view.hidden = YES;
    _titleLabel.text = @"行情";
}

-(void)transactionBtnAction:(DIYButton *)btn
{
    self.homeBtn.selected = YES;
    self.optionalBtn.selected = NO;
    self.quotationBtn.selected = NO;
    self.transactionBtn.selected = YES;
    self.homeBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.optionalBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.quotationBtn.textLable.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    self.transactionBtn.textLable.textColor = [UIColor cyanColor];
    self.homeVc.view.hidden = YES;
    self.optionalVc.view.hidden = YES;
    self.quotationVc.view.hidden = YES;
    self.transactionVc.view.hidden = NO;
    _titleLabel.text = @"交易";
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
