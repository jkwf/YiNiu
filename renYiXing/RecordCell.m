//
//  RecordCell.m
//  柴火圈
//
//  Created by 姬荣康 on 2016/12/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell{

    __weak IBOutlet UILabel *_name;
    __weak IBOutlet UILabel *_msg;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithDic:(NSDictionary *)dic{


}


@end
