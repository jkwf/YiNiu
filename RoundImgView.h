//
//  RoundImgView.h
//  RenYiXing
//
//  Created by 姬荣康 on 2016/11/29.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundImgView : UIImageView
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat boderWidth;
@property (nonatomic, assign)IBInspectable UIColor *boderColor;
@property (nonatomic, strong)IBInspectable UIImage *img;
@end
