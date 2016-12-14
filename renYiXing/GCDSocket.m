//
//  GCDSocket.m
//  柴火圈
//
//  Created by JOYSW on 16/8/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "GCDSocket.h"

@implementation GCDSocket
+(GCDSocket *)sharedInstance
{
    static GCDSocket *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}
@end
