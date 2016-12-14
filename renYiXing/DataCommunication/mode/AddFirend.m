//
//  AddFirend.m
//  JoyIM
//
//  Created by Longxun on 16/9/16.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import "AddFirend.h"
#import "NSObject+YYModel.h"
@implementation UserInfo
@end
@implementation UserInfomation


@end
@implementation CircleInfo
@end

@implementation Friend
@end
@implementation AddFirend

@end

@implementation HasBulletin


@end
@implementation FetchBulletinFriend


@end
@implementation FetchBulletinRsp

- (NSMutableArray *)arrayList{
    if (_arrayList) {
        return _arrayList;
    }
     NSMutableArray *retArr = [NSMutableArray array];
    if ([_bulletinList isKindOfClass:[NSDictionary class]]) {
       
        NSArray *arr = [_bulletinList objectForKey:@"bulletin"];
        if ([arr isKindOfClass:[NSDictionary class]]) {
            arr = [NSArray arrayWithObject:arr];
        }
        for (NSDictionary *dic in arr) {
            [retArr addObject:[BulletinObj modelWithDictionary:dic]];
        }
    }
      return  retArr;
}
@end
@implementation BulletinObj

@end
@implementation QueryUserRequestMode


@end
@implementation SearchUserRequestMode



@end

@implementation AddCircle


@end

@implementation GroupMsg


@end

@implementation FetchGroupMsg


@end
