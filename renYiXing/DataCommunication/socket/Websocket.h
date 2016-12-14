//
//  Websocket.h
//  JoyIM
//
//  Created by Longxun on 16/9/13.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
#define WS_Event_Call @"call"
#define WS_Event_Agree @"agree"
#define WS_Event_Deline @"deline"
#define WS_Event_Busy @"busy"
#define WS_Event_Hangup @"hangup"

#define Invite_Type_Voice @"voice"
#define Invite_Type_Video @"video"

#define WSOtherAction @"WSOtherAction"
@interface Websocket : NSObject<SRWebSocketDelegate>
@property(nonatomic, strong) SRWebSocket *socketInvite;
@property(nonatomic, strong) NSString *roomid;
- (void)openSocket;
+(id)shareInit;
- (void)connectWithId:(NSString *)userid type:(NSString *)type event:(NSString *)event;
@end
