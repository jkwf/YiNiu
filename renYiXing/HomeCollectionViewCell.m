//
//  HomeCollectionViewCell.m
//  renYiXing
//
//  Created by 朱佳伟 on 16/6/29.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "Masonry.h"

@implementation HomeCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.picImageView = [[UIImageView alloc]init];
        self.picImageView.translatesAutoresizingMaskIntoConstraints = NO;
//        self.picImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_picImageView];
        
        
        self.label = [[UILabel alloc]init];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.textColor = [UIColor grayColor];
        self.label.font = [UIFont systemFontOfSize:15 weight:0.1];
        self.label.textAlignment = NSTextAlignmentCenter;
//        self.label.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_label];
     
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(self.contentView.frame.size.width/4);
            make.top.equalTo(self.contentView.mas_top).offset(self.contentView.frame.size.width/10);
            make.width.mas_equalTo(self.contentView.frame.size.width/2);
            make.height.mas_equalTo(self.contentView.frame.size.width/2);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.picImageView.mas_bottom);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        
        
    }
    return self;
}
@end
