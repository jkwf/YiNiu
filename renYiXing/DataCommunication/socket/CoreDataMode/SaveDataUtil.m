//
//  SaveDataUtil.m
//  JSDVideoConference
//
//  Created by Longxun on 16/3/7.
//  Copyright © 2016年 Xunchi. All rights reserved.
//

#define NoReadMessage [NSString stringWithFormat:@"NoReadMessage%lld", [[SocketOprationData shareInit] meetingID]]
#import "SaveDataUtil.h"
#import "Comm.h"
@implementation SaveDataUtil
+(void)writeDeviceID:(NSString *)string{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"DeviceID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)readDeviceID{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceID"];
    //return @"40-B8-9A-17-97-85";
    return @"B0-83-FE-4C-79-5F";
    return @"B0-83-FE-4C-79-5E";
    return @"B0-83-FE-4C-87-2A";
    return string;
    
    // @"40-B8-9A-17-97-85";//@"B0-83-FE-4C-87-2A";// @"40-B8-9A-17-97-85";//@"2016011611395334";//
}
+ (NSDictionary *)readNoReadMessage{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:NoReadMessage];

}
+ (NSInteger)hasNoReadMessageWithUserid:(NSString *)userid withDictionary:(NSDictionary *)dic{

    if (dic[userid]) {
        return [dic[userid] integerValue];
    }
    return 0;
}
+ (void)saveNoReadMessageId:(NSString *)userid{
    if (userid == nil) {
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[SaveDataUtil readNoReadMessage]];
    if (dic) {
        NSNumber *num = dic[userid];
        if (num) {
            dic[userid] = @([num integerValue]+1);
        }else{
            dic[userid] = @(1);
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:NoReadMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)deleteNoReadMessageId:(NSString *)userid{
 
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[SaveDataUtil readNoReadMessage]];
    if (dic[userid]) {
        [dic removeObjectForKey:userid];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:NoReadMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getNowTimeStamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}
+(NSString*)getNowTime{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-M-dhh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}
//把服务器拿到的时间转换为完整时间字符串
+ (NSString *)createAllTime:(NSString *)cTime
{
    if (cTime == 0) {
        return @"--";
    }
    NSString *resultTime = [NSString string];
    //NSDate *now = [NSDate date];
    
    NSDate *lastTime = [NSDate dateWithTimeIntervalSince1970:[cTime longLongValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit
    | NSMonthCalendarUnit
    | NSDayCalendarUnit
    | NSHourCalendarUnit
    | NSMinuteCalendarUnit
    | NSSecondCalendarUnit
    | NSWeekdayCalendarUnit;
    
    NSDateComponents *lastComps = [gregorian components:unitFlags fromDate:lastTime];
    NSInteger cYear = [lastComps year];
    NSInteger cMonth = [lastComps month];
    NSInteger cDay = [lastComps day];
    NSInteger cHour = [lastComps hour];
    NSInteger cMinute = [lastComps minute];
    
    
    {
        resultTime = [NSString stringWithFormat:@"%ld/%02ld/%02ld %02ld:%02ld",cYear, cMonth, cDay, cHour, cMinute];
    }
    return resultTime;
}
+ (NSString *) hexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    NSMutableString *string = [NSMutableString stringWithFormat:@"#"];
    int r =(int)((CGColorGetComponents(color.CGColor))[0]*255.0),
    g = (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
    b = (int)((CGColorGetComponents(color.CGColor))[2]*255.0);
    if (r<16) {
        [string appendFormat:@"0%X",r];
    }else
    {
        [string appendFormat:@"%X",r];
    }
    if (g<16) {
        [string appendFormat:@"0%X",g];
    }else
    {
        [string appendFormat:@"%X",g];
    }
    if (b<16) {
        [string appendFormat:@"0%X",b];
    }else
    {
        [string appendFormat:@"%X",b];
    }
    return string;
}

+ (UIColor*) colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue
{
    return nil;
    NSInteger   red = strtoul([[hexValue substringWithRange:NSMakeRange(1, 2)] UTF8String],0,16);
    NSInteger   green = strtoul([[hexValue substringWithRange:NSMakeRange(3, 2)] UTF8String],0,16);
    NSInteger  blue = strtoul([[hexValue substringWithRange:NSMakeRange(5, 2)] UTF8String],0,16);
    //return RGB(red, green, blue, alphaValue);
//    //return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
//                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
//                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}


@end



#define MessageMode @"Message"
#define MessageClass @"MessageObject"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
@implementation CoreDataTool

+(id)shareData{
    
    static CoreDataTool *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    
    });
    return sharedInstance;
}
- (void)initCoredata{
    // 从应用程序包中加载模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model] ;
    // 构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"jyd.data"]];
    // 添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    // 初始化上下文，设置persistentStoreCoordinator属性
    self.context = [[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator = psc;
    // 用完之后，记得要[context release];
}


- (void)insertModel:(NSArray *)modeArray KeyID:(NSString *)key{
    
    for (NSDictionary *dic in modeArray) {
        Message *msg = [NSEntityDescription insertNewObjectForEntityForName:MessageMode inManagedObjectContext:self.context];
        if ([dic isKindOfClass:[MessageObject class]]) {
            MessageObject *obj = (MessageObject *)dic;
            msg.meetingId = @([obj.meetingId longLongValue]);
            msg.keyfromTo = obj.keyfromTo;
            msg.msg = obj.msg;
            msg.fromID = obj.fromID;
            msg.toId = obj.toId;
            msg.time = [SaveDataUtil getNowTimeStamp];
            msg.userName = obj.userName;
            msg.msgType = obj.msgType;
            msg.toUsername = obj.toUsername;

        }else {
            long long l = [[SocketOprationData shareInit] meetingID];
            msg.meetingId = [NSNumber numberWithLongLong:l];
            msg.keyfromTo = key;
            msg.msg = dic[@"msg"];
            msg.fromID = dic[@"fromID"]?dic[@"fromID"]:dic[@"fromid"];
            msg.toId = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];
            msg.time = dic[@"time"];
            msg.userName = dic[@"userName"];
            msg.msgType = @(1);
            msg.toUsername = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];
            [SaveDataUtil saveNoReadMessageId:msg.fromID];
            

        }
        
        NSError *error = nil;
        
        BOOL success = [self.context save:&error];
        if (!success) {
            [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
        }
        //msg = nil;
    }
    
    

}
- (NSArray *)queryMsgWithKey:(NSString *)key meetingID:(long long)meetingId countNum:(NSInteger)count{
    // 初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 设置要查询的实体
    request.entity = [NSEntityDescription entityForName:MessageMode inManagedObjectContext:self.context];
    
    // 设置排序（按照age降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤(搜索name中包含字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"keyfromTo = %@ ", key];//*2*  meetingId = %lld AND fromID = %@ AND toId = %@
    request.predicate = predicate;

//    request.fetchLimit = 5;
//    request.fetchOffset = 0;
    NSError *error = nil;
    // 执行请求
    NSArray *objs = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    if ([objs count] == 0) {
        return nil;
    }
    
    const char *charClass = [MessageClass UTF8String];
    id object = objc_getClass(charClass);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(object, &outCount);
    
    NSMutableArray *classVariables=[[NSMutableArray alloc] init];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        [classVariables addObject:propName];
    }
    free(properties);
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (NSInteger i = [objs count]-1; i>=0; i--) {

        NSManagedObject *obj = objs[i];
        id objectt = [[NSClassFromString (MessageClass)alloc] init];
        for (NSString *variable in classVariables) {
            [objectt setValue:[obj valueForKey:variable] forKey:variable];
        }
        //[self.context deleteObject:obj];
        //[self.context save:&error];
        [retArray addObject:objectt];
    }
    return retArray;
}
@end
@implementation UIView (Additions)
-(UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
}
@end
