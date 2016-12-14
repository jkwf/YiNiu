
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface WDAlert : NSObject<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
+ (WDAlert *)shareAlert;
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view;
- (void)showLodingWithTitle:(NSString*)title withView:(UIView *)view;
- (void)showLodingWithTitle:(NSString*)title withView:(UIView *)view delay:(NSTimeInterval)time;
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message;
- (void)showLodingWithTitle:(NSString*)title;
- (void)showLodingWithTitle:(NSString*)title delay:(NSTimeInterval)time;
- (void)hiddenHUD;


+ (void)alertWithMessage:(NSString *)message title:(NSString*)title;
+ (void)alertWithMessage:(NSString *)message;
+ (void)showAlertWithMessage:(NSString*)message time:(NSTimeInterval)time;
+(void)showAlertWithMessage:(NSString*)message time:(NSTimeInterval)time superView:(UIView*)superview;
+ (void) hideTabBar:(UITabBarController *) tabbarcontroller;
+ (void) showTabBar:(UITabBarController *) tabbarcontroller;
@end
