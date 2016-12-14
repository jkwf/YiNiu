//
//  Websocket.m
//  JoyIM
//
//  Created by Longxun on 16/9/13.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import "Websocket.h"
//#import "TestViewController.h"
#import "NSDictionary+YYAdd.h"
#define WebSocketInvite @"ws://linux.joysw.cn:8080/yitongxun/voip?"
@implementation Websocket
+(id)shareInit{
    static SocketOprationData *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}

- (void)openSocket{
    NSString *str = [NSString stringWithFormat:@"%@userName=%@",WebSocketInvite, [[SocketOprationData shareInit]loginInfo][@"userId"]];
    _socketInvite = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:str]];
    _socketInvite.delegate = self;
    [_socketInvite open];
    
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"邀请的WebSocket connection opened.");
    if (webSocket == _socketInvite){
        
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSString *messageString = message;
    NSData *messageData = [messageString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:messageData
                                                    options:0
                                                      error:nil];
    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Unexpected message: %@", jsonObject);
        return;
    }
    NSDictionary *wssMessage = jsonObject;
    
    NSLog(@"======================%@",wssMessage);
    NSString *event = wssMessage[@"event"];
    if ([event isEqualToString:WS_Event_Call]) {
//        //[[NSNotificationCenter defaultCenter] postNotificationName:WS_Event_Call object:wssMessage];
//        UIViewController *vc = [self getCurrentVC];
//        TestViewController *tvc = [[TestViewController alloc] init];
//        tvc.toId = wssMessage[@"fromId"];
//        tvc.roomId = [NSString stringWithFormat:@"%@%@",wssMessage[@"fromId"],[[SocketOprationData shareInit] sessionID]];//wssMessage[@"roomId"];
//        self.roomid = tvc.roomId;
//        tvc.isVideo = [wssMessage[@"type"] isEqualToString:Invite_Type_Video];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tvc];
//        [vc presentViewController:nav animated:YES completion:nil];
       
    }else if ([event isEqualToString:WS_Event_Agree]){
        [[NSNotificationCenter defaultCenter] postNotificationName:WSOtherAction object:wssMessage];
        
    }else if ([event isEqualToString:WS_Event_Deline]){
        
    }else if ([event isEqualToString:WS_Event_Hangup]){
        [[NSNotificationCenter defaultCenter] postNotificationName:WSOtherAction object:wssMessage];
    }
    return;

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"WebSocket error: %@", error);
    //self.state = kARDWebSocketChannelStateError;
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason
         wasClean:(BOOL)wasClean {
    NSLog(@"邀请的WebSocket closed with code: %ld reason:%@ wasClean:%d",
          (long)code, reason, wasClean);
    [self openSocket];
    //    NSParameterAssert(_state != kARDWebSocketChannelStateError);
    //    self.state = kARDWebSocketChannelStateClosed;
}



- (void)connectWithId:(NSString *)userid type:(NSString *)type event:(NSString *)event{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"event"] = event;
    dic[@"toId"] = userid;
    dic[@"fromId"] = [[SocketOprationData shareInit]loginInfo][@"userId"];
    dic[@"type"] = type;
    dic[@"roomId"] = self.roomid;
    NSString *jsonString = [dic jsonStringEncoded];
    NSLog(@"========%@",jsonString);
    [self.socketInvite send:jsonString];
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
