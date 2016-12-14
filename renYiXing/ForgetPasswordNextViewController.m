//
//  ForgetPasswordNextViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/7/5.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "ForgetPasswordNextViewController.h"
#import "Header.h"
//#import "testHtmlViewController.h"

@interface ForgetPasswordNextViewController()<UITextFieldDelegate>
@property(nonatomic , strong)UILabel *userNameLabel;
@property(nonatomic , strong)UITextField *passwordTextField;
@property(nonatomic , strong)UILabel *lowLabel;
@property(nonatomic , strong)UILabel *middleLabel;
@property(nonatomic , strong)UILabel *heighLabel;
@end

@implementation ForgetPasswordNextViewController
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
    
//    UIImage  *image =[[UIImage imageNamed:@"chacha"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIImage  *imageRight =[[UIImage imageNamed:@"xunhuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:imageRight style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    
    UIView *firstView = [[UIView alloc]init];
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
    UILabel *firstLabel = [[UILabel alloc]init];
    firstLabel.text = @"用户名：";
    firstLabel.textColor = [UIColor grayColor];
//    firstLabel.backgroundColor = [UIColor greenColor];
    firstLabel.translatesAutoresizingMaskIntoConstraints =  NO;
    [self.view addSubview:firstLabel];
    
    self.userNameLabel = [[UILabel alloc]init];
//    self.userNameLabel.backgroundColor = [UIColor redColor];
    self.userNameLabel.text = @"easyTrader";
    self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [firstView addSubview:self.userNameLabel];
    
    
    
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:secondView];
    
    UILabel *secondLabel = [[UILabel alloc]init];
//    secondLabel.backgroundColor = [UIColor greenColor];
    secondLabel.text = @"新密码：";
    secondLabel.textColor = [UIColor grayColor];
    secondLabel.translatesAutoresizingMaskIntoConstraints =  NO;
    [secondView addSubview:secondLabel];

    self.passwordTextField = [[UITextField alloc]init];
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry = YES;
//    self.passwordTextField.backgroundColor = [UIColor redColor];
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [secondView addSubview:self.passwordTextField];
    
    [self.passwordTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    eyeBtn.backgroundColor = [UIColor orangeColor];
    eyeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [eyeBtn setImage:[UIImage imageNamed:@"shut"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
    [eyeBtn addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:eyeBtn];
    
    
    UILabel *templabel = [[UILabel alloc]init];
    templabel.text = @"请输入6-20个字母、数字组合";
    templabel.textColor = [UIColor grayColor];
    templabel.font = [UIFont systemFontOfSize:12];
    templabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:templabel];
    
    UILabel *strongLabel = [[UILabel alloc]init];
    strongLabel.text = @"密码强度";
    strongLabel.textColor = [UIColor grayColor];
    strongLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:strongLabel];
    
    self.lowLabel = [[UILabel alloc]init];
    self.lowLabel.backgroundColor = [UIColor grayColor];
    self.lowLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.lowLabel];
    
    self.middleLabel = [[UILabel alloc]init];
    self.middleLabel.backgroundColor = [UIColor grayColor];
    self.middleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.middleLabel];
    
    self.heighLabel = [[UILabel alloc]init];
    self.heighLabel.backgroundColor = [UIColor grayColor];
    self.heighLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.heighLabel];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
    submitBtn.layer.cornerRadius = 5;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    
   
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(94);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(self.view.bounds.size.height/16);
    }];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left).offset(10);
        make.top.equalTo(firstView.mas_top).offset(5);
        make.bottom.equalTo(firstView.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.view.bounds.size.width/4.5);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left).offset(10+self.view.bounds.size.width/4.5);
        make.right.equalTo(firstView.mas_right).offset(-10);
        make.top.equalTo(firstView.mas_top).offset(5);
        make.bottom.equalTo(firstView.mas_bottom).offset(-5);
    }];
    
    
    
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(1);
        make.left.equalTo(firstView.mas_left);
        make.right.equalTo(firstView.mas_right);
        make.height.mas_equalTo(firstView.mas_height);
    }];
    
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondView.mas_left).offset(10);
        make.top.equalTo(secondView.mas_top).offset(5);
        make.bottom.equalTo(secondView.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.view.bounds.size.width/4.5);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10+self.view.bounds.size.width/4.5);
        make.width.mas_equalTo(self.view.bounds.size.width/2);
        make.top.equalTo(secondLabel.mas_top);
        make.bottom.equalTo(secondLabel.mas_bottom);
    }];
    
    [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(secondView.mas_right).offset(-5);
        make.top.equalTo(secondView.mas_top).offset(5);
        make.bottom.equalTo(secondView.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.view.bounds.size.height/16-10);
    }];
    
    [templabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondView.mas_left);
        make.right.equalTo(secondView.mas_right);
        make.top.equalTo(secondView.mas_bottom);
        make.height.mas_equalTo(secondView.mas_height);
    }];
    
    [strongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondView.mas_left);
        make.top.equalTo(templabel.mas_bottom).offset(5);
        make.width.mas_equalTo(self.view.bounds.size.width/4.5);
        make.height.mas_equalTo(self.view.bounds.size.width/16);
    }];
    
    [self.lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(strongLabel.mas_right).offset(10);
        make.top.equalTo(strongLabel.mas_top).offset(5);
        make.width.mas_equalTo((self.view.bounds.size.width-self.view.bounds.size.width/4.5-52)/3);
        make.height.mas_equalTo(3);
    }];
    
    [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lowLabel.mas_right).offset(10);
        make.top.equalTo(self.lowLabel.mas_top);
        make.bottom.equalTo(self.lowLabel.mas_bottom);
        make.width.mas_equalTo(self.lowLabel.mas_width);
    }];
    
    [self.heighLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(firstView.mas_right).offset(-2);
        make.top.equalTo(self.lowLabel.mas_top);
        make.bottom.equalTo(self.lowLabel.mas_bottom);
        make.width.mas_equalTo(self.lowLabel.mas_width);
    }];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left);
        make.right.equalTo(firstView.mas_right);
        make.top.equalTo(strongLabel.mas_bottom).offset(40);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
}

