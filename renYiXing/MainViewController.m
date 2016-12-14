//
//  MainViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "MainViewController.h"
#import "FirstViewController.h"
#import "Masonry.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "Header.h"
#import "PtlCmdLoginReq.h"
#import "GCDSocket.h"
#import "AppDelegate.h"

@interface MainViewController ()<UITextFieldDelegate>
@property(nonatomic , strong)UITextField *nameTextField;
@property(nonatomic , strong)UITextField *passTextField;
@property(nonatomic , strong)UIButton *loginBtn;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor colorWithRed:229/255.0 green:229/255.0  blue:229/255.0  alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text =  @"登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];

    
    UIImageView *topImageView = [[UIImageView alloc]init];
    [topImageView setImage:[UIImage imageNamed:@"top1"]];
    topImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topImageView];
    
    UIView *nameLabel = [[UIView alloc]init];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nameBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    nameBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [nameLabel addSubview:nameBtn];
    
    self.nameTextField = [[UITextField alloc]init];
    self.nameTextField.delegate = self;
    self.nameTextField.placeholder = @"请输入用户名／手机号";
    self.nameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [nameLabel addSubview:self.nameTextField];
    
    
    UIView *passLabel = [[UIView alloc]init];
    passLabel.translatesAutoresizingMaskIntoConstraints = NO;
    passLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passLabel];
    
    UIButton *passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passBtn setImage:[UIImage imageNamed:@"psw"] forState:UIControlStateNormal];
    passBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [passLabel addSubview:passBtn];
    
    self.passTextField = [[UITextField alloc]init];
    self.passTextField.delegate = self;
    self.passTextField.secureTextEntry = YES;
    self.passTextField.placeholder = @"请输入密码";
    self.passTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [passLabel addSubview:self.passTextField];
    

    self.nameTextField.text = @"15211223344";
    self.passTextField.text = @"qw1234";

    UIButton *imgvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgvBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [imgvBtn setImage:[UIImage imageNamed:@"shut"] forState:UIControlStateNormal];
    [imgvBtn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
    //    imgvBtn.backgroundColor = [UIColor blackColor];
    [imgvBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [passLabel addSubview:imgvBtn];
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    tempBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempBtn];
    [tempBtn addTarget:self action:@selector(tempBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *zhuceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhuceBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [zhuceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    zhuceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:zhuceBtn ];
    [zhuceBtn  addTarget:self action:@selector(zhuceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 5;
    [self.view addSubview:self.loginBtn ];
    [self.loginBtn  addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hotPhoneLabel = [[UILabel alloc]init];
    hotPhoneLabel.text = @"客服热线：400-6090-948";
    hotPhoneLabel.textColor = [UIColor grayColor];
    hotPhoneLabel.font = [UIFont systemFontOfSize:12];
    hotPhoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:hotPhoneLabel];

//    ======================================================
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.frame.size.height/5*1.5);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(topImageView.mas_bottom);
        make.height.mas_equalTo(self.view.frame.size.height/16);
    }];
    
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left).offset(10);
        make.top.equalTo(nameLabel.mas_top).offset(10);
        make.bottom.equalTo(nameLabel.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.view.frame.size.height/40);
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameBtn.mas_right).offset(15);
        make.top.equalTo(nameLabel.mas_top);
        make.bottom.equalTo(nameLabel.mas_bottom);
        make.right.equalTo(nameLabel.mas_right);
    }];
    
    [passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.right.equalTo(nameLabel.mas_right);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(1);
        make.height.mas_equalTo(nameLabel.mas_height);
    }];
    
    [passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passLabel.mas_left).offset(10);
        make.top.equalTo(passLabel.mas_top).offset(10);
        make.bottom.equalTo(passLabel.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.view.frame.size.height/40);
    }];
    
    [self.passTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passBtn.mas_right).offset(15);
        make.top.equalTo(passLabel.mas_top);
        make.bottom.equalTo(passLabel.mas_bottom);
        make.right.equalTo(passLabel.mas_right);
    }];
    
    [imgvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passLabel.mas_right).offset(-10);
        make.top.equalTo(passLabel.mas_top).offset(5);
        make.bottom.equalTo(passLabel.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.view.frame.size.height/16-10);
    }];
    
    [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passLabel.mas_left);
        make.top.equalTo(passLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [zhuceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passLabel.mas_right);
        make.top.equalTo(tempBtn.mas_top);
        make.bottom.equalTo(tempBtn.mas_bottom);
        make.width.mas_equalTo(tempBtn.mas_width);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(tempBtn.mas_bottom).offset(20);
        make.right.equalTo(nameLabel.mas_right);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    [hotPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.frame.size.width/2);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        make.height.mas_equalTo(nameLabel.mas_height);
    }];
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

