//
//  UIColor+Hex.m
//  NCENew
//
//  Created by 丁岑 on 15/7/18.
//  Copyright (c) 2015年 cn.edu.ustc. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor(Hex)

+ (instancetype)colorWithHex:(NSInteger)hex {
    return [UIColor colorWithHex:hex alpha:1];
}

+ (instancetype)colorWithHex:(NSInteger)hex alpha:(double)alpha{
    NSInteger r = hex / 0x10000;
    NSInteger g = (hex - r * 0x10000) / 0x100;
    NSInteger b = (hex - r * 0x10000 - g * 0x100);
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alpha];
}

@end
