//
//  Ptl.h
//  JoyIM
//
//  Created by Eben on 2/21/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPtlCoder.h"
#import "DDXMLDocument.h"
#import "Comm.h"


@interface Ptl : NSObject<IPtlCoder>
{
    
@protected
    PTLPair _ptlPair;
    PTLCmdType _cmdType;
    DDXMLElement* _rootNode;
    DDXMLDocument* _xmlDoc;
}

@property(copy,nonatomic)NSString* SessionId;

+(NSString*)PTLPairToString:(PTLPair)pair;
+(PTLPair)PTLPairFromString:(NSString*)sValue;

+(NSString*)PTLCmdTypeToString:(PTLCmdType)cmdType;
+(PTLCmdType)PTLCmdTypeFromString:(NSString*)sValue;

+(NSString*)PTLUserStatusToString:(UserStatus)status;
+(UserStatus)PTLUserStatusFromeString:(NSString*)sValue;


@end
