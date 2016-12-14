//
//  RecentTableViewCell.m
//  JoyIM
//
//  Created by Longxun on 16/9/17.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import "RecentTableViewCell.h"

@implementation RecentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.agreeBtn.hidden = YES;
    self.rejectBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
