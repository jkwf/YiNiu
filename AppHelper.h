//
//  AppHelper.h
//  WebService
//
//  Created by aJia on 12/12/24.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject

+ (void)showHUD:(NSString *)msg;
+ (void)removeHUD;

+ (void)showNonBlockingHUD:(NSString *)msg addto:(UIView*)superview hideWithinSeconds:(NSTimeInterval)delay;
+ (void)toastMessage:(NSDictionary*)dict;
+ (void)toastMessage:(NSDictionary*)dict window:(UIWindow*)window;

+ (UIColor *)defaultEnableColor;



+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
+ (void)drawVerticalDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

+ (NSMutableAttributedString*)drawLabWithString:(NSString *)str withFirstLocation:(NSInteger)firstInter withFirstLength:(NSInteger)firstLength withSecondLocation:(NSInteger)secondInter withSecondLength:(NSInteger)secondLength withFontOfSize:(CGFloat)fontSize;

+ (UIViewController *)activityViewController;
@end
