//
//  WebShareData.m
//  JSDVideoConference
//
//  Created by Longxun on 16/3/8.
//  Copyright © 2016年 Xunchi. All rights reserved.
//

#import "WebShareData.h"

@implementation WebShareData
+ (void)getDataFromWebWithParams:(NSDictionary *)params urlString:(NSString *)string successBlock:(WebRequestDataSuccess)blockSuccess failBlock:(WebRequestDataFail)blockFail{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    NSMutableString *url = [NSMutableString stringWithFormat:@"%@",BASEURL];
//    [url appendString:string?:@""];
//    
//    if ([string hasPrefix:@"http://"]) {
//        url = [NSMutableString stringWithString:string];
//    }
    NSLog(@"url   %@  params  %@", string, params);
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];

    sessionManager.responseSerializer = responseSerializer;//[AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //text/html application/json
    [sessionManager POST:string parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress:%lld", downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSLog(@"allHeaders:%@",allHeaders);
        NSLog(@"responseObject:%@", responseObject);
        
        if ([responseObject isKindOfClass:[NSNull class]] || responseObject == nil) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            return ;
        }
        if ([string isEqualToString:@"/user/Login"]) {
            NSDictionary *dic = @{@"head":allHeaders,@"body":responseObject};
            if (blockSuccess) {
                blockSuccess(dic);
            }
        }else{
            if (blockSuccess) {
                blockSuccess(responseObject);
            }
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        blockFail(error);
    }];
    
}

+ (void)getDataFromWebHaveCookieWithParams:(NSDictionary *)params urlString:(NSString *)string successBlock:(WebRequestDataSuccess)blockSuccess failBlock:(WebRequestDataFail)blockFail{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@",BASEURL];
    [url appendString:string];
    [url appendString:@"?"];
    NSLog(@"url   %@  params  %@", url, params);
    
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
//    if (LoginCookie) {
//        [sessionManager.requestSerializer setValue:LoginCookie forHTTPHeaderField:@"Cookie"];
//    }
    
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //text/html
    

//    
//    NSString *stringURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld", downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSLog(@"%@",allHeaders);
        NSLog(@"%@",responseObject);
        if (blockSuccess) {
            blockSuccess(responseObject);
        }
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        blockFail(error);
    }];
    
}

+ (void)getDataFromWebWithParams:(NSDictionary *)params contentType:(NSString *)contenttype urlString:(NSString *)string successBlock:(WebRequestDataSuccess)blockSuccess failBlock:(WebRequestDataFail)blockFail{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@",BASEURL];
    [url appendString:string];
    if ([string hasPrefix:@"http://"]) {
        url = [NSMutableString stringWithString:string];
    }
    NSLog(@"url   %@  params  %@", url, params);
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:contenttype];
    //text/html
    [sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld", downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        if (blockSuccess) {
            blockSuccess(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        blockFail(error);
    }];
    
}

+(void)uploadUserHeaderImageWithParams:(NSDictionary *)params withURLString:(NSString *)URLString withImage:(UIImage *)img withImgUrl:(NSString *)imgStr withSuccessBlock:(WebRequestDataSuccess)successBlock withFailBlock:(WebRequestDataFail)failBlock {
    
    
    NSData *imageData = UIImagePNGRepresentation(img);
    
    NSURL *fileUrl = [[NSBundle mainBundle]URLForResource:@"userHeader.png" withExtension:@"png"];
    
    NSLog(@"--------=========------%@",fileUrl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL URLWithString:imgStr] name:@"picture" fileName:@"userHeader.png" mimeType:@"image/png" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        
        NSLog(@"---------------%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
}



+(void)uploadUserHeaderImageWithParams:(NSDictionary *)params withURLString:(NSString *)URLString withImageURL:(NSURL *)ImageURL withSuccessBlock:(WebRequestDataSuccess)successBlock withFailBlock:(WebRequestDataFail)failBlock {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"];
    [manager.requestSerializer setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
    [manager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
     
//        [formData appendPartWithFileURL:ImageURL name:@"picture" fileName:@"666.png" mimeType:@"image/png" error:nil];
        [formData appendPartWithFileURL:ImageURL name:@"picture" fileName:@"picture" mimeType:@"image/png" error:nil];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *string=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"成功回调：%@",string);
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        successBlock(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock(error);
    }];
    
}




+ (void)uploadImg:(UIImage *)img withImgName:(NSString *)imgName withFileName:(NSString *)fileName withParams:(NSDictionary *)params withUrlStr:(NSString *)urlStr withSuccessBlock:( WebRequestDataSuccess )successBlock withFailBlock:( WebRequestDataFail)failBlock{

    NSData *data = UIImagePNGRepresentation(img);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png", nil];
    
    
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imgName fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        successBlock(dic);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock(error);
        
    }];



}







@end
