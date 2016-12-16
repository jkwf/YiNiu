//
//  Header.h
//  renYiXing
//
//  Created by JOYSW on 16/6/30.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#pragma mark --- 屏幕高
#define KSHeight [[UIScreen mainScreen]bounds].size.height

#pragma mark --- 屏幕宽
#define KSWidth [[UIScreen mainScreen]bounds].size.width


#import "UIViewController+X.h"
#import "AppHelper.h"
#import "RoundView.h"
#import "RoundButton.h"
#import "RoundImgView.h"
#import "UIColor+Hex.h"
#import "UIViewController+Predicate.h"
#import "UIColor+Wonderful.h"
#import "AppDelegate.h"

#define ApplicationDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#import "MainViewController.h"
#import "PersonalViewController.h"
#import "MyConsumptionViewController.h"
#import "StrategyViewController.h"
#import "MySpaceViewController.h"
#import "RenyibiViewController.h"
#import "VirtualGoldViewController.h"
#import "FocusOnPeopleViewController.h"
#import "MyFansViewController.h"
#import "SetupViewController.h"
#import "FeedbackViewController.h"
#import "RecommandToFriend.h"
#import "DiyView.h"
#import "Masonry.h"
#import "PersonalDataViewController.h"
#import "StoryKingViewController.h"
#import "InvestClinicViewController.h"
#import "ReadingViewController.h"
#import "TrainingVideoViewController.h"
#import "BabySpaceViewController.h"
#import "MasterSpaceViewController.h"
#import "WithdrawDepositViewController.h"
#import "PerformanceViewController.h"
#import "StrategicRankingViewController.h"
#import "FirewoodViewController.h"
#import "RankingViewController.h"
#import "StrategicTradingViewController.h"
//#import "EaseMob.h"
#import "AddFriendViewController.h"
//#import "FriendListViewController.h"
//#import "EaseUI.h"
#import <SMS_SDK/SMSSDK.h>
#import "AFHTTPSessionManager.h"
#import "GCDAsyncSocket.h"
#import "NSString+Hash.h"
#import "SChatVC.h"
#import "SocketOprationData.h"
#import "Comm.h"
#import "SaveDataUtil.h"
#import "Message.h"
#import "WebShareData.h"
#import "YYKit.h"
#import "AddFirend.h"
#import "WDAlert.h"
#import "BaseViewController.h"
#import "NSObject+CompleteFunction.h"

#import "JoyIMSocial.h"



#define WebSocketInvite @"ws://linux.joysw.cn:8080/yitongxun/voip?" //@"wss://jkt2.joysw.cn:8443/yitongxun/voip?"//
#define WebSocketAddress @"ws://linux.joysw.cn:8080/yitongxun/chat?"//@"wss://jkt2.joysw.cn:8443/yitongxun/chat?"//
#define GetTurnServer @"http://linux.joysw.cn:8080/yitongxun/turn!get" //@"https://jkt2.joysw.cn:8443/yitongxun/turn!get"//

#define TurnUserName [[NSUserDefaults standardUserDefaults] objectForKey:@"TurnUserName"]
#define TurnPassword [[NSUserDefaults standardUserDefaults] objectForKey:@"TurnPassword"]
#define TurnUrl [[NSUserDefaults standardUserDefaults] objectForKey:@"TurnUrl"]

#ifndef Header_h
#define Header_h

#define Wself                           __weak typeof(self) wself = self;
#define Sself                           __strong typeof(wself) sself = wself;


#define  RegisterUser @"http://easytrader.joysw.cn/jiaoyi/easytrader/public/index.php/mobile/index/doregister"
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define appKey  @"14588ae31b5c8"
#define appSecret  @"0b8540557ed20e6f6693687f4fa4b1e3"

#define HOST @"sw.joyvc.com"
#define PORT 8088
#define HOSTFILE @"sw.joyvc.com"
#define PORTFILE 6666
#define ConnectSocket @"ConnectSocket"

#define BaseBannerImgUrl @"http://120.27.157.147/Web/easytrader.joysw.cn/yn_contact/"


