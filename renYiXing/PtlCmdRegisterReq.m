//
//  PtlCmdRegisterReq.m
//  SocketDemo
//
//  Created by JOYSW on 16/8/5.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "PtlCmdRegisterReq.h"

@implementation PtlCmdRegisterReq

@synthesize UserName;
@synthesize Mobile;
@synthesize Telephone;
@synthesize Password;
//@synthesize loginType;

-(id)init
{
    self = [super init];
    
    _ptlPair = req;
    _cmdType = cmdregister;
    
    return self;
}

-(Ptl*)Decoder:(NSString*)sXml
{
    return nil;
}

-(NSString*)Encoder:(Ptl*)ptl
{
    _rootNode = [[DDXMLElement alloc] initWithName:NODE_ROOT_NAME];
    
    DDXMLElement* typeNode = [[DDXMLElement alloc] initWithName:NODE_TYPE_NAME stringValue:[Ptl PTLPairToString:_ptlPair]];
    
    [_rootNode addChild:typeNode];
    
    DDXMLElement* cmdNode = [[DDXMLElement alloc] initWithName:NODE_CMD_NAME stringValue:[Ptl PTLCmdTypeToString:_cmdType]];
    
//    DDXMLElement* loginTypeNode = [[DDXMLElement alloc] initWithName:NODE_LOGINTYPE stringValue:@"1"];
    
    DDXMLElement* sessionIdNode = [[DDXMLElement alloc] initWithName:NODE_SESSION_ID stringValue:self.SessionId];
    
    [_rootNode addChild:cmdNode];
    [_rootNode addChild:sessionIdNode];
    
    DDXMLElement* userInfoNode = [[DDXMLElement alloc] initWithName:NODE_USERINFO];
    DDXMLElement* userNameNode = [[DDXMLElement alloc] initWithName:NODE_USER_NAME stringValue:self.UserName];
    
    DDXMLElement* mobileNode = [[DDXMLElement alloc] initWithName:NODE_MOBILE stringValue:self.Mobile];
    
    DDXMLElement* teleNode = [[DDXMLElement alloc] initWithName:NODE_TELEPHONE stringValue:self.Telephone];
    
    DDXMLElement* pwdNode = [[DDXMLElement alloc] initWithName:NODE_PASSWORD stringValue:self.Password];
    
//    DDXMLElement* domainNode = [[DDXMLElement alloc] initWithName:NODE_DOMAIN stringValue:self.Domain];
    
    
    [_rootNode addChild:userInfoNode];
    [userInfoNode addChild:userNameNode];
    [userInfoNode addChild:mobileNode];
    [userInfoNode addChild:teleNode];
//    [_rootNode addChild:domainNode];
    [userInfoNode addChild:pwdNode];
//    [_rootNode addChild:loginTypeNode];
    
    return [_rootNode XMLString];
}

@end
