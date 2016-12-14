//
//  SearchResultViewController.m
//  柴火圈
//
//  Created by Longxun on 16/11/6.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nickeName;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"添加好友";
    [self initPopButton];
    [self.image setImageWithURL:[NSURL URLWithString:self.userInfo.PhotpUrl] options:YYWebImageOptionUseNSURLCache];
    self.image.image = [UIImage imageNamed:@"3"];
    self.nickeName.text = self.userInfo.NickName;
    self.location.text = self.userInfo.Street_addr;
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
- (IBAction)addFriend:(id)sender {
    [[WDAlert shareAlert] showLodingWithTitle:@""];

    AddFirend *f = [[AddFirend alloc] init];
    f.type = PTL_REQ;
    f.cmd = PTL_CMD_ADD_FRIEND;
    f.sessionID = [[SocketOprationData shareInit] sessionID];
    f.msg = @"addfriend";
    f.toID = self.userInfo.UserID;
    f.groupID = @"0";
    // NSString *string = [f modelToJSONString];
    
    [[SocketOprationData shareInit] sendReqDataWithObj:f tag:f.cmd objecte:self call:@selector(sendFinish:)];
}
- (void)sendFinish:(id)obj{
    [[WDAlert shareAlert] hiddenHUD];
    if ([obj isKindOfClass:[AddFirend class]]) {
        AddFirend *ff = obj;
        if ([ff.result intValue] == 1) {
            [WDAlert showAlertWithMessage:@"发送成功" time:1.5];
           // [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.5];
        }
    }
}
@end
