//
//  DealPictureMode.m
//  DaiGouApp
//
//  Created by Longxun on 16/8/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import "DealPictureMode.h"
#import "AFURLSessionManager.h"
@implementation DealPictureMode
+ (instancetype)shareInstance {
    static DealPictureMode *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[DealPictureMode alloc] init];
    });
    return _shareInstance;
}
- (id)init{
    self = [super init];
    if (self) {
        self.dataList = [NSMutableArray array];
        self.dicList = [NSMutableArray array];
       
    }
    return self;
}


- (void)sessionDownloadWithURL:(NSString *)urlString filename:(NSString *)filename downSuccess:(DownloadSuccess)success downError:(DownloadFail)fail
{
    if ([self isExistWithPath:VoicePath(filename)]) {
        return;
    }
   
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    //NSString *urlString = @"http://localhost/itcast/videos/01.C语言-语法预览.mp4";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
        //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        NSString *path = VoicePath(filename);
        //NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        //NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        NSLog(@"== %@ |||| %@", fileURL1, fileURL);
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
        if (error) {
            if (fail) {
                fail(error);
            }
        }else{
            if (success) {
                success([NSString stringWithFormat:@"%@",filePath]);
            }
        }
    }];
    
    [task resume];
    
}

- (NSString *)getResourcePath:(NSString *)directory file:(NSString *)filename{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:directory];
    
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    
    path = [path stringByAppendingPathComponent:filename];
    return path;
}
- (BOOL)isExistWithPath:(NSString *)path{
    BOOL bo = [[NSFileManager defaultManager] fileExistsAtPath:path];
    return bo;
}
@end
