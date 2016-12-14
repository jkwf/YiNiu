//
//  NickNameViewController.m
//  easyTrader
//
//  Created by JOYSW on 16/7/8.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "NickNameViewController.h"
#import "Header.h"

@interface NickNameViewController()<UITextFieldDelegate>
@property(nonatomic , strong)UITextField *nickNameTextField;

@end

@implementation NickNameViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"昵称";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
//    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    rightBarButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, self.view.bounds.size.width, self.view.bounds.size.height/13)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    
    UILabel *headlabel = [[UILabel alloc]init];
    headlabel.translatesAutoresizingMaskIntoConstraints = NO;
    headlabel.text = @"昵称";
    [topView addSubview:headlabel];
    
    self.nickNameTextField = [[UITextField alloc]init];
    self.nickNameTextField.delegate = self;
    self.nickNameTextField.text = LoginNickName;
    self.nickNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:self.nickNameTextField];
    

    [headlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(10);
        make.top.equalTo(topView.mas_top).offset(10);
        make.bottom.equalTo(topView.mas_bottom).offset(-10);
        make.width.mas_equalTo(50);
    }];
    
    
    [self.nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headlabel.mas_right).offset(10);
        make.top.equalTo(topView.mas_top).offset(10);
        make.bottom.equalTo(topView.mas_bottom).offset(-10);
        make.width.mas_equalTo(topView.bounds.size.width/2);
    }];
    
    
    UILabel *tempLabel = [[UILabel alloc]init];
    tempLabel.text = @"好记的名字方便别人找到你哟！";
    tempLabel.textColor = [UIColor grayColor];
    tempLabel.font = [UIFont systemFontOfSize:15];
    tempLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tempLabel];
    
    
    [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nickNameTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)saveAction{
    
    if ([self.nickNameTextField.text isEqualToString:@""]) {
        [WDAlert showAlertWithMessage:@"请输入您的昵称" time:0.8];
        return;
        
    }
    if ([self.nickNameTextField.text isEqualToString:self.textName]) {
        [WDAlert showAlertWithMessage:@"您的昵称和原昵称一致" time:0.8];
        return;
    }
 
    [WebShareData getDataFromWebWithParams:@{@"userid":LoginUserId,@"nickname":self.nickNameTextField.text} urlString:getAPIURL(@"mod=interface&ac=modifiedname") successBlock:^(NSDictionary *dicInfo) {
        if ([dicInfo[@"result"] intValue] == 1)
        {
            [AppHelper toastMessage:@{@"message":@"修改成功"}];
            SetLoginNickName(self.nickNameTextField.text);
            SetSynchronize;
            NSDictionary *dict = @{@"userName":self.nickNameTextField.text};
            [[SocketOprationData shareInit] sendReqDataWithValueDic:[dict mutableCopy] tag:@"setUserInfo" objecte:self call:@selector(editResult:)];
            
        }
        
    } failBlock:^(NSError *error) {
        
    }];
    
    
    NSLog(@"baocun");
}
- (void)editResult:(NSDictionary *)dic{
    
    if ([dic[@"result"] intValue] == 1) {
        [AppHelper toastMessage:@{@"message":@"修改成功"}];
        SetLoginNickName(self.nickNameTextField.text);
        SetSynchronize;
    }




}

@end
