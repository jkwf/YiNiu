//
//  UIColor+Hex.h
//  NCENew
//
//  Created by 丁岑 on 15/7/18.
//  Copyright (c) 2015年 cn.edu.ustc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Hex)

+ (instancetype)colorWithHex:(NSInteger)hex;
+ (instancetype)colorWithHex:(NSInteger)hex alpha:(double)alpha;

@end
