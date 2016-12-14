//
//  Message.h
//  JoyIM
//
//  Created by Longxun on 16/9/3.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Message+CoreDataProperties.h"
typedef NS_ENUM(NSInteger, MSGTYPE){
    MSGTYPE_All,
    MSGTYPE_Person,
};
@interface MessageObject :NSObject

@property (nullable, nonatomic, retain) NSNumber *meetingId;
@property (nullable, nonatomic, retain) NSString *fromID;
@property (nullable, nonatomic, retain) NSString *time;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *toId;
@property (nullable, nonatomic, retain) NSString *msg;
@property (nullable, nonatomic, retain) NSString *toUsername;
@property (nullable, nonatomic, retain) NSNumber *msgType;
@property (nullable, nonatomic, retain) NSString *keyfromTo;

@end