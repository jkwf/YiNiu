//
//  CreateCircleViewController.m
//  柴火圈
//
//  Created by Longxun on 16/11/8.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "CreateCircleViewController.h"

@interface CreateCircleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *typeText;

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property(nonatomic)NSInteger type;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation CreateCircleViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameText resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPopButton];
    self.navigationItem.title = @"创建圈子";
    self.type = 0;
    [self.view bringSubviewToFront:self.button];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTitle:@"确定" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBarButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.frame =CGRectMake(0, 0, 33,32);
    UIBarButtonItem *items = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem = items;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addAction{
    if (self.nameText.text.length<=0) {
        [WDAlert showAlertWithMessage:@"请输入圈名字" time:0.8];
        return;
    }
    if (self.type == 0) {
        [WDAlert showAlertWithMessage:@"请选择类别" time:0.8];
        return;
    }
    AddCircle *c = [[AddCircle alloc] init];
    c.type = PTL_REQ;
    c.cmd = PTL_CMD_AddGroup;
    c.sessionID = [[SocketOprationData shareInit] sessionID];
    c.userID = c.sessionID;
    c.name = self.nameText.text;
    c.newpasswd = @"";
    c.theme = @"";
    c.bulletin = @"";
    c.groupType = [NSString stringWithFormat:@"%zd",self.type];
    c.mode = @"0";
    [[SocketOprationData shareInit] sendReqDataWithObj:c tag:PTL_CMD_AddGroup objecte:self call:@selector(completeFunction:)];
}
- (void)completeFunction:(id)obj{
    if ([obj[@"result"] integerValue] == 1) {
        [WDAlert showAlertWithMessage:@"创建成功" time:1.5];
        [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.5];
    }else{
        [WDAlert showAlertWithMessage:@"创建失败" time:1.5];
    }
}
- (IBAction)switchAction:(UIButton *)sender {
    self.type = sender.tag;
    UILabel *l = [self.view viewWithTag:sender.tag*10];
    if (!l) {
        return;
    }
    self.typeText.text = l.text;
    
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
