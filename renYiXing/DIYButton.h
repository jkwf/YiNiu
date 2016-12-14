//
//  DIYButton.h
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIYButton : UIButton
//添加上readonly使外界只能改变他的属性  不能够替换他
@property(nonatomic, strong, readonly)UILabel *textLable;
@property(nonatomic, strong, readonly)UIImageView *iconImageView;
@property(nonatomic, strong, readonly)UIImageView *selectIconImageView;
@end
