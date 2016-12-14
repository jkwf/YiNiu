

#import "WDAlert.h"

@implementation WDAlert
+ (void)alertWithMessage:(NSString *)message title:(NSString*)title{
	// open an alert with an OK button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:nil
										  cancelButtonTitle:@"确定"
										  otherButtonTitles: nil];
	[alert show];

}

+ (void)alertWithMessage:(NSString *)message{
    [WDAlert alertWithMessage:message title:@"提示"];
    
}
//+(void)showLodingWithTitle:(NSString*)title message:(NSString*)message
//{
//    NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] init] autorelease];
//    if (title) {
//        [dictionary setObject:title forKey:@"title"];
//    }
//    if (message) {
//        [dictionary setObject:message forKey:@"message"];
//    }
//    [NSThread detachNewThreadSelector:@selector(threedLKLoading:) toTarget:self withObject:dictionary];
//}








+(void)showAlertWithMessage:(NSString*)message time:(NSTimeInterval)time{
//    for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
//        if (view.tag == 10000) {
//            return;
//        }
//    }
//    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, MAINSCREEN_WIDTH, 45)];
//    [alertView setTag:10000];
//    [alertView setBackgroundColor:[UIColor clearColor]];
//    UIImageView *alertbackImageView = [[UIImageView alloc] initWithFrame:alertView.frame];
//    [alertbackImageView setBackgroundColor:[UIColor blackColor]];
//    [alertbackImageView setAlpha:0.6];
//    [alertView addSubview:alertbackImageView];
//    [alertbackImageView release];
//    
//    UILabel *messageLable = [[UILabel alloc] initWithFrame:alertView.frame];
//    [messageLable setBackgroundColor:[UIColor clearColor]];
//    [messageLable setTextAlignment:NSTextAlignmentCenter];
//    [messageLable setTextColor:[UIColor whiteColor]];
//    [messageLable setText:message];
//    [alertView addSubview:messageLable];
//    [messageLable release];
//    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        [alertView setFrame:CGRectMake(0,40, MAINSCREEN_WIDTH, 45)];
//    } completion:^(BOOL finish) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [UIView animateWithDuration:0.2 animations:^{
//                [alertView setFrame:CGRectMake(0, -20, MAINSCREEN_WIDTH, 45)];
//            } completion:^(BOOL finish) {
//                [alertView removeFromSuperview];
//                [alertView release];
//            }];
//        });
//
//    }];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    
    //HUD.delegate = self;
    HUD.labelText = message;
    HUD.mode = MBProgressHUDModeCustomView;
    //HUD.square = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:time];
}
+(void)showAlertWithMessage:(NSString*)message time:(NSTimeInterval)time superView:(UIView*)superview{

    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:superview];
    [superview addSubview:HUD];
    
    //HUD.delegate = self;
    HUD.labelText = message;
    HUD.mode = MBProgressHUDModeCustomView;
    //HUD.square = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:time];
    
}

+(void) hideTabBar:(UITabBarController *) tabbarcontroller {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
        }
    }
    [UIView commitAnimations];
}

+(void) showTabBar:(UITabBarController *) tabbarcontroller {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
//        NSLog(@"%@", view);
        
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
        }
    }
    
    [UIView commitAnimations];
}

#pragma mark Singleton
+ (WDAlert *)shareAlert
{
    static WDAlert *defaultAlert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAlert = [[WDAlert alloc] init];
    });
    return defaultAlert;
}
#pragma mark MBProgressHUD
- (void)showLodingWithTitle:(NSString*)title delay:(NSTimeInterval)time
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    HUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = title;
	HUD.square = YES;
	[HUD show:YES];
    [HUD hide:YES afterDelay:time];
}
- (void)showLodingWithTitle:(NSString*)title withView:(UIView *)view delay:(NSTimeInterval)time
{
    [[WDAlert shareAlert] showLodingWithTitle:title message:nil withView:view];
    [HUD hide:YES afterDelay:time];
}
- (void)showLodingWithTitle:(NSString*)title
{
    [[WDAlert shareAlert] showLodingWithTitle:title message:nil withView:nil];
}
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message
{
    [[WDAlert shareAlert] showLodingWithTitle:title message:message withView:nil];
}
- (void)showLodingWithTitle:(NSString*)title withView:(UIView *)view{
    [[WDAlert shareAlert] showLodingWithTitle:title message:nil withView:view];
}
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view{
    if (!view) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];

        HUD = [[MBProgressHUD alloc] initWithView:window];
        [window addSubview:HUD];
    }else
    {
        if (HUD) {
            [HUD hide:YES];
        }
        HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
    }
    HUD.delegate = self;
    HUD.labelText = title;
    HUD.detailsLabelText = message;
	HUD.square = YES;
	[HUD show:YES];
}
- (void)hiddenHUD
{
    if (HUD) {
        [HUD hide:YES];
    }
}
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}
@end
