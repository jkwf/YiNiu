//
//  Message+CoreDataProperties.h
//  JoyIM
//
//  Created by Longxun on 16/9/3.
//  Copyright © 2016年 Eben. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *fromID;
@property (nullable, nonatomic, retain) NSString *keyfromTo;
@property (nullable, nonatomic, retain) NSNumber *meetingId;
@property (nullable, nonatomic, retain) NSString *msg;
@property (nullable, nonatomic, retain) NSNumber *msgType;
@property (nullable, nonatomic, retain) NSString *time;
@property (nullable, nonatomic, retain) NSString *toId;
@property (nullable, nonatomic, retain) NSString *toUsername;
@property (nullable, nonatomic, retain) NSString *userName;

@end

NS_ASSUME_NONNULL_END
