//
//  RoundView.m
//  虚线demo
//
//  Created by 姬荣康 on 16/6/13.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import "RoundView.h"
IB_DESIGNABLE
@implementation RoundView

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
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBackgroundIMG:(UIImage *)backgroundIMG {
    _backgroundIMG = backgroundIMG;
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundIMG];
}

@end
