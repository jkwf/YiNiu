//
//  UIViewController+X.h
//  RenYiXing
//
//  Created by 姬荣康 on 2016/11/29.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (X)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (void)openCamera;
- (void)openAlbum;

- (void)verifyWithAction:(SEL)action ;
- (void)removeAlertView;

/**
 计算lab的高度

 @param str <#str description#>
 @param font <#font description#>
 @param labW <#labW description#>
 @return <#return value description#>
 */
- (CGSize)labSizeWithString:(NSString *)str withFont:(int)font withLabWidth:(CGFloat)labW;

@end
