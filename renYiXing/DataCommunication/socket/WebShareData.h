//
//  WebShareData.h
//  JSDVideoConference
//
//  Created by Longxun on 16/3/8.
//  Copyright © 2016年 Xunchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BASEURL @"http://120.27.157.147/Web/easytrader.joysw.cn/yn_contact/index.php?"

#define CIRCLEURL @"http://120.27.157.147/Web/easytrader.joysw.cn/yn_friend/index.php?"

typedef void(^WebRequestDataSuccess)( NSDictionary *  dicInfo);
typedef void(^WebRequestDataFail)(NSError *  error);
@interface WebShareData : NSObject
+ (void)getDataFromWebWithParams:(NSDictionary *)params urlString:(NSString *)string successBlock:(WebRequestDataSuccess)blockSuccess failBlock:(WebRequestDataFail)blockFail;
+ (void)getDataFromWebWithParams:(NSDictionary *)params contentType:(NSString *)contenttype urlString:(NSString *)string successBlock:(WebRequestDataSuccess)blockSuccess failBlock:(WebRequestDataFail)blockFail;

+ (void)getDataFromWebHaveCookieWithParams:(NSDictionary *)params urlString:(NSString *)string successBlock:(WebRequestDataSuccess)blockSuccess failBlock:(WebRequestDataFail)blockFail;


/**
 上传用户头像接口——params:接口参数、URLString：URL地址、successBlock:上传成功的回调Block、failBlock:上传失败的回调Block

 @param params       接口参数
 @param URLString    URL地址
 @param successBlock 上传成功的回调Block
 @param failBlock    上传失败的回调
 */
+(void)uploadUserHeaderImageWithParams:( NSDictionary * )params withURLString:(  NSString *  )URLString withImageURL:(NSURL*)ImageURL withSuccessBlock:( WebRequestDataSuccess )successBlock withFailBlock:( WebRequestDataFail)failBlock;

/**
 上传图片
 
 @param img 图片对象
 @param imgName 提交的图片参数
 @param fileName 文件名
 @param params 提交参数
 @param urlStr 提交地址
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)uploadImg:(UIImage *)img withImgName:(NSString *)imgName withFileName:(NSString *)fileName withParams:(NSDictionary *)params withUrlStr:(NSString *)urlStr withSuccessBlock:( WebRequestDataSuccess )successBlock withFailBlock:( WebRequestDataFail)failBlock;

/**
 发布段子接口——params:上传所需参数、mutableArray:上传的图片数组,可以为空、urlStr：url地址 、successBlock：上传成功的信息回调、failBlock：上传失败的信息回调

 @param params 上传所需参数，不能为空
 @param mutableArray 上传的图片数组,可以为空
 @param urlStr url地址,不能为空
 @param successBlock 上传成功的信息回调
 @param failBlock 上传失败的信息回调
 */
+(void)uploadImageWithParams:( NSDictionary * _Nonnull )params withImageArray:( NSMutableArray  * _Nullable )mutableArray withUrlStr:(NSString * _Nonnull)urlStr withSuccessBlock:(_Nonnull WebRequestDataSuccess)successBlock withFailBlock:(_Nullable WebRequestDataFail)failBlock;


@end
