//
//  RegisterViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/28.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "RegisterViewController.h"
#import "Masonry.h"
#import "Header.h"

@interface RegisterViewController()<UITextFieldDelegate>
@property(nonatomic , strong)UITextField *phoneNumberTextField;
@property(nonatomic , strong)UITextField *littleNameTextField;
@property(nonatomic , strong)UITextField *recommandTextField;
@property(nonatomic , strong)UITextField *passTextField;
@property(nonatomic , strong)UITextField *VerificationCodeTextField;
@property(nonatomic , strong)UIButton *finishBtn;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@end

@implementation RegisterViewController

-(void)viewDidLoad
{
   [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0  blue:229/255.0  alpha:1.0];;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"注册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    UIView *phoneNumView = [[UIView alloc]init];
    phoneNumView.backgroundColor = [UIColor whiteColor];
    phoneNumView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:phoneNumView];
    
    self.phoneNumberTextField = [[UITextField alloc]init];
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.placeholder = @" 请输入手机号";
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.backgroundColor = [UIColor whiteColor];
    self.phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [phoneNumView addSubview:self.phoneNumberTextField];
    
    UIView *firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor whiteColor];
    //    firstLabel.alpha = 0.1;
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:firstView];
   
    self.littleNameTextField = [[UITextField alloc]init];
    self.littleNameTextField.delegate = self;
//    self.littleNameTextField.backgroundColor = [UIColor greenColor];
    self.littleNameTextField.placeholder = @" 请输入昵称";
    self.littleNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [firstView addSubview:self.littleNameTextField];
    
    UIView *recommandView = [[UIView alloc]init];
    recommandView.backgroundColor = [UIColor whiteColor];
    recommandView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:recommandView];
    
    self.recommandTextField = [[UITextField alloc]init];
    self.recommandTextField.delegate = self;
    self.recommandTextField.backgroundColor = [UIColor whiteColor];
    self.recommandTextField.placeholder = @" 请输入推荐人手机号";
    self.recommandTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.recommandTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [recommandView addSubview:self.recommandTextField];
    
    
    UIView *passView = [[UIView alloc]init];
    passView.backgroundColor = [UIColor whiteColor];
    passView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:passView];
    
    self.passTextField = [[UITextField alloc]init];
    self.passTextField.delegate = self;
    self.passTextField.backgroundColor = [UIColor whiteColor];
    self.passTextField.placeholder = @" 请输入密码";
    self.passTextField.secureTextEntry = YES;
    self.passTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [passView addSubview:self.passTextField];
    
//    UIView *imgv=[[UIView alloc] initWithFrame:CGRectMake(0, 0,100, 140)];
    UIButton *imgvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgvBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [imgvBtn setImage:[UIImage imageNamed:@"shut"] forState:UIControlStateNormal];
    [imgvBtn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
//    imgvBtn.backgroundColor = [UIColor blackColor];
    [imgvBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [passView addSubview:imgvBtn];
    
    UILabel *tempLabel = [[UILabel alloc]init];
    tempLabel.text = @" 请输入6-20个字母、数字组合";
    tempLabel.textColor = [UIColor blackColor];
    tempLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempLabel];
    
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor whiteColor];
    //    firstLabel.alpha = 0.1;
    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:secondView];
    
    self.VerificationCodeTextField = [[UITextField alloc]init];
    self.VerificationCodeTextField.delegate = self;
    self.VerificationCodeTextField.backgroundColor = [UIColor whiteColor];
    self.VerificationCodeTextField.placeholder = @" 请输入验证码";
    self.VerificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.VerificationCodeTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [secondView addSubview:self.VerificationCodeTextField];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setFrame:CGRectMake(0, 0, 100, 30)];
    submitBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
//    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.font = [UIFont systemFontOfSize:12];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [secondView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    
    
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishBtn setTitle:@"注册完成" forState:UIControlStateNormal];
    self.finishBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
    self.finishBtn.layer.cornerRadius = 5;
    [self.finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.finishBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.finishBtn];
    [self.finishBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel* noteLabel = [[UILabel alloc] init];
    noteLabel.font = [UIFont systemFontOfSize:14];
    noteLabel.textColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
    noteLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"注册即视为同意任意行产品许可使用协议"];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"任"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:redRange];
    [noteLabel setAttributedText:noteStr] ;
    [noteLabel sizeToFit];
    [self.view addSubview:noteLabel];
    

    

    
