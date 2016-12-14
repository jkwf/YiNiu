//
//  RoundImgView.m
//  RenYiXing
//
//  Created by 姬荣康 on 2016/11/29.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import "RoundImgView.h"
IB_DESIGNABLE
@implementation RoundImgView
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
- (void)setImg:(UIImage *)img{
    _img = img;
    self.image = _img;
}

@end
