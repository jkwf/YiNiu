//
//  DiyView.m
//  renYiXing
//
//  Created by JOYSW on 16/6/30.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "DiyView.h"
#import "Masonry.h"

@implementation DiyView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.headView = [[UIImageView alloc]init];
        self.headView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.headView];
        
        self.userNameLabel = [[UILabel alloc]init];
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        self.userNameLabel.backgroundColor = [UIColor greenColor];
//        self.userNameLabel.text = @"miholsa";
        [self addSubview:self.userNameLabel];
        
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        self.contentLabel.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
//        self.contentLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.contentLabel];
        
        self.rightIcon = [[UIImageView alloc]init];
        [self.rightIcon setImage:[UIImage imageNamed:@"right"]];
        self.rightIcon.translatesAutoresizingMaskIntoConstraints = NO;
//        self.rightIcon.backgroundColor = [UIColor redColor];
        [self addSubview:self.rightIcon];
        
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(self.frame.size.height-20);
        }];
         [self.headView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(self.frame.size.width/4);
        }];
        [self.userNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.mas_top).offset((self.frame.size.height/4*3)/2);
            make.width.mas_equalTo(self.frame.size.height/4);
            make.height.mas_equalTo(self.frame.size.height/4);
        }];
         [self.rightIcon setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightIcon.mas_left).offset(-10);
            make.top.equalTo(self.userNameLabel.mas_top);
            make.bottom.equalTo(self.userNameLabel.mas_bottom);
            make.width.mas_equalTo(self.frame.size.width/3);
        }];
         [self.contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    
    return self;
}
@end
