//
//  DIYButton.m
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "DIYButton.h"
#import "device.h"

@implementation DIYButton
//我们重新button的frame方法 在里面修改视图
-(void)setFrame:(CGRect)frame
{
    //因为我们setFrame方法会多次调用 如果不删除之前的 这样会造成一个视图堆积的效果
    [_textLable removeFromSuperview];
    [_iconImageView removeFromSuperview];
    [_selectIconImageView removeFromSuperview];
    
        self.backgroundColor = [UIColor colorWithRed:34/255.0 green:38/255.0 blue:42/255.0 alpha:1.0];
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    //创建我们的视图  是一个正方形
    _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake((width-height*0.4)/2, height*0.15, height*0.4, height*0.4)];
    //    _iconImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.iconImageView];
    
    _textLable = [[UILabel alloc] initWithFrame:CGRectMake(0, height*0.55, width , height*0.45)];
    //    _textLable.backgroundColor = [UIColor yellowColor];
    _textLable.textColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1.0];
    _textLable.font = [UIFont systemFontOfSize:10];
    _textLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLable];
    
    _selectIconImageView  = [[UIImageView alloc] initWithFrame:self.iconImageView.frame];
//    _selectIconImageView.backgroundColor = [UIColor blueColor];
    self.selectIconImageView.hidden = YES;
    [self addSubview:self.selectIconImageView];
    
    //记得调用super setFrame方法
    [super setFrame:frame];
}
-(void)setSelected:(BOOL)selected
{
    if (selected) {
        _iconImageView.hidden = YES;
        _selectIconImageView.hidden = NO;
    }else
    {
        _iconImageView.hidden = NO;
        _selectIconImageView.hidden = YES;
    }
    [super setSelected:selected];
}
@end
