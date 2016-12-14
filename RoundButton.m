//
//  RoundButton.m
//  虚线demo
//
//  Created by 姬荣康 on 16/6/14.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import "RoundButton.h"
IB_DESIGNABLE
@implementation RoundButton

- (void)setBoderColor:(UIColor *)boderColor {
    _boderColor = boderColor;
    self.layer.borderColor = _boderColor.CGColor;
}

- (void)setBoderWidth:(CGFloat)boderWidth {
    _boderWidth = boderWidth;
    self.layer.borderWidth = _boderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
//    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(0, 3);
//    self.layer.shadowOpacity = 0.5;
    self.layer.cornerRadius  = _cornerRadius;
    
}

@end
