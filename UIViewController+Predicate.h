//
//  UIViewController+Predicate.h
//  RenYiXing
//
//  Created by 姬荣康 on 2016/11/29.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Predicate)


/**
 检验银行卡(更严密)
 
 @param cardNo <#bankCardNumber description#>
 @return <#return value description#>
 */
- (BOOL)checkCardNo:(NSString*)cardNo;

/**
 检验银行卡
 
 @param bankCardNumber <#bankCardNumber description#>
 @return <#return value description#>
 */
- (BOOL)isBankCardNumberWithInput: (NSString *)bankCardNumber;

/**
 检验身份证
 
 @param idCardString <#idCardString description#>
 @return <#return value description#>
 */
- (BOOL)isIdCardVertifyWithInput:(NSString *)idCardString;

/**
 检验email
 
 @param emailString <#emailString description#>
 @return <#return value description#>
 */
- (BOOL)isEmailAddressWithInput:(NSString *)emailString;

/**
 检验手机号
 
 @param numberString <#numberString description#>
 @return <#return value description#>
 */
- (BOOL)isPhoneNumWithInput:(NSString *)numberString;

/**
 检验真实姓名
 
 @param name <#name description#>
 @return <#return value description#>
 */
- (BOOL)isRealName:(NSString*)name;


@end