-(void)tempBtnAction
{
    ForgetPasswordViewController *forgetPasswordVc = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVc animated:YES];
    NSLog(@"忘记密码");
    
}

-(void)zhuceBtnAction
{
    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVc animated:YES];
    NSLog(@"注册");
}

-(void)loginBtnAction
{
    if (self.nameTextField.text.length==0)
    {
        [self promptViewWithTitle:@"账号不能为空"];
    }
    else if(self.passTextField.text.length == 0)
    {
        [self promptViewWithTitle:@"密码不能为空"];
    }
    else
    {
        SetLoginUserName(self.nameTextField.text);
        SetLoginPassword(self.passTextField.text);
        SetSynchronize;
//        FirstViewController *vc = [[FirstViewController alloc]init];
//        [vc.navigationItem setHidesBackButton:TRUE animated:NO];
//        [self.navigationController pushViewController:vc animated:NO];
//
//        return;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"password":self.passTextField.text,@"phone":self.nameTextField.text,@"mod":@"interface",@"ac":@"login"}];
    
        [[WDAlert shareAlert] showLodingWithTitle:@""];
        [WebShareData getDataFromWebWithParams:dic urlString:getAPIURL(@"mod=interface&ac=login") successBlock:^(NSDictionary *dicInfo) {
            [[WDAlert shareAlert] hiddenHUD];
            if ([dicInfo[@"result"] intValue] == 1){
                
                
                ApplicationDelegate.userLoginInfo = [dicInfo modelCopy];
                FirstViewController *vc = [[FirstViewController alloc]init];
                [vc.navigationItem setHidesBackButton:TRUE animated:NO];
                
                [self.navigationController pushViewController:vc animated:NO];
                
                
              
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{NODE_USER_NAME:self.nameTextField.text,NODE_PASSWORD:[self.passTextField.text md5String],NODE_DOMAIN:@"9000"}];
                [[SocketOprationData shareInit] sendReqDataWithValueDic:dict tag:PTL_CMD_LOGIN objecte:self call:@selector(loginResult:)];
            }
            else{
                [WDAlert showAlertWithMessage:@"登录失败" time:1.];
            }
         
        } failBlock:^(NSError *error) {
            [[WDAlert shareAlert] hiddenHUD];

        }];
 
    }

}

- (void)loginResult:(NSDictionary *)dic{
   int r = [dic[NODE_RESULT_NAME] intValue];
    if (r == 1){
        
        SetLoginUserId(dic[@"sessionID"]);
        SetLoginNickName(dic[@"nickname"]);
        SetSynchronize;
        
        FirstViewController *vc = [[FirstViewController alloc]init];
        [vc.navigationItem setHidesBackButton:TRUE animated:NO];
        
        [self.navigationController pushViewController:vc animated:NO];
        //[self.navigationController pushViewController:[[FirstViewController alloc]init] animated:NO];
    }else{
        [self promptViewWithTitle:dic[NODE_ERR_NAME]];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nameTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.6 animations:^{
                promptView.alpha = 0;
                titleLabel.alpha = 0;
                promptView.frame = CGRectMake(((KSWidth - (KSWidth / 2)) / 2) * 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
                titleLabel.frame = CGRectMake(((KSWidth - (KSWidth / 2)) / 2) * 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
                
            }completion:^(BOOL finished) {
                self.loginBtn.userInteractionEnabled = YES;
            }];
            
        });
    }];
    
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
