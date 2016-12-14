//
//  main.m
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
NSString *getAPIURL(NSString *api)
{
    return [NSString stringWithFormat:@"%@%@",BASEURL,api];
}
NSString *getCircleAPIURL(NSString *api)
{
    return [NSString stringWithFormat:@"%@%@",CIRCLEURL,api];
}
NSString *getBannerUrl(NSString *api){
    return [NSString stringWithFormat:@"%@%@",BaseBannerImgUrl,api];
}
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
