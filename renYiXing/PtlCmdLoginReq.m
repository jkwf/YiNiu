//
//  PtlCmdLogin.m
//  JoyIM
//
//  Created by Eben on 2/21/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#import "PtlCmdLoginReq.h"
#import "DDXMLDocument.h"




@implementation PtlCmdLoginReq

@synthesize UserName;
@synthesize Password;
@synthesize loginType;

-(id)init
{
    self = [super init];
    
    _ptlPair = req;
    _cmdType = cmdLogin;
    
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
    
    DDXMLElement* loginTypeNode = [[DDXMLElement alloc] initWithName:NODE_LOGINTYPE stringValue:@"1"];
    
    DDXMLElement* sessionIdNode = [[DDXMLElement alloc] initWithName:NODE_SESSION_ID stringValue:self.SessionId];
    
    [_rootNode addChild:cmdNode];
    [_rootNode addChild:sessionIdNode];
    
    
    DDXMLElement* userNameNode = [[DDXMLElement alloc] initWithName:NODE_USER_NAME_LITTLE stringValue:self.UserName];
    
    DDXMLElement* pwdNode = [[DDXMLElement alloc] initWithName:NODE_PASSWORD stringValue:self.Password];
    
    DDXMLElement* domainNode = [[DDXMLElement alloc] initWithName:NODE_DOMAIN stringValue:self.Domain];
    
    
    
    [_rootNode addChild:userNameNode];
    [_rootNode addChild:domainNode];
    [_rootNode addChild:pwdNode];
    [_rootNode addChild:loginTypeNode];
    
    return [_rootNode XMLString];
}

@end
