//
//  UIViewController+Predicate.m
//  RenYiXing
//
//  Created by 姬荣康 on 2016/11/29.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import "UIViewController+Predicate.h"

@implementation UIViewController (Predicate)



/**
 检验手机号
 
 @param numberString <#numberString description#>
 @return <#return value description#>
 */
- (BOOL)isPhoneNumWithInput:(NSString *)numberString{
    NSString* number = @"^(0|\\+)?(86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:numberString];
}

/**
 检验email
 
 @param emailString <#emailString description#>
 @return <#return value description#>
 */
- (BOOL)isEmailAddressWithInput:(NSString *)emailString {
    NSString* number = @"^[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z\\.]*[a-zA-Z]$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:emailString];
}

/**
 检验身份证
 
 @param idCardString <#idCardString description#>
 @return <#return value description#>
 */
- (BOOL)isIdCardVertifyWithInput:(NSString *)idCardString {
    NSString* number = @"(^\\d{15}$)|(^\\d{17}([0-9]|X)$)";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:idCardString];

}

/**
 检验银行卡
 
 @param bankCardNumber <#bankCardNumber description#>
 @return <#return value description#>
 */
- (BOOL)isBankCardNumberWithInput: (NSString *)bankCardNumber{
    NSString* number = @"^(\\d{15,30})";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:bankCardNumber];
}

/**
 检验银行卡(更严密)
 
 @param cardNo <#bankCardNumber description#>
 @return <#return value description#>
 */
- (BOOL)checkCardNo:(NSString*)cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1]intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 检验真实姓名
 
 @param name <#name description#>
 @return <#return value description#>
 */
- (BOOL)isRealName:(NSString*)name{
    NSString* number = @"^[\u4e00-\u9fa5]{2,}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:name];
}






@end
