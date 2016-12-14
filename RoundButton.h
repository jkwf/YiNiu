//
//  RoundButton.h
//  虚线demo
//
//  Created by 姬荣康 on 16/6/14.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundButton : UIButton

@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat boderWidth;
@property (nonatomic, assign)IBInspectable UIColor *boderColor;

@end
