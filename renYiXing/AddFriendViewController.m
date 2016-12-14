//
//  AddFriendViewController.m
//  柴火圈
//
//  Created by JOYSW on 16/7/15.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "AddFriendViewController.h"
#import "Header.h"
#import "SearchResultViewController.h"
#import "CreateCircleViewController.h"
@implementation PopView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        Wself
        UIView *back = [UIView new];
        back.backgroundColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        back.alpha = 0.9;

        [self addSubview:back];
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(wself.mas_trailing).offset(-10);
            make.top.equalTo(wself.mas_top).offset(69);
            make.height.equalTo(@81);
            make.width.equalTo(@100);
            
        }];
        
        UIButton *addFriend = [UIButton buttonWithType:UIButtonTypeCustom];
        [addFriend setTitle:@"添加朋友" forState:UIControlStateNormal];
        
        [addFriend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
#warning 修改图片名
        [addFriend setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        addFriend.titleLabel.font = [UIFont systemFontOfSize:12];

        [addFriend addTarget:self action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
        [back addSubview:addFriend];
        [addFriend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(back);
            make.height.equalTo(@40);
        }];
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor whiteColor];
        [back addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(back);
            make.top.equalTo(addFriend.mas_bottom);
            make.height.equalTo(@(0.5));
            
        }];
        
        UIButton *createCircle = [UIButton buttonWithType:UIButtonTypeCustom];
        [createCircle setTitle:@"创建圈子" forState:UIControlStateNormal];
        [createCircle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
#warning 修改图片名
        [createCircle setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        createCircle.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:createCircle];
        [createCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(back);
            make.height.equalTo(@40);
        }];
        [createCircle addTarget:self action:@selector(createCircleAction) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return self;
}
- (void)addFriendAction{

    AddFriendViewController *addFriendVc = [[AddFriendViewController alloc]init];
    [self.viewController.navigationController pushViewController:addFriendVc animated:NO];
    [self removeFromSuperview];

}

- (void)createCircleAction{
    CreateCircleViewController *vc = [[CreateCircleViewController alloc]init];
    [self.viewController.navigationController pushViewController:vc animated:NO];
    [self removeFromSuperview];

}
@end
@interface AddFriendViewController()<UITextFieldDelegate>
@property(nonatomic, strong)UITextField *userNameTextField;//用户名
@property(nonatomic, strong)UIButton *addButton;
@end

@implementation AddFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPopButton];
//    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
//    usernameLabel.text = @"用户名";
//    usernameLabel.font = [UIFont systemFontOfSize:25];
//    [self.view addSubview:usernameLabel];
    self.view.backgroundColor = RGBACOLOR(232, 232, 232, 1);
    self.navigationItem.title = @"添加朋友";
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(0 , 64+20, self.view.width, 50)];
    _userNameTextField.backgroundColor = [UIColor whiteColor];
    _userNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 50)];
    _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userNameTextField.placeholder = @"手机号/账号";
    _userNameTextField.backgroundColor = [UIColor whiteColor];
    _userNameTextField.returnKeyType = UIReturnKeySearch;
    _userNameTextField.delegate = self;
    [self.view addSubview:_userNameTextField];
    
    
//    self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.addButton.frame = CGRectMake(170, 300, 50, 50);
//    self.addButton.titleLabel.font = [UIFont systemFontOfSize:25];
//    [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
//    [self.addButton addTarget:self action:@selector(didClickAddButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.addButton];
    
}

-(void)didClickAddButton
{
    if (self.userNameTextField.text.length == 0)
    {
        [self promptViewWithTitle:@"用户名不能为空"];
    }
    else
    {
//
//        EMError * error;
//        BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:_userNameTextField.text message:@"我想加您为好友" error:&error];
//        if (isSuccess && !error) {
//            NSLog(@"添加成功");
//            [self promptViewWithTitle:@"添加成功"];
//            
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [self.navigationController popViewControllerAnimated:YES];
//                    });
//
//        }
//        else
//        {
//            NSLog(@"%@",error);
//        }
    }
//    if (self.userNameTextField.text.length == 0)
//    {
//        [self promptViewWithTitle:@"用户名不能为空"];
//    }
//    else
//    {
//    EMError *error = [[EMClient sharedClient].contactManager addContact:_userNameTextField.text message:@"我想加您为好友"];
//    if (!error) {
//        [self promptViewWithTitle:@"添加成功"];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//        NSLog(@"添加成功");
//       }
//        else
//        {
//            [self promptViewWithTitle:@"用户名不存在"];
//        }
//    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userNameTextField resignFirstResponder];
}
- (void)searchResult:(id)obj{
    [[WDAlert shareAlert] hiddenHUD];
    if ([obj[@"result"] integerValue]!=1){
        [WDAlert showAlertWithMessage:@"未找到结果" time:1.5];
        return;
    }
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.userInfo = [UserInfomation modelWithDictionary:obj[@"UserInfo"]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length>0) {
        [[WDAlert shareAlert] showLodingWithTitle:@""];
        SearchUserRequestMode *m = [[SearchUserRequestMode alloc] init];
        m.type = PTL_REQ;
        m.cmd = PTL_CMD_GetUserInfo;
        m.sessionID = [[SocketOprationData shareInit] sessionID];
        m.userID = @"";
        m.userName = textField.text;
        [[SocketOprationData shareInit] sendReqDataWithObj:m tag:PTL_CMD_GetUserInfo objecte:self call:@selector(searchResult:)];
    }
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.6 animations:^{
                promptView.alpha = 0;
                titleLabel.alpha = 0;
                promptView.frame = CGRectMake(((KSWidth - (KSWidth / 2)) / 2) * 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
                titleLabel.frame = CGRectMake(((KSWidth - (KSWidth / 2)) / 2) * 2, KSWidth - KSWidth / 4, KSWidth / 2, KSWidth / 4);
                
            }completion:^(BOOL finished) {
                self.addButton.userInteractionEnabled = YES;
            }];
            
        });
    }];
    
}

@end
