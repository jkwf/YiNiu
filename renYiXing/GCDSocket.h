//
//  GCDSocket.h
//  柴火圈
//
//  Created by JOYSW on 16/8/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface GCDSocket : NSObject<GCDAsyncSocketDelegate>
+(GCDSocket *)sharedInstance;
@end