-(void)eyeBtnAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(!btn.selected)
    {
        self.passwordTextField.secureTextEntry = YES;
    }
    else
    {
        self.passwordTextField.secureTextEntry = NO;
    }
}


-(void)submitBtnAction:(UIButton *)btn
{
//    
//    if (self.phoneNumberTextField.text.length==0)
//    {
//        [self promptViewWithTitle:@"手机号不能为空"];
//    }
//    else
//    {
//        
//        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text
//                                       zone:@"86"
//                           customIdentifier:nil
//                                     result:^(NSError *error){
//                                         if (!error) {
//                                             NSLog(@"获取验证码成功");
//                                         } else {
//                                             NSLog(@"错误信息：%@",error);
//                                             NSInteger *i = (NSInteger *)[error code];
//                                             NSLog(@"%d",i);
//                                             if (i==457)
//                                             {
//                                                 [self promptViewWithTitle:@"手机号不正确"];
//                                             }
//                                         }}];
//    }

}

//返回按钮
-(void)leftBarButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//重置按钮
-(void)rightBarButtonAction
{
    NSLog(@"重置");
    self.passwordTextField.text = nil;
    self.lowLabel.backgroundColor = [UIColor grayColor];
    self.middleLabel.backgroundColor = [UIColor grayColor];
    self.heighLabel.backgroundColor = [UIColor grayColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.passwordTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark 判断密码强度
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.lowLabel.backgroundColor = [UIColor grayColor];
    self.middleLabel.backgroundColor = [UIColor grayColor];
    self.heighLabel.backgroundColor = [UIColor grayColor];
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
-(void)changeValue:(UITextField *)textField
{
    NSString *temptest = [self judgePasswordStrength:textField.text];
    NSLog(@"%@",temptest);
    if ([temptest isEqualToString:@"密码强度低，建议修改"])
    {
        NSLog(@"1");
        self.lowLabel.backgroundColor = [UIColor redColor];
        self.middleLabel.backgroundColor = [UIColor grayColor];
        self.heighLabel.backgroundColor = [UIColor grayColor];
    }
    else if([temptest isEqualToString:@"密码强度一般"])
    {
        NSLog(@"2");
        self.lowLabel.backgroundColor = [UIColor redColor];
        self.middleLabel.backgroundColor = [UIColor redColor];
        self.heighLabel.backgroundColor = [UIColor grayColor];
    }
    else
    {
        NSLog(@"3");
        self.lowLabel.backgroundColor = [UIColor redColor];
        self.middleLabel.backgroundColor = [UIColor redColor];
        self.heighLabel.backgroundColor = [UIColor redColor];
    }
    
    
    
}

//判断是否包含

- (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password

{
    
    NSRange range;
    
    BOOL result =NO;
    
    for(int i=0; i<[_termArray count]; i++)
        
    {
        
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        
        if(range.location != NSNotFound)
            
        {
            
            result =YES;
            
        }
        
    }
    
    return result;
    
}

//条件

-(NSString*) judgePasswordStrength:(NSString*) _password

{
    
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    
    
    
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    
    
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
    
    
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    
    
    
    int intResult=0;
    
    for (int j=0; j<[resultArray count]; j++)
        
    {
        
        
        
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
            
        {
            
            intResult++;
            
        }
        
    }
    
    NSString* resultString = [[NSString alloc] init];
    
    if (intResult <2)
        
    {
        
        resultString = @"密码强度低，建议修改";
        
    }
    
    else if (intResult == 2&&[_password length]>=6)
        
    {
        
        resultString = @"密码强度一般";
        
    }
    
    if (intResult > 2&&[_password length]>=6)
        
    {
        
        resultString = @"密码强度高";
        
    }
    
    
    
    return resultString;
    
}



@end
