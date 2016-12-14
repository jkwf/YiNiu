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
    NSLog(@"connected!!!");
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [_gcdSocket readDataWithTimeout:-1 tag:tag];
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
    NSLog(@"recevieXml:count：%ld  %@",[data length],result);
    
    [self recevieData:recData tag:tag];

    [_gcdSocket readDataWithTimeout:-1 tag:tag];
}
#pragma mark ------
-(void)sendReqDataWithValueDic:(NSMutableDictionary*)dicAll tag:(NSString *)type objecte:(id)obj call:(SEL)callback
{
    
    NSMutableDictionary *dictTemp = [NSMutableDictionary dictionary] ;
    dicAll[NODE_TYPE_NAME] = PTL_REQ;
    dicAll[NODE_CMD_NAME] = type;
    dictTemp[NODE_ROOT_NAME] = dicAll;
    
    NSString *strXmlTemp =[dictTemp XMLString];
    CallObj *object = [[CallObj alloc] init];
    object.obj = obj;
    object.function = callback;
    [self.callDictionary setObject:object forKey:type];
    
    [strXmlTemp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [strXmlTemp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSMutableData *sendData = [[NSMutableData alloc]init];
    [sendData appendData:[strXmlTemp dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%ld %ld  sendxml:  %@",strXmlTemp.length,sendData.length,strXmlTemp);
    [self.gcdSocket writeData:sendData withTimeout:-1 tag:cmdLogin];
    
}


-(void)switchType:(NSData*)data
{
    NSDictionary *info = [[XMLDictionaryParser sharedInstance] dictionaryWithData:data];
    //NSDictionary *info = dicAll[NODE_ROOT_NAME];
    NSString *cmd = info[NODE_CMD_NAME];
    
    NSLog(@"rec  cmd:%@",cmd);
    if ([cmd isEqualToString:PTL_CMD_LOGIN]) {

        if ([info[NODE_RESULT_NAME] integerValue]==1) {
            NSLog(@"登录成功");
            self.loginInfo = info;
        }else {
            NSLog(@"登录失败 %@", info[NODE_ERR_NAME]);
            return;
        }
        
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

@end
