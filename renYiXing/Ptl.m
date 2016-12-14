//
//  Ptl.m
//  JoyIM
//
//  Created by Eben on 2/21/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#import "Ptl.h"

@implementation Ptl

@synthesize SessionId;

-(id)init
{
    self = [super init];
    
    return self;
}

-(Ptl*)Decoder:(NSString*)sXml
{
    NSError* err = nil;
    
    _xmlDoc = [[DDXMLDocument alloc] initWithXMLString:sXml options:0 error:&err];
    
    //SessionId
    NSString* sPath = [NSString stringWithFormat:@"//%@",NODE_SESSION_ID];
    NSArray* nodes = [_xmlDoc nodesForXPath:sPath error:&err];
    if(nil != nodes && nodes.count == 1)
        self.SessionId = [((DDXMLElement*)[nodes objectAtIndex:0]) stringValue];
    
    return nil;
}

-(NSString*)Encoder:(Ptl*)ptl
{
    _rootNode = [[DDXMLElement alloc] initWithName:NODE_ROOT_NAME];
    
    DDXMLElement* typeNode = [[DDXMLElement alloc] initWithName:NODE_TYPE_NAME stringValue:[Ptl PTLPairToString:_ptlPair]];
    
    [_rootNode addChild:typeNode];
    
    DDXMLElement* cmdNode = [[DDXMLElement alloc] initWithName:NODE_CMD_NAME stringValue:[Ptl PTLCmdTypeToString:_cmdType]];
    
    DDXMLElement* sessionIdNode = [[DDXMLElement alloc] initWithName:NODE_SESSION_ID stringValue:self.SessionId];
    
    [_rootNode addChild:cmdNode];
    [_rootNode addChild:sessionIdNode];
    
    return nil;
}

+(NSString*)PTLPairToString:(PTLPair)pair
{
    if(rsp == pair)
        return PTL_RSP;
    else if(req == pair)
        return PTL_REQ;
    
    return @"";
}

+(PTLPair)PTLPairFromString:(NSString *)sValue
{
    if([sValue compare:PTL_REQ] == NSOrderedSame)
        return req;
    else if([sValue compare:PTL_RSP] == NSOrderedSame)
        return rsp;
    assert(false);
    
    return 0;
}

+(NSString*)PTLCmdTypeToString:(PTLCmdType)cmdType
{
    if(cmdLogin == cmdType)
        return PTL_CMD_LOGIN;
    else if(cmdregister == cmdType)
        return PTL_CMD_REGISTER;
    else if(cmdmodifyPsw == cmdType)
        return PTL_CMD_MODIFY_PWD;
    else if(cmdUserStatus == cmdType)
        return PTL_CMD_USER_STATUS;
    else if(cmdPushStatus == cmdType)
        return PTL_CMD_PUSH_STATUS;
    else if(cmdBackupFriend == cmdType)
        return PTL_CMD_BACKUP_FRIEND;
    else if(cmdRestoreFriend == cmdType)
        return PTL_CMD_RESTORE_FRIEND;
    else if(cmdSendFileFinished == cmdType)
        return PTL_CMD_SEND_FILE_FINISHED;
    else if(cmdDepart == cmdType)
        return PTL_CMD_DEPART;
    else if(cmdDepartMember == cmdType)
        return PTL_CMD_DEPART_MEMBER;
    else if(cmdGroup == cmdType)
        return PTL_CMD_GROUP;
    else if(cmdGroupMember == cmdType)
        return PTL_CMD_GROUP_MEMBER;
    else if(cmdGroupLeaveWord == cmdType)
        return PTL_CMD_GROUP_OFFLINE_MSG;
    else if(cmdFriendList == cmdType)
        return PTL_CMD_FRIEND_LIST;
    else if(cmdCheckUserOnline == cmdType)
        return PTL_CMD_CHECK_USER_ONLINE;
    else if(cmdFetchMsg == cmdType)
        return PTL_CMD_FETCH_MSG;
    else if(cmdSendMsg == cmdType)
        return PTL_CMD_SEND_MSG;
    
    return @"";
}



+(PTLCmdType)PTLCmdTypeFromString:(NSString*)sValue
{
    if([sValue compare:PTL_CMD_LOGIN] == NSOrderedSame)
        return cmdLogin;
    else if([sValue compare:PTL_CMD_MODIFY_PWD] == NSOrderedSame)
        return cmdmodifyPsw;
    else if([sValue compare:PTL_CMD_USER_STATUS] == NSOrderedSame)
        return cmdUserStatus;
    else if([sValue compare:PTL_CMD_PUSH_STATUS] == NSOrderedSame)
        return cmdPushStatus;
    else if([sValue compare:PTL_CMD_BACKUP_FRIEND] == NSOrderedSame)
        return cmdBackupFriend;
    else if([sValue compare:PTL_CMD_RESTORE_FRIEND] == NSOrderedSame)
        return cmdRestoreFriend;
    else if([sValue compare:PTL_CMD_SEND_FILE_FINISHED] == NSOrderedSame)
        return cmdSendFileFinished;
    else if([sValue compare:PTL_CMD_DEPART] == NSOrderedSame)
        return cmdDepart;
    else if([sValue compare:PTL_CMD_DEPART_MEMBER] == NSOrderedSame)
        return cmdDepartMember;
    else if([sValue compare:PTL_CMD_GROUP] == NSOrderedSame)
        return cmdGroup;
    else if([sValue compare:PTL_CMD_GROUP_MEMBER] == NSOrderedSame)
        return cmdGroupMember;
    else if([sValue compare:PTL_CMD_GROUP_OFFLINE_MSG] == NSOrderedSame)
        return cmdGroupLeaveWord;
    else if([sValue compare:PTL_CMD_FRIEND_LIST] == NSOrderedSame)
        return cmdFriendList;
    else if([sValue compare:PTL_CMD_CHECK_USER_ONLINE] == NSOrderedSame)
        return cmdCheckUserOnline;
    else if([sValue compare:PTL_CMD_FETCH_MSG] == NSOrderedSame)
        return cmdFetchMsg;
    else if([sValue compare:PTL_CMD_SEND_MSG] == NSOrderedSame)
        return cmdSendMsg;
    
    return 0;
}

+(NSString*)PTLUserStatusToString:(UserStatus)status
{
    if(online == status)
        return @"1";
    else if(offline == status)
        return @"0";
    
    return @"";
}


+(UserStatus)PTLUserStatusFromeString:(NSString*)sValue
{
    if([sValue compare:@"1"] == NSOrderedSame)
        return online;
    else if([sValue compare:@"0"] == NSOrderedSame)
        return offline;
    
    return 0;
}

@end
