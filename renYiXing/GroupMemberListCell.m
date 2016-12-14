//
//  GroupMemberListCell.m
//  柴火圈
//
//  Created by 姬荣康 on 2016/12/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "GroupMemberListCell.h"
#import "UIImageView+WebCache.h"
@implementation GroupMemberListCell{

    __weak IBOutlet UIImageView *_head;
    __weak IBOutlet UILabel *_name;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)confignWithDic:(NSDictionary *)dic{

    _name.text = dic[@"nickname"];
    
    if (![dic[@"pic"] isKindOfClass:[NSNull class]]) {
        [_head sd_setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    }else{
        _head.image = [UIImage imageNamed:@"morentouxiang"];
    }
    
    
    


}
@end