//    =======================================================
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(self.view.frame.size.height/16);
    }];
    
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumView.mas_left).offset(10);
        make.right.equalTo(phoneNumView.mas_right).offset(-10);
        make.top.equalTo(phoneNumView.mas_top).offset(5);
        make.bottom.equalTo(phoneNumView.mas_bottom).offset(-5);
    }];
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumView.mas_left);
        make.right.equalTo(phoneNumView.mas_right);
        make.top.equalTo(phoneNumView.mas_bottom).offset(1);
        make.height.mas_equalTo(phoneNumView.mas_height);
    }];
    
    
    [self.littleNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left).offset(10);
        make.right.equalTo(firstView.mas_right).offset(-10);
        make.top.equalTo(firstView.mas_top).offset(5);
        make.bottom.equalTo(firstView.mas_bottom).offset(-5);
    }];
    
    [recommandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumView.mas_left);
        make.right.equalTo(phoneNumView.mas_right);
        make.top.equalTo(firstView.mas_bottom).offset(1);
        make.height.mas_equalTo(phoneNumView.mas_height);
    }];
    
    [self.recommandTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recommandView.mas_left).offset(10);
        make.right.equalTo(recommandView.mas_right).offset(-10);
        make.top.equalTo(recommandView.mas_top).offset(5);
        make.bottom.equalTo(recommandView.mas_bottom).offset(-5);
    }];
    
    [passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumView.mas_left);
        make.right.equalTo(phoneNumView.mas_right);
        make.top.equalTo(recommandView.mas_bottom).offset(1);
        make.height.mas_equalTo(phoneNumView.mas_height);
    }];
    
    [self.passTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passView.mas_left).offset(10);
        make.width.mas_equalTo(self.view.bounds.size.width/3);
        make.top.equalTo(passView.mas_top).offset(5);
        make.bottom.equalTo(passView.mas_bottom).offset(-5);
    }];
    
    [imgvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passView.mas_right).offset(-10);
        make.top.equalTo(passView.mas_top).offset(5);
        make.bottom.equalTo(passView.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.view.frame.size.height/16-10);
    }];
    
    [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumView.mas_left);
        make.right.equalTo(phoneNumView.mas_right);
        make.top.equalTo(self.passTextField.mas_bottom).offset(1);
        make.height.mas_equalTo(phoneNumView.mas_height);
    }];
    
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumView.mas_left);
        make.right.equalTo(phoneNumView.mas_right);
        make.top.equalTo(tempLabel.mas_bottom).offset(1);
        make.height.mas_equalTo(phoneNumView.mas_height);
    }];
    
    [self.VerificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondView.mas_left).offset(10);
        make.bottom.equalTo(secondView.mas_bottom).offset(-5);
        make.top.equalTo(secondView.mas_top).offset(5);
        make.width.mas_equalTo(self.view.frame.size.width/2);
    }];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).offset(5);
        make.right.equalTo(secondView.mas_right).offset(-10);
        make.bottom.equalTo(secondView.mas_bottom).offset(-5);
        make.width.mas_equalTo(80);
    }];
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumView.mas_left);
        make.right.equalTo(phoneNumView.mas_right);
        make.top.equalTo(secondView.mas_bottom).offset(self.view.frame.size.height/16);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finishBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.phoneNumberTextField.mas_height);
    }];
    
    
//    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(10);
//        make.right.equalTo(self.view.mas_right).offset(-10);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
//        make.height.mas_equalTo(50);
//    }];
//    
//    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(whiteView.mas_left).offset(10);
//        make.right.equalTo(whiteView.mas_right).offset(-10);
//        make.top.equalTo(whiteView.mas_top).offset(10);
//        make.bottom.equalTo(whiteView.mas_bottom).offset(-10);
//    }];
//    
    
    
    
}

