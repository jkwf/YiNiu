//
//  FirewoodCell.h
//  柴火圈
//
//  Created by JOYSW on 16/7/13.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirewoodModel.h"

@interface FirewoodCell : UITableViewCell
@property(nonatomic , strong)UIImageView *headerImageView;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UserInfo *model;
@property(nonatomic, strong) UILabel *numMember;
@end
