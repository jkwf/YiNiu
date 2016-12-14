//
//  SocketOprationData.m
//  JSDVideoConference
//
//  Created by Longxun on 16/3/3.
//  Copyright © 2016年 Xunchi. All rights reserved.
//

#import "SocketOprationData.h"
#import "GCDAsyncSocket.h"
#import "Comm.h"
#import "XMLDictionary.h"
#import "Websocket.h"
#import "AddFirend.h"
#import "NSObject+YYModel.h"
#import "Message.h"
#import "NSString+YYAdd.h"
#import "SaveDataUtil.h"

@implementation CallObj

@end
@interface SocketOprationData()<GCDAsyncSocketDelegate>
@property(nonatomic, strong)NSMutableData *recevieData;
@end
@implementation SocketOprationData
+(id)shareInit{
    static SocketOprationData *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}

- (void)initSocket{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSocket:) name:ConnectSocket object:nil];
    _gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    self.callDictionary = [NSMutableDictionary dictionary];
    
    [self connectSocket:nil];
}

-(void)connectSocket:(NSNotification*)noti
{

    NSError *err = nil;
    if ([_gcdSocket isDisconnected])
    {
        
        if ([UIApplication sharedApplication].keyWindow!=nil) {

        }
        if (![_gcdSocket connectToHost:HOST onPort:PORT error:&err])
        {
            NSLog(@"I goofed: %@", err);
        }
    }
}

#pragma mark SocketDelegate
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
    NSLog(@"disconnect...");
    [self connectSocket:nil];
}
- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:ConnectionFinish object:nil];
    NSLog(@"connected!!!");
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{NODE_USER_NAME:@"lw001",NODE_PASSWORD:[@"123456" md5String],NODE_DOMAIN:@"9000"}];
//    [[SocketOprationData shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_LOGIN objecte:self call:@selector(callBackLogin:)];
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [sock readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSLog(@"recTag:  %ld",tag);
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *result = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];//[[NSString alloc] initWithData:data  encoding:enc];
    
    if (result==nil||result==NULL||[result isEqualToString:@""]) {
        result=[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:enc];
    }
    if (result==nil||result==NULL||[result isEqualToString:@""]) {
        
        result=[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding];
    }
    NSMutableData *recData = [[NSMutableData alloc]init];
    [recData appendData:[result dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"recevieXml:count：%ld  %@",(unsigned long)[data length],result);
    
    [self recevieData:recData tag:tag];

    [sock readDataWithTimeout:-1 tag:tag];
}