-(void)leftBarButtonAction
{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)finishBtnAction:(UIButton *)btn
{
    if (self.phoneNumberTextField.text.length==0)
    {
        [self promptViewWithTitle:@"账号不能为空"];
    }
    else if(self.passTextField.text.length == 0)
    {
        [self promptViewWithTitle:@"密码不能为空"];
    }
    else if(self.VerificationCodeTextField.text.length == 0)
    {
        [self promptViewWithTitle:@"验证码不能为空"];
    }
    else{
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"UserInfo":@{@"RealNickName":@"",@"UserPsw":[self.passTextField.text md5String],@"UserName":self.phoneNumberTextField.text,@"NickName":self.littleNameTextField.text}}];
        dict[@"cmd"] = PTL_CMD_REGISTER;
        dict[@"type"] = PTL_REQ;
        dict[@"sessionID"] = @"000000";
        [[SocketOprationData shareInit] sendReqDataWithValueDic:dict tag:PTL_CMD_REGISTER objecte:self call:@selector(registerResult:)];
        
        
        
/*

//        [SMSSDK commitVerificationCode:self.VerificationCodeTextField.text phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {
//            if (error == nil){
        Wself
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"nickname":self.littleNameTextField.text,@"password":self.passTextField.text,@"phone":self.phoneNumberTextField.text,@"pronumber":self.recommandTextField.text.length==0?@"":self.recommandTextField.text,@"mod":@"interface",@"ac":@"regist"}];
                [WebShareData getDataFromWebWithParams:dic urlString:getAPIURL(@"mod=interface&ac=regist") successBlock:^(NSDictionary *dicInfo) {
                    if ([dicInfo[@"result"] intValue] == 1){
                        Sself
                        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"UserInfo":@{@"RealNickName":@"",@"UserPsw":[sself.passTextField.text md5String],@"UserName":sself.phoneNumberTextField.text,@"NickName":sself.littleNameTextField.text}}];
                        dict[@"cmd"] = PTL_CMD_REGISTER;
                        dict[@"type"] = PTL_REQ;
                        dict[@"sessionID"] = @"000000";
                        [[SocketOprationData shareInit] sendReqDataWithValueDic:dict tag:PTL_CMD_REGISTER objecte:sself call:@selector(registerResult:)];
                    }else{
                        [self promptViewWithTitle:@"注册失败"];

                    }
                } failBlock:^(NSError *error) {
                    [self promptViewWithTitle:@"注册失败"];

                }];
        
//            }else{
//                [self promptViewWithTitle:@"验证码错误"];
//            }
//        }];
    
 */
     
        
 
   }
}

- (void)registerResult:(id)info{
    if ([info[@"result"] intValue] == 1) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"nickname":self.littleNameTextField.text,@"password":self.passTextField.text,@"phone":self.phoneNumberTextField.text,@"pronumber":self.recommandTextField.text.length==0?@"":self.recommandTextField.text,@"mod":@"interface",@"ac":@"regist",@"userid":info[@"sessionID"]}];
        [WebShareData getDataFromWebWithParams:dic urlString:getAPIURL(@"mod=interface&ac=regist") successBlock:^(NSDictionary *dicInfo) {
            if ([dicInfo[@"result"] intValue] == 1){
                [self promptViewWithTitle:@"注册成功"];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.];
            }
            
        } failBlock:^(NSError *error) {
            [self promptViewWithTitle:@"注册失败"];
            
        }];
        
        
        

    }else{
        [self promptViewWithTitle:@"注册失败"];
    }

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
                self.finishBtn.userInteractionEnabled = YES;
            }];
            
        });
    }];
    
}



-(void)submitBtnAction:(UIButton *)btn
{
    
    if (self.phoneNumberTextField.text.length==0)
    {
        [self promptViewWithTitle:@"手机号不能为空"];
    }
    else
    {
        //http://easytrader.joysw.cn/yn_contact/index.php?mod=interface&ac=msgvalidate
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"phone":self.phoneNumberTextField.text,@"mod":@"interface",@"ac":@"msgvalidate"}];
        
//        [WebShareData getDataFromWebWithParams:dic urlString:@"" successBlock:^(NSDictionary *dicInfo) {
//            
//        } failBlock:^(NSError *error) {
//            
//        }];
        
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
    }
}

-(void)BtnAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if(!btn.selected)
    {
        self.passTextField.secureTextEntry = YES;
    }
    else
    {
        self.passTextField.secureTextEntry = NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumberTextField resignFirstResponder];
    [self.littleNameTextField resignFirstResponder];
    [self.recommandTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
    [self.VerificationCodeTextField resignFirstResponder];
}

-(bool)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];

}


@end
