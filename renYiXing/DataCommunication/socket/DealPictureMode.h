//
//  DealPictureMode.h
//  DaiGouApp
//
//  Created by Longxun on 16/8/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PushUIUploadImage @"PushUIUploadImage"
#define PushMsgDataUploadFinish @"PushMsgDataUploadFinish"

typedef void(^DownloadSuccess) (NSString *path);
typedef void(^DownloadFail) (NSError *error);
@interface DealPictureMode : NSObject
@property (strong, nonatomic)NSMutableArray *dataList;
@property (strong, nonatomic)NSMutableArray *dicList;
+ (id)shareInstance;

- (void)sessionDownloadWithURL:(NSString *)urlString filename:(NSString *)filename downSuccess:(DownloadSuccess)success downError:(DownloadFail)fail;
- (NSString *)getResourcePath:(NSString *)directory file:(NSString *)filename;
- (BOOL)isExistWithPath:(NSString *)path;
@end
