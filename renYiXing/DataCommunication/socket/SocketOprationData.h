//
//  SocketOprationData.h
//  JSDVideoConference
//
//  Created by Longxun on 16/3/3.
//  Copyright © 2016年 Xunchi. All rights reserved.
//
//为了方便快速没有遵循设计模式  从新定义了方式

#define MessageTypeVoice @"voice"
#define MessageTypePicture @"picture"
#define MessageTypeData @"data"
#define NotificationFetchMsg @"NotificationFetchMsg"
#define NotificationFetchGroupMsg @"NotificationFetchGroupMsg"
#define VoicePath(filename)   [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:filename] //[[DealPictureMode shareInstance] getResourcePath:@"Voice" file:filename]  //filename 带扩展名

#define ImagePath(filename)  [[DealPictureMode shareInstance] getResourcePath:@"Image" file:filename] //filename 带扩展名


#import <Foundation/Foundation.h>
@interface CallObj : NSObject

@property(strong, nonatomic)id obj;
@property(nonatomic)SEL function;
@property(strong, nonatomic) NSString *url;
@property(nonatomic) int timeLong;
@end

@class GCDAsyncSocket;
@interface SocketOprationData : NSObject
@property(strong, nonatomic)GCDAsyncSocket *gcdSocket;
@property(strong, nonatomic)NSMutableDictionary *callDictionary;
@property(strong, nonatomic)NSDictionary *loginInfo;
@property(nonatomic) long long meetingID;
@property(nonatomic,strong) NSString *sessionID;
+(id)shareInit;
- (void)initSocket;
-(void)sendReqDataWithValueDic:(NSMutableDictionary*)dic tag:(NSString *)type objecte:(id)obj call:(SEL)callback;
-(void)sendReqDataWithObj:(id)objValue tag:(NSString *)type objecte:(id)obj call:(SEL)callback;
@end

@interface FileSocket : NSObject
@property(strong, nonatomic)GCDAsyncSocket *gcdSocket;
@property(strong, nonatomic)NSMutableDictionary *callDictionary;
@property(strong, nonatomic)NSDictionary *loginInfo;
@property(nonatomic) long long meetingID;
+(id)shareInit;
- (void)initSocket;
-(void)sendReqDataWithValueDic:(NSMutableDictionary*)dic tag:(NSString *)type objecte:(id)obj call:(SEL)callback;
- (void)closeSocket;
@end



