//
//  ForgetPasswordViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/7/5.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "Header.h"
#import "ForgetPasswordNextViewController.h"

@interface ForgetPasswordViewController()<UITextFieldDelegate>
@property(nonatomic , strong)UITextField *phoneNumTextField;
@property(nonatomic , strong)UITextField *verificationCodeTextField;
@property(nonatomic , strong)UIButton *submitBtn;

@end
@implementation ForgetPasswordViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"忘记密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIView *firstView = [[UIView alloc]init];
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
    self.phoneNumTextField = [[UITextField alloc]init];
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.translatesAutoresizingMaskIntoConstraints= NO;
    self.phoneNumTextField.placeholder = @"请输入注册账号的手机号码";
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.phoneNumTextField.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.phoneNumTextField];
    
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:secondView];
    
    self.verificationCodeTextField = [[UITextField alloc]init];
    self.verificationCodeTextField.delegate = self;
//    纯数字键盘
//    self.verificationCodeTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.verificationCodeTextField.backgroundColor = [UIColor redColor];
    self.verificationCodeTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.verificationCodeTextField.placeholder = @"请输入验证码";
    [self.view addSubview:self.verificationCodeTextField];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [submitBtn setFrame:CGRectMake(0, 0, 100, 30)];
    self.submitBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
        self.submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.submitBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.font = [UIFont systemFontOfSize:12];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [secondView addSubview:self.submitBtn];
    [self.submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
    nextBtn.layer.cornerRadius = 5;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tempLabel = [[UILabel alloc]init];
    tempLabel.text = @"搞不定？找客服：400-6090-948";
    tempLabel.textColor = [UIColor grayColor];
    tempLabel.font = [UIFont systemFontOfSize:12];
    tempLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempLabel];
    
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(94);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(self.view.bounds.size.height/16);
    }];
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left).offset(5);
        make.right.equalTo(firstView.mas_right).offset(-5);
        make.top.equalTo(firstView.mas_top).offset(5);
        make.bottom.equalTo(firstView.mas_bottom).offset(-5);
    }];
    
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(1);
        make.left.equalTo(firstView.mas_left);
        make.right.equalTo(firstView.mas_right);
        make.height.mas_equalTo(firstView.mas_height);
    }];
    
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondView.mas_left).offset(5);
        make.top.equalTo(secondView.mas_top).offset(5);
        make.bottom.equalTo(secondView.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.view.bounds.size.width/2);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).offset(5);
        make.right.equalTo(secondView.mas_right).offset(-10);
        make.bottom.equalTo(secondView.mas_bottom).offset(-5);
        make.width.mas_equalTo(80);
    }];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left);
        make.right.equalTo(firstView.mas_right);
        make.top.equalTo(secondView.mas_bottom).offset(50);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left);
        make.right.equalTo(firstView.mas_right);
        make.top.equalTo(nextBtn.mas_bottom).offset(1);
        make.height.mas_equalTo(firstView.mas_height);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumTextField resignFirstResponder];
    [self.verificationCodeTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

//获取验证码
-(void)submitAction:(UIButton *)btn
{
    if (self.phoneNumTextField.text.length==0)
    {
        [self promptViewWithTitle:@"手机号不能为空"];
    }
    else
    {
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTextField.text
                                       zone:@"86"
                           customIdentifier:nil
                                     result:^(NSError *error){
                                         if (!error) {
                                             NSLog(@"获取验证码成功");
                                         } else {
                                             NSLog(@"错误信息：%@",error);
                                             NSInteger *i = (NSInteger *)[error code];
                                             NSLog(@"%d",i);
                                             if (i==457)
                                             {
                                                 [self promptViewWithTitle:@"手机号不正确"];
                                             }
                                         }}];
    }

}

//返回按钮
-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

//下一步点击事件
-(void)nextBtnAction:(UIButton *)btn
{
  
//    [self.navigationController popViewControllerAnimated:YES];
    ForgetPasswordNextViewController *forgetPasswordNextVc = [[ForgetPasswordNextViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordNextVc animated:YES];
    NSLog(@"123");
}

// 发布失败弹出提示窗口
- (void)promptViewWithTitle:(NSString *)title
{
    //    动画开始 关必发布按钮的交互 以免动画窗口无限出来
    UIView *promptView = [[UIView alloc] initWithFrame:CGRectMake(-(KSWidth - (KSWidth / 2)) / 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4)];
    promptView.backgroundColor = [UIColor whiteColor];
    promptView.alpha = 0;
    promptView.layer.cornerRadius = 10;
    promptView.layer.borderColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1.0].CGColor;
    promptView.layer.borderWidth = 1;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-(KSWidth - (KSWidth / 2)) / 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4)];
    //    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:KSWidth / 25];
    titleLabel.alpha = 0;
    [self.view addSubview:promptView];
    [self.view addSubview:titleLabel];
    
    [UIView animateWithDuration:0.6 animations:^{
        promptView.alpha = 0.8;
        titleLabel.alpha = 0.8;
        promptView.frame = CGRectMake((KSWidth - (KSWidth / 2)) / 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
        titleLabel.frame = CGRectMake((KSWidth - (KSWidth / 2)) / 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
    }completion:^(BOOL finished) {
        
        // 延迟一秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.6 animations:^{
                promptView.alpha = 0;
                titleLabel.alpha = 0;
                promptView.frame = CGRectMake(((KSWidth - (KSWidth / 2)) / 2) * 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
                titleLabel.frame = CGRectMake(((KSWidth - (KSWidth / 2)) / 2) * 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
                
            }completion:^(BOOL finished) {
                self.submitBtn.userInteractionEnabled = YES;
            }];
            
        });
    }];
    
}


@end
