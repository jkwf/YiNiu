//
//  MyTableViewCell.m
//  easyTrader
//
//  Created by JOYSW on 16/7/6.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "MyTableViewCell.h"
#import "Masonry.h"

@implementation MyTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.iconImageView = [[UIImageView alloc]init];
//        self.iconImageView.backgroundColor = [UIColor blackColor];
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc]init];
//        self.nameLabel.backgroundColor = [UIColor redColor];
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.nameLabel];
        
        self.contentLabel = [[UILabel alloc]init];
//        self.contentLabel.backgroundColor = [UIColor orangeColor];
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        self.contentLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.contentLabel];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
        bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:bottomView];
//        self.rightIcon = [[UIImageView alloc]init];
//        self.rightIcon.image = [UIImage imageNamed:@"right"];
//        self.rightIcon.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.contentView addSubview:self.rightIcon];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(self.frame.size.height-25);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(self.frame.size.width/3);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-30);
            make.top.equalTo(self.nameLabel.mas_top);
            make.bottom.equalTo(self.nameLabel.mas_bottom);
            make.width.mas_equalTo(self.frame.size.width/3);
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(2);
        }];
        
//        [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-10);
//            make.top.equalTo(self.contentLabel.mas_top);
//            make.width.mas_equalTo(self.frame.size.height/3);
//            make.height.mas_equalTo(self.frame.size.height/3);
//        }];
        
    }
    return self;
}


@end