# define DLog(fmt, ...) NSLog((@"%s" "---%d---\n" fmt),__FUNCTION__, __LINE__, ##__VA_ARGS__);
//阅读
#define URLTradeLife  @"http://easytrader.joysw.cn/yn_contact/index.php?mod=books&ac=trade"
#define URLTradeLifeDetail	@"http://easytrader.joysw.cn/yn_contact/index.php?mod=books&ac=tradecontent"//	不是从书名列表点击进来需要传值
#define URLMyselfAdd	@"http://easytrader.joysw.cn/yn_contact/index.php?mod=books&ac=links"
#define URLBookList  @"http://easytrader.joysw.cn/yn_contact/index.php?mod=books"
#define URLBookContent	@"http://easytrader.joysw.cn/yn_contact/index.php?mod=books&ac=content"//	不是从书名列表点击进来需要传值
//投资诊所
#define URLOffenQuestion	@"http://easytrader.joysw.cn/yn_contact/index.php?mod=question"
//专家问诊	未完成
#define URLExpertQuestion @"http://easytrader.joysw.cn/yn_contact/index.php?mod=expert"
//大师空间
#define URLTeacherList	@"http://120.27.157.147/Web/easytrader.joysw.cn/yn_master/index.php?mod=ds_space&ac=list"
#define URLTeacherSpace	 @"http://120.27.157.147/Web/easytrader.joysw.cn/yn_master/index.php?mod=ds_space&ac=info"//	不是从大师列表点击进来需要传值
#define URLTeacherLive	@"http://120.27.157.147/Web/easytrader.joysw.cn/yn_master/index.php?mod=ds_space&ac=online_video"
#define URLTeacherOldLive	@"http://120.27.157.147/Web/easytrader.joysw.cn/yn_master/index.php?mod=ds_space&ac=past_video"
#define URLMore	@"http://120.27.157.147/Web/easytrader.joysw.cn/yn_master/index.php?mod=ds_space&ac=articles"

//宝贝空间
#define URLApplayBaby	@"http://120.27.157.147/Web/easytrader.joysw.cn/yn_contact/index.php"
#define URLBabyContent  @"http://120.27.157.147/Web/easytrader.joysw.cn/yn_contact/index.php?mod=news"//@"http://easytrader.joysw.cn/index.php?mod=news"

//视频列表	已完成	任意行视频展示
#define URLVideoShow  @"http://easytrader.joysw.cn/yn_contact/index.php?mod=news&ac=video&cid=11"
//视频列表		实战视频展示
#define URLVideoList  @"http://easytrader.joysw.cn/yn_contact/index.php?mod=news&ac=video&cid=12"//	同一个接口，根据取出内容传参
//培训视频	上传视频		上传视频
#define URLUploadVideo  @"http://easytrader.joysw.cn/yn_contact/index.php?mod=news&ac=add"
//视频详情		评论
#define URLVideoDetail  @"http://easytrader.joysw.cn/yn_contact/index.php?mod=opinion&ac=comment"//	不可直接访问
//视频详情		评论展示
#define URLVideoDetailShow  @"http://easytrader.joysw.cn/yn_contact/index.php?mod=opinion&id=17"

/** 个人信息  修改头像 */
#define PERSONURL   @"http://120.27.157.147/Web/easytrader.joysw.cn/yn_friend/index.php?"

#pragma mark-------------------  登录信息
#define LoginUserName [[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
#define SetLoginUserName(username) [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"]
#define LoginPassword [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
#define SetLoginPassword(password) [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"]
#define LoginNickName [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"]
#define SetLoginNickName(nickName) [[NSUserDefaults standardUserDefaults] setObject:(nickName?:@"")  forKey:@"nickName"]
#define LoginUserId [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
#define SetLoginUserId(UserId) [[NSUserDefaults standardUserDefaults] setObject:(UserId?:@"") forKey:@"userID"]
#define SetSynchronize [[NSUserDefaults standardUserDefaults] synchronize]





#import "NSString+appendToHttpUrl.h"

#pragma mark------------------  消息类型
#define MessageTypeVoice @"voice"
#define MessageTypePicture @"picture"
#define MessageTypeData @"data"
#define MessageTypeAudioCall @"audioCall"
#define MessageTypeVideoCall @"videoCall"





#pragma mark-------------------  屏幕尺寸
#define MainScreenW [UIScreen mainScreen].bounds.size.width // 屏幕宽
#define MainScreenH [UIScreen mainScreen].bounds.size.height // 屏幕高
//不同设备的屏幕比例(当然倍数可以自己控制)
#define SizeScale ((MainScreenH > 568.f) ? MainScreenH/568.f : 1)
#define multip(value) SizeScale *value


#pragma mark--------------------   获取地址
NSString *getCircleAPIURL(NSString *api);
NSString *getAPIURL(NSString *api);
NSString *getBannerUrl(NSString *api);



#define MessageTypePendMsg @"pendMsg"
#define MessageTypeIMMsg  @"imMsg"
#endif /* Header_h */
