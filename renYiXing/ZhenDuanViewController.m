//
//  ZhenDuanViewController.m
//  柴火圈
//
//  Created by Longxun on 16/11/4.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "ZhenDuanViewController.h"
#import "WebViewController.h"
@interface ZhenDuanViewController ()

@end

@implementation ZhenDuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPopButton];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAction:(UIButton *)sender {
    
    WebViewController *web = [[WebViewController alloc] init];
    if (sender.tag == 10) {
        web.urlString = URLOffenQuestion;
        web.navigationItem.title = @"普通求诊";
    }else{
        
        web.urlString = URLExpertQuestion;
        web.navigationItem.title = @"专家门诊";
    }
    

    [self.navigationController pushViewController:web animated:YES];
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
