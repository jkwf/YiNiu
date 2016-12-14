//
//  BaseViewController.m
//  LiveProject
//
//  Created by Longxun on 16/9/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import "BaseViewController.h"
@implementation UIViewController (LeftBackButton)
-(void)initPopButton{
    self.view.backgroundColor = RGBACOLOR(232., 232., 232., 1.);//BackGroundColors;

    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];

//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"leftback"] forState:UIControlStateNormal];
//    //[backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateHighlighted];
//    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    backButton.frame =CGRectMake(0, 0, 33,32);
//    UIBarButtonItem *items = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem = items;
    
}
-(void)initPresentButton{
    self.view.backgroundColor = RGBACOLOR(232., 232., 232., 1.);//BackGroundColors;

    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];

//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"leftback"] forState:UIControlStateNormal];
//    //[backButton setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateHighlighted];
//    [backButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
//    backButton.frame =CGRectMake(0, 0, 33,32);
//    UIBarButtonItem *items = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem = items;
}
- (void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor] size:CGSizeMake(kScreenWidth, 64.)] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = RGBACOLOR(232., 232., 232., 1.);//BackGroundColors;
    UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = image;
    UIImage *imagenor = [self.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.image = imagenor;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    if ([self isKindOfClass:[FirstViewController class]]||[self isKindOfClass:[SettingViewController class]]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"CenternButtonHidden" object:@(YES)];
//    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"CenternButtonHidden" object:@(NO)];
//
//    }
    
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

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RedColorNormal size:CGSizeMake(kScreenWidth, 64.)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    //self.view.backgroundColor = BackGroundColors;
    UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = image;
    UIImage *imagenor = [self.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.image = imagenor;
    //self.tableView.backgroundColor = BackGroundColors;
    self.tableView.backgroundView = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
