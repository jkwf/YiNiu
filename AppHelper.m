//
//  AppHelper.m
//  WebService
//
//  Created by 姬荣康 on 16/05/24.
//  Copyright (c) 2016年 rang. All rights reserved.
//

#import "AppHelper.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>


@implementation AppHelper
static MBProgressHUD *HUD;
static MBProgressHUD *nonBlockingHUD;
static NSString *prev_msg;
//MBProgressHUD 的使用方式，只对外两个方法，可以随时使用(但会有警告！)，其中窗口的 alpha 值 可以在源程序里修改。
+ (void)showHUD:(NSString *)msg{
    if( [prev_msg isEqualToString:msg] )
        return;
	[AppHelper removeHUD];
    if( [UIApplication sharedApplication].keyWindow ) {
        HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
        HUD.dimBackground = YES;
        HUD.labelText = msg;
        [HUD show:YES];
        [HUD setRemoveFromSuperViewOnHide:YES];
        prev_msg = msg;
    }
}
+ (void)removeHUD{
	if( HUD )
    {
        [HUD hide:YES];
        HUD = nil;
        prev_msg = @"";
    }
}

/**
 消息弹窗

 @param dict <#dict description#>
 */
+ (void)toastMessage:(NSDictionary*)dict{
    
    [self toastMessage:dict window:[ApplicationDelegate window]];
}
+ (void)toastMessage:(NSDictionary*)dict window:(UIWindow*)window{
    if( [dict.allKeys containsObject:@"message"] && [dict[@"message"] isKindOfClass:[NSString class]] )
        [AppHelper showNonBlockingHUD:[NSString stringWithFormat:@"%@",dict[@"message"]]
                                addto:window
                    hideWithinSeconds:3];
}

+ (void)showNonBlockingHUD:(NSString *)msg addto:(UIView*)superview hideWithinSeconds:(NSTimeInterval)delay{
    [AppHelper removeNonBlockingHUD];
    nonBlockingHUD = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    nonBlockingHUD.mode = MBProgressHUDModeText;
    //    nonBlockingHUD.color = [UIColor colorWithRed:0.87 green:0.43 blue:0.42 alpha:0.9];
    nonBlockingHUD.color = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
    nonBlockingHUD.userInteractionEnabled = NO;
    nonBlockingHUD.detailsLabelColor = [UIColor whiteColor];
    nonBlockingHUD.detailsLabelText = msg;
    [nonBlockingHUD hide:YES afterDelay:delay];
}
+ (void)removeNonBlockingHUD{
    if( nonBlockingHUD )
    {
        [nonBlockingHUD hide:YES];
        nonBlockingHUD = nil;
    }
}

+ (UIColor *)defaultEnableColor{
    static UIColor *enableColor = nil;
    if( enableColor == nil )
        enableColor = [UIColor colorWithRed:0x2D/255.0 green:0xAD/255.0 blue:0xA1/255.0 alpha:1.0];
    return enableColor;
}

#pragma mark -- 绘制虚线

/**
 绘制垂直虚线

 @param lineView 展示
 @param lineLength 线长
 @param lineSpacing 线之间的间隔
 @param lineColor 线的颜色
 */
+ (void)drawVerticalDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame), CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:0.5];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

/**
 绘制水平虚线
 
 @param lineView 展示
 @param lineLength 线长
 @param lineSpacing 线之间的间隔
 @param lineColor 线的颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:0.5];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
#pragma mark -- 富文本
+ (NSMutableAttributedString*)drawLabWithString:(NSString *)str withFirstLocation:(NSInteger)firstInter withFirstLength:(NSInteger)firstLength withSecondLocation:(NSInteger)secondInter withSecondLength:(NSInteger)secondLength withFontOfSize:(CGFloat)fontSize{
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(firstInter, firstLength)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(firstInter, firstLength)];
    
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(secondInter, secondLength)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(secondInter, secondLength)];
    
    return string;
    
}

+ (UIViewController *)activityViewController{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}


@end
