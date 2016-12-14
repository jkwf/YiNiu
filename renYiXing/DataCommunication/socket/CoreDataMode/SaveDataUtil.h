//
//  SaveDataUtil.h
//  JSDVideoConference
//
//  Created by Longxun on 16/3/7.
//  Copyright © 2016年 Xunchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NoReadMessage @"NoReadMessage"

@interface SaveDataUtil : NSObject

+(void)writeDeviceID:(NSString *)string;
+(NSString *)readDeviceID;
+ (NSString *)createAllTime:(NSString *)cTime;
+ (NSDictionary *)readNoReadMessage;
+ (NSInteger)hasNoReadMessageWithUserid:(NSString *)userid withDictionary:(NSDictionary *)array;
+ (void)saveNoReadMessageId:(NSString *)userid;
+ (void)deleteNoReadMessageId:(NSString *)userid;
+ (NSString*)getNowTime;
+ (NSString *) hexFromUIColor: (UIColor*) color;
+ (UIColor*) colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue;
+ (NSString *)getNowTimeStamp;
@end

#import "Message.h"
@interface CoreDataTool : NSObject
@property(nonatomic, strong)NSManagedObjectContext *context;
+(id)shareData;
- (void)initCoredata;
- (void)insertModel:(NSArray *)modeArray KeyID:(NSString *)key;
- (NSArray *)queryMsgWithKey:(NSString *)key meetingID:(long long)meetingId countNum:(NSInteger)count;
@end
@interface UIView (Additions)
-(UIViewController *)viewController;
@end
