//
//  SocketOprationData.h
//  JSDVideoConference
//
//  Created by Longxun on 16/3/3.
//  Copyright © 2016年 Xunchi. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CallObj : NSObject

@property(strong, nonatomic)id obj;
@property(nonatomic)SEL function;

@end

@class GCDAsyncSocket;
@interface SocketOprationData : NSObject
@property(strong, nonatomic)GCDAsyncSocket *gcdSocket;
@property(strong, nonatomic)NSMutableDictionary *callDictionary;
@property(strong, nonatomic)NSDictionary *loginInfo;
+(id)shareInit;
- (void)initSocket;

-(void)sendReqDataWithValueDic:(NSMutableDictionary*)dic tag:(NSString *)type objecte:(id)obj call:(SEL)callback;
@end
