//
//  FirewoodCell.m
//  柴火圈
//
//  Created by JOYSW on 16/7/13.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "FirewoodCell.h"
#import "Header.h"

@implementation FirewoodCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.headerImageView = [[UIImageView alloc]init];
        self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
//        self.headerImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.headerImageView];
        
        self.nameLabel = [[UILabel alloc]init];
//        self.nameLabel.backgroundColor = [UIColor greenColor];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.nameLabel];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:lineView];
        
        self.numMember = [[UILabel alloc]init];
        //        self.nameLabel.backgroundColor = [UIColor greenColor];
//        self.numMember.textAlignment = NSTextAlignmentLeft;
        self.numMember.translatesAutoresizingMaskIntoConstraints = NO;
        self.numMember.hidden = YES;
        self.numMember.textColor = [UIColor darkGrayColor];
        self.numMember.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.numMember];
        
        
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(self.mas_height).offset(-20);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImageView.mas_right).offset(20);
            make.top.equalTo(self.headerImageView.mas_top);
            make.bottom.equalTo(self.headerImageView.mas_bottom);
            make.width.mas_equalTo(self.bounds.size.width/2);
        }];
     
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        [self.numMember mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.equalTo(@80);
        }];
    }
    return self;
}



-(void)setModel:(UserInfo *)model
{
    if ([model isKindOfClass:[UserInfo class]]) {
        _model = model;
        if (model.pic == nil || [NSNull null] == (NSNull *)model.pic) {
            self.headerImageView.image = [UIImage imageNamed:@"1"];
        }else{

            if (![model.pic hasPrefix:@"."]) {
                self.headerImageView.image = [UIImage imageNamed:model.pic];
            }else
                [self.headerImageView setImageURL:[NSURL URLWithString:[model.pic appendToHttpUrl]]];
            
        }
       
        self.nameLabel.text = model.nickname;
    }else if ([model isKindOfClass:[CircleInfo class]]) {
        CircleInfo *m = (CircleInfo *)model;
        if (m.qimg == nil || [NSNull null] == (NSNull *)m.qimg) {
            self.headerImageView.image = [UIImage imageNamed:@"2"];
        }else{
            [self.headerImageView setImageURL:[NSURL URLWithString:[m.qimg appendToHttpUrl]]];
        }
        self.nameLabel.text = m.qname;
        self.numMember.text = [NSString stringWithFormat:@"%@人",m.num];
    }
     
}

@end