#pragma mark ------
-(void)sendReqDataWithValueDic:(NSMutableDictionary*)dicAll tag:(NSString *)type objecte:(id)obj call:(SEL)callback
{
    
    NSMutableDictionary *dictTemp = [NSMutableDictionary dictionary] ;
    dicAll[NODE_TYPE_NAME] = PTL_REQ;
    dicAll[NODE_CMD_NAME] = type;
    dicAll[NODE_SESSION_ID] = self.loginInfo[NODE_SESSION_ID];//[SystemManagement shareInstance].SessionId;
    dictTemp[NODE_ROOT_NAME] = dicAll;

    
    NSString *strXmlTemp = [dictTemp XMLString];
    CallObj *object = [[CallObj alloc] init];
    object.obj = obj;
    object.function = callback;
    [self.callDictionary setObject:object forKey:type];
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *sendData = [[NSMutableData alloc]init];
    [sendData appendData:[strXmlTemp dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%ld %ld  sendxml:  %@",(unsigned long)strXmlTemp.length,(unsigned long)sendData.length,strXmlTemp);
    [self.gcdSocket writeData:sendData withTimeout:-1 tag:cmdLogin];
    
}

-(void)sendReqDataWithObj:(id)objValue tag:(NSString *)type objecte:(id)obj call:(SEL)callback
{
    
    NSMutableDictionary *dictTemp = [NSMutableDictionary dictionary] ;
    dictTemp[NODE_ROOT_NAME] = [[objValue modelToJSONString] jsonValueDecoded];
    
    
    NSString *strXmlTemp =[dictTemp XMLString];
    CallObj *object = [[CallObj alloc] init];
    object.obj = obj;
    object.function = callback;
    [self.callDictionary setObject:object forKey:type];
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableData *sendData = [[NSMutableData alloc]init];
    [sendData appendData:[strXmlTemp dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%ld %ld  sendxml:  %@",(unsigned long)strXmlTemp.length,sendData.length,strXmlTemp);
    
    
    [self.gcdSocket writeData:sendData withTimeout:-1 tag:cmdLogin];
    
}


-(void)switchType:(NSData*)data
{
    
    NSDictionary *info = [NSDictionary dictionaryWithXMLData:data];//[[XMLDictionaryParser sharedInstance] dictionaryWithData:data];
    //NSDictionary *info = dicAll[NODE_ROOT_NAME];
    NSString *cmd = info[NODE_CMD_NAME];
    
    NSLog(@"rec  cmd:%@",cmd);
    if ([cmd isEqualToString:PTL_CMD_LOGIN]) {

        if ([info[NODE_RESULT_NAME] integerValue]==1) {
            [AppHelper toastMessage:@{@"message":@"登录成功"}];
//            NSLog(@"登录成功");
            self.loginInfo = info;
            //[[Websocket shareInit] openSocket];
            self.sessionID = info[NODE_SESSION_ID];
            
        }else {
            [AppHelper toastMessage:@{@"message":info[@"err"]}];
            if ([info[@"err"] containsString:@"该帐号在另外地点登录了"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginOutByAnother" object:self];
            }
            
            NSLog(@"登录失败 %@", info[NODE_ERR_NAME]);
            return;
        }
        
    }
    else if ([cmd isEqualToString:PTL_CMD_FETCH_MSG]){
        if ([info[@"chat"] isKindOfClass:[NSString class]]) {
            return;
        }
        NSArray *arr = info[@"chat"][@"item"];
        if ([arr isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tempDic = (NSDictionary*)arr;
            arr = @[tempDic];
        }
        for (NSDictionary *objj in arr) {
            MessageObject *msg = [[MessageObject alloc] init];
            msg.meetingId = objj[NODE_FROM];
            msg.keyfromTo = objj[NODE_FROM];
            msg.msg = objj[NODE_MSG];
            msg.fromID = objj[NODE_FROM];
            msg.toId = self.loginInfo[NODE_SESSION_ID];
            msg.time = objj[NODE_TIME];
            msg.userName = @"";//obj.userName;
            msg.msgType = @(1);
            msg.toUsername = self.loginInfo[NODE_USER_NAME];
            [[CoreDataTool shareData] insertModel:@[msg] KeyID:msg.keyfromTo];
           // [SaveDataUtil saveNoReadMessageId:[toid isEqualToString:@"0"]?@"0":objj.sessionID];
            //[[NSNotificationCenter defaultCenter] postNotificationName:PushMessage object:msg];
        }
       
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationFetchMsg object:info];
        return;
    }else if ([cmd isEqualToString:PTL_CMD_FetchGroupMsg]){
        if ([info[@"list"] isKindOfClass:[NSString class]]) {
            return;
        }
        NSArray *arr = info[@"list"][@"group"];
        if ([arr isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tempDic = (NSDictionary*)arr;
            arr = @[tempDic];
        }
        for (NSDictionary *objj in arr) {
            FetchGroupMsg *gmsg = [FetchGroupMsg modelWithDictionary:objj];
            MessageObject *msg = [[MessageObject alloc] init];
            msg.meetingId = @([gmsg.groupid integerValue]);
            msg.keyfromTo = gmsg.groupid;
            msg.msg = gmsg.msg;
            msg.fromID = gmsg.fromid;
            msg.toId = gmsg.groupid;
            msg.time = gmsg.time;
            msg.userName = @"";//obj.userName;
            msg.msgType = @(1);
            msg.toUsername = @"";
            [[CoreDataTool shareData] insertModel:@[msg] KeyID:msg.keyfromTo];
            // [SaveDataUtil saveNoReadMessageId:[toid isEqualToString:@"0"]?@"0":objj.sessionID];
            //[[NSNotificationCenter defaultCenter] postNotificationName:PushMessage object:msg];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationFetchGroupMsg object:info];
        return;
    }else if([cmd isEqualToString:PTL_CMD_ADD_FRIEND]){
        id rspObj = [AddFirend modelWithDictionary:info];
        CallObj *obj=[self.callDictionary objectForKey:cmd];
        if([obj.obj respondsToSelector:obj.function])
        {
            [obj.obj performSelector:obj.function withObject:rspObj];
        }
        return;
    }else if([cmd isEqualToString:PTL_CMD_Has_Bulletin]){
        FetchBulletinFriend *ff = [[FetchBulletinFriend alloc] init];
        ff.cmd = PTL_CMD_Fetch_Bulletin;
        ff.sessionID = [[SocketOprationData shareInit] sessionID];
        ff.fromID = 0;
        ff.type = PTL_REQ;
        ff.userID = ff.sessionID;
        [[SocketOprationData shareInit] sendReqDataWithObj:ff tag:PTL_CMD_Fetch_Bulletin objecte:nil call:nil];
        return;
    }else if([cmd isEqualToString:PTL_CMD_Fetch_Bulletin]){
        id rspObj = [FetchBulletinRsp modelWithDictionary:info];
        [[NSNotificationCenter defaultCenter] postNotificationName:PTL_CMD_Fetch_Bulletin object:rspObj];
        return;
    }else if([cmd isEqualToString:PTL_CMD_Accept_Friend]){
        id rspObj = [AddFirend modelWithDictionary:info];
        CallObj *obj=[self.callDictionary objectForKey:cmd];
        if([obj.obj respondsToSelector:obj.function])
        {
            [obj.obj performSelector:obj.function withObject:rspObj];
        }
        return;
    }else if([cmd isEqualToString:PTL_CMD_Reject_Friend]){
        id rspObj = [AddFirend modelWithDictionary:info];
        CallObj *obj=[self.callDictionary objectForKey:cmd];
        if([obj.obj respondsToSelector:obj.function])
        {
            [obj.obj performSelector:obj.function withObject:rspObj];
        }
        return;
    }/*else if([cmd isEqualToString:PTL_CMD_DEPART]){
        id rspObj = [DepartRspMode modelWithDictionary:info];
        CallObj *obj=[self.callDictionary objectForKey:cmd];
        if([obj.obj respondsToSelector:obj.function])
        {
            [obj.obj performSelector:obj.function withObject:rspObj];
        }
        return;
    }else if([cmd isEqualToString:PTL_CMD_RSP_MEETING_MEMBER]){
        id rspObj = [MeetingMember modelWithDictionary:info];
        CallObj *obj=[self.callDictionary objectForKey:PTL_CMD_FETCH_MEETING_MEMBER];
        if([obj.obj respondsToSelector:obj.function])
        {
            [obj.obj performSelector:obj.function withObject:rspObj];
        }
        return;
    }*/
    
    
    
    
    

    CallObj *obj=[self.callDictionary objectForKey:cmd];
    if([obj.obj respondsToSelector:obj.function])
    {
        [obj.obj performSelector:obj.function withObject:info];
    }
    
}

-(void)recevieData:(NSData *)data tag:(long)type
{

    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    //NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSString *result = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSArray *dataArr=[result componentsSeparatedByString:XmlDomainHead];
    
        for (int i=0; i<[dataArr count];i++ ) {
            
            NSString *strItem = dataArr[i];
            NSRange range;
            if (i == 0) {
                range = [strItem rangeOfString:XmlDomainEnd];
                if (range.location != NSNotFound) {
                    NSData *dataItem=[strItem dataUsingEncoding:NSUTF8StringEncoding];
                    [self.recevieData appendData:dataItem];
                    NSLog(@"无头有尾");
                    [self switchType:self.recevieData];
                }else{
                    
                    if ([dataArr count] == 1){
                        NSLog(@"无头无尾");
                        NSData *dataItem=[strItem dataUsingEncoding:NSUTF8StringEncoding];
                        [self.recevieData appendData:dataItem];
                        
                    }else{
                        NSLog(@"开头");
                    }
                }
                
                
            }else {
                strItem=[NSString stringWithFormat:@"%@%@",XmlDomainHead,dataArr[i]];
                NSData *dataItem=[strItem dataUsingEncoding:NSUTF8StringEncoding];
                range = [strItem rangeOfString:XmlDomainEnd];
                if (range.location!=NSNotFound) {
                    NSLog(@"有头有尾");
                    
                    [self switchType:dataItem];
                }
                else
                {
                    NSLog(@"有头无尾");
                    if (self.recevieData!=nil) {
                        self.recevieData = nil;
                    }
                    self.recevieData = [[NSMutableData alloc] init];
                    [self.recevieData appendData:dataItem];
                }
            }
            
        }
}

- (void)callBackLogin:(id)obj{
    self.loginInfo = obj;
    
}


@end


@interface FileSocket()<GCDAsyncSocketDelegate>
@property(nonatomic, strong)NSMutableData *recevieData;
@end
@implementation FileSocket
+(id)shareInit{
    static SocketOprationData *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}

- (void)initSocket{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSocket:) name:ConnectSocket object:nil];
    _gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    self.callDictionary = [NSMutableDictionary dictionary];
    
    [self connectSocket:nil];
}

-(void)connectSocket:(NSNotification*)noti
{
    
    NSError *err = nil;
    if ([_gcdSocket isDisconnected])
    {
        
        if ([UIApplication sharedApplication].keyWindow!=nil) {
            
        }
        if (![_gcdSocket connectToHost:HOSTFILE onPort:PORTFILE error:&err])
        {
            NSLog(@"I goofed: %@", err);
        }
    }
}

#pragma mark SocketDelegate
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
    NSLog(@"disconnect...");
    [self connectSocket:nil];
}
- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:ConnectionFinish object:nil];
    NSLog(@"connected!!!");
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [sock readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSLog(@"recTag:  %ld",tag);
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *result = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];//[[NSString alloc] initWithData:data  encoding:enc];
    
    if (result==nil||result==NULL||[result isEqualToString:@""]) {
        result=[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:enc];
    }
    if (result==nil||result==NULL||[result isEqualToString:@""]) {
        
        result=[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding];
    }
    NSMutableData *recData = [[NSMutableData alloc]init];
    [recData appendData:[result dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"recevieXml:count：%ld  %@",(unsigned long)[data length],result);
    
    [self recevieData:recData tag:tag];
    
    [sock readDataWithTimeout:-1 tag:tag];
}


#pragma mark ------

-(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSURL *url = [NSURL URLWithString:filePath];
    NSString *path = [url path];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;
}
-(void)sendReqDataWithValueDic:(NSMutableDictionary*)dicAll tag:(NSString *)type objecte:(id)obj call:(SEL)callback
{
    NSMutableDictionary *dictTemp = [NSMutableDictionary dictionary] ;
    if ([type isEqualToString:PTL_CMD_SEND_FILE] ) {
        NSString *url = dicAll[@"fileUrl"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        dicAll[@"fileName"] = [url lastPathComponent];
        dicAll[@"fileLength"] = @(data.length);//@([self fileSizeAtPath:dicAll[@"fileUrl"]]);
        dicAll[@"fileUrl"] = nil;
        dicAll[NODE_TYPE_NAME] = PTL_REQ;
        dicAll[NODE_CMD_NAME] = type;
        dicAll[NODE_SESSION_ID] = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];//[SystemManagement shareInstance].SessionId;
        dicAll[NODE_USERID] = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];
        dictTemp[NODE_ROOT_NAME] = dicAll;
       
        CallObj *object = [[CallObj alloc] init];
        object.obj = obj;
        object.function = callback;
        object.url = url;
        if ([dicAll[@"fileType"] isEqualToString:MessageTypeVoice]) {
            object.timeLong = [dicAll[@"timeLong"] intValue];
        }
        
        [self.callDictionary setObject:object forKey:dicAll[@"fileName"]];
    }else if ([type isEqualToString:PTL_CMD_RECV_FILE]){
//        dicAll[@"fileType"] = @"data";
//        
//        dicAll[NODE_TYPE_NAME] = PTL_REQ;
//        dicAll[NODE_CMD_NAME] = type;
//        dicAll[NODE_SESSION_ID] = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];//[SystemManagement shareInstance].SessionId;
//        dicAll[NODE_USERID] = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];
//        dictTemp[NODE_ROOT_NAME] = dicAll;
//        
//        CallObj *object = [[CallObj alloc] init];
//        object.obj = obj;
//        object.function = callback;
//        [self.callDictionary setObject:object forKey:dicAll[@"fileName"]];
    }
    
    NSString *strXmlTemp =[dictTemp XMLString];
    
    
    
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    strXmlTemp = [strXmlTemp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSMutableData *sendData = [[NSMutableData alloc]init];
    [sendData appendData:[strXmlTemp dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%ld %ld  sendxml:  %@",(unsigned long)strXmlTemp.length,(unsigned long)sendData.length,strXmlTemp);
    [self.gcdSocket writeData:sendData withTimeout:-1 tag:cmdLogin];
    
}


-(void)switchType:(NSData*)data
{
    NSDictionary *info = [[XMLDictionaryParser sharedInstance] dictionaryWithData:data];
    //NSDictionary *info = dicAll[NODE_ROOT_NAME];
    NSString *cmd = info[NODE_CMD_NAME];
    
    NSLog(@"rec  cmd:%@",cmd);
    if ([cmd isEqualToString:PTL_CMD_SEND_FILE]) {
        
        if ([info[NODE_RESULT_NAME] integerValue]==1) {
            CallObj *obj=[self.callDictionary objectForKey:info[@"fileName"]];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:obj.url]];
            [self.gcdSocket writeData:data withTimeout:-1 tag:cmdLogin];
                        
        }else {
            CallObj *obj=[self.callDictionary objectForKey:info[@"fileName"]];
            //if([obj.obj respondsToSelector:obj.function])
            {
                NSString *string = @"";
                if ([info[@"fileType"] isEqualToString:MessageTypeVoice]) {
                    string = [NSString stringWithFormat:@"|timelong:%d",obj.timeLong];
                }
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"msg"] = [NSString stringWithFormat:@"[{url:%@|filetype:%@%@}]", info[@"result"],info[@"fileType"],string];
                dic[@"toID"] = info[@"toID"];
                dic[@"toUserName"]= @"";
                [[SocketOprationData shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_SEND_MSG objecte:obj.obj call:obj.function];
                //[obj.obj performSelector:obj.function withObject:info];
            }
           
            return;
        }
        
    }else if([cmd isEqualToString:PTL_CMD_RECV_FILE]){
        if ([info[NODE_RESULT_NAME] integerValue]==1) {
        
            NSMutableDictionary  *dic = [NSMutableDictionary dictionaryWithDictionary:info];
            dic[NODE_RESULT_NAME] = nil;
            dic[@"action"] = @"ready";
            [self sendReqDataWithValueDic:dic tag:PTL_CMD_RECV_FILE objecte:nil call:nil];
            return;
        }
    }
    else if ([cmd isEqualToString:PTL_CMD_FETCH_MSG]){
        if ([info[@"chat"] isKindOfClass:[NSString class]]) {
            return;
        }
        NSArray *arr = info[@"chat"][@"item"];
        if ([arr isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tempDic = (NSDictionary*)arr;
            arr = @[tempDic];
        }
        for (NSDictionary *objj in arr) {
            MessageObject *msg = [[MessageObject alloc] init];
            msg.meetingId = objj[NODE_FROM];
            msg.keyfromTo = objj[NODE_FROM];
            msg.msg = objj[NODE_MSG];
            msg.fromID = objj[NODE_FROM];
            msg.toId = self.loginInfo[NODE_SESSION_ID];
            msg.time = objj[NODE_TIME];
            msg.userName = @"";//obj.userName;
            msg.msgType = @(1);
            msg.toUsername = self.loginInfo[NODE_USER_NAME];
            [[CoreDataTool shareData] insertModel:@[msg] KeyID:msg.keyfromTo];
            // [SaveDataUtil saveNoReadMessageId:[toid isEqualToString:@"0"]?@"0":objj.sessionID];
            //[[NSNotificationCenter defaultCenter] postNotificationName:PushMessage object:msg];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationFetchMsg object:info];
        return;
    }
    
    CallObj *obj=[self.callDictionary objectForKey:cmd];
    if([obj.obj respondsToSelector:obj.function])
    {
        [obj.obj performSelector:obj.function withObject:info];
    }
    
}

-(void)recevieData:(NSData *)data tag:(long)type
{
    
    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    //NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSString *result = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    
    NSArray *dataArr=[result componentsSeparatedByString:XmlDomainHead];
    
    for (int i=0; i<[dataArr count];i++ ) {
        
        NSString *strItem = dataArr[i];
        NSRange range;
        if (i == 0) {
            range = [strItem rangeOfString:XmlDomainEnd];
            if (range.location != NSNotFound) {
                NSData *dataItem=[strItem dataUsingEncoding:NSUTF8StringEncoding];
                [self.recevieData appendData:dataItem];
                NSLog(@"无头有尾");
                [self switchType:self.recevieData];
            }else{
                
                if ([dataArr count] == 1){
                    NSLog(@"无头无尾");
                    NSData *dataItem=[strItem dataUsingEncoding:NSUTF8StringEncoding];
                    [self.recevieData appendData:dataItem];
                    
                }else{
                    NSLog(@"开头");
                }
            }
            
            
        }else {
            strItem=[NSString stringWithFormat:@"%@%@",XmlDomainHead,dataArr[i]];
            NSData *dataItem=[strItem dataUsingEncoding:NSUTF8StringEncoding];
            range = [strItem rangeOfString:XmlDomainEnd];
            if (range.location!=NSNotFound) {
                NSLog(@"有头有尾");
                
                [self switchType:dataItem];
            }
            else
            {
                NSLog(@"有头无尾");
                if (self.recevieData!=nil) {
                    self.recevieData = nil;
                }
                self.recevieData = [[NSMutableData alloc] init];
                [self.recevieData appendData:dataItem];
            }
        }
        
    }
}

- (void)callBackLogin:(id)obj{
    
    self.loginInfo = obj;
    
}
- (void)closeSocket{
    
}

@end
