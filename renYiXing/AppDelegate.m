//
//  AppDelegate.m
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FirstViewController.h"
#import "Header.h"

@interface AppDelegate () <UISplitViewControllerDelegate,UIAlertViewDelegate>



@end

@implementation AppDelegate

- (void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账号在其他地点登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    MainViewController *vc = [[MainViewController alloc]init];
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    [nav pushViewController:vc animated:YES];
    NSLog(@"--------%@",[self.window.rootViewController class]);
}

- (void)loginWithIm{
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{NODE_USER_NAME:LoginUserName    ,NODE_PASSWORD:[LoginPassword md5String],NODE_DOMAIN:@"9000"}];
    [[SocketOprationData shareInit] sendReqDataWithValueDic:dict tag:PTL_CMD_LOGIN objecte:self call:@selector(loginResult:)];
    
    
}

- (void)loginResult:(NSDictionary *)dic{
    int r = [dic[NODE_RESULT_NAME] intValue];
    if (r == 1){
        
        SetLoginUserId(dic[@"sessionID"]);
        SetLoginNickName(dic[@"nickname"]);
        SetSynchronize;
        
    }else{
        [AppHelper toastMessage:@{@"message":dic[NODE_ERR_NAME]}];
    }
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAlert) name:@"loginOutByAnother" object:nil];;
    
    
    
    
    /**
     设置返回键

     @param 0 <#0 description#>
     @param -60 <#-60 description#>
     @return <#return value description#>
     */
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    [[CoreDataTool shareData] initCoredata];

    //[self getTurn];
    [[SocketOprationData shareInit] initSocket];
     [SMSSDK registerApp:appKey withSecret:appSecret];
    
    
//    //注册环信
//    [[EaseMob sharedInstance]registerSDKWithAppKey:@"easytrader#easytrader" apnsCertName:@""];
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
//    EMOptions *options = [EMOptions optionsWithAppkey:@"easytrader#easytrader"];
////    options.apnsCertName = @"istore_dev";
//    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    
    if (LoginUserId){
        [self loginWithIm];
        FirstViewController *firstVc = [[FirstViewController alloc]init];
        UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:firstVc];
        self.window.rootViewController = rootNav;
    }
    else{
        MainViewController *mainVc = [[MainViewController alloc]init];
        UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:mainVc];
        self.window.rootViewController = rootNav;

   }


    [self.window makeKeyAndVisible];
    //    //设置状态栏的字体颜色模式
    
    //    改变状态栏的背景色
//    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, 20)];
//    
//    statusBarView.backgroundColor=[UIColor whiteColor];
////    statusBarView.alpha = 0.5;
//    
//    [self.window addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [[EMClient sharedClient] applicationDidEnterBackground:application];
//    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
//    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)getTurn{
    
    [WebShareData getDataFromWebWithParams:nil contentType:@"text/plain" urlString:GetTurnServer successBlock:^(NSDictionary *dicInfo) {
        [[NSUserDefaults standardUserDefaults] setObject:dicInfo[@"userName"] forKey:@"TurnUserName"];
        [[NSUserDefaults standardUserDefaults] setObject:dicInfo[@"password"] forKey:@"TurnPassword"];
        [[NSUserDefaults standardUserDefaults] setObject:dicInfo[@"urls"] forKey:@"TurnUrl"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failBlock:^(NSError *error) {
        
    }];
}


@end
