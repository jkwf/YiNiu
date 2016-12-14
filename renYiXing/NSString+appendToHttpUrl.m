//
//  NSString+appendToHttpUrl.m
//  柴火圈
//
//  Created by Longxun on 16/11/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "NSString+appendToHttpUrl.h"

@implementation NSString (appendToHttpUrl)
- (NSString *)appendToHttpUrl{
    if ([self hasPrefix:@"http"]) {
        return self;
    }else{
        [self stringByReplacingOccurrencesOfString:@"" withString:@"."];
        return [NSString stringWithFormat:@"%@%@",DomainUrl,self];
    }
}
@end
