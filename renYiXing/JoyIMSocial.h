//
//  JoyIMSocial.h
//  Pods
//
//  Created by Longxun on 16/9/22.
//
//

#import <Foundation/Foundation.h>
#define MessageTypeVoice @"voice"
#define MessageTypePicture @"picture"
#define MessageTypeData @"data"
#define MessageTypeAudioCall @"audioCall"
#define MessageTypeVideoCall @"videoCall"



#define MessageTypePendMsg @"pendMsg"
#define MessageTypeIMMsg  @"imMsg"

#define HOST @"sw.joyvc.com"//@"sw.joyvc.com"//@"sw.joyvc.com"//
#define PORT 8088

#define HOSTFILE  @"sw.joyvc.com"//@"sw.joyvc.com"//
#define PORTFILE 6666

//#define WebSocketInvite @"ws://linux.joysw.cn:8080/yitongxun/voip?" //@"wss://jkt2.joysw.cn:8443/yitongxun/voip?"//
//#define WebSocketAddress @ws://linux.joysw.cn:8080/yitongxun/chat?"//@"wss://jkt2.joysw.cn:8443/yitongxun/chat?"//
//#define GetTurnServer @"ws://linux.joysw.cn:8080/yitongxun/turn!get" //@"https://jkt2.joysw.cn:8443/yitongxun/turn!get"//

typedef NS_ENUM(NSInteger, JoyIMSocialUserType){
    JoyIMSocialUserTypePatient = 0,//患者
    JoyIMSocialUserTypeDoctor,//医生
    JoyIMSocialUserTypeAdministrator, //管理员
    
};

typedef NS_ENUM(NSInteger, JoyIMSocialLoginType){
    JoyIMSocialLoginTypeAndroid = 0,//Android
    JoyIMSocialLoginlTypeiOS,//iOS
    JoyIMSocialLoginTypeWeb, //web
    
};

//视频接通后修改本地和远程视频view的frame
//userinfo:{@"size":NSStringFromCGSize(size)} object：是视频view
#define NotificationRemoteMediaViewChange  @"NotificationRemoteMediaViewChange"

//收到对方呼叫视频
#define NotificationRecieveCallVideo @"NotificationRecieveCallVideo"
//收到对方拒绝视频
#define NotificationRecieveRejectVideo @"NotificationRecieveRejectVideo"
//收到对方线路忙
#define NotificationRecieveBusyVideo @"NotificationRecieveBusyVideo"
//收到对方接受视频
#define NotificationRecieveAcceptVideo @"NotificationRecieveAcceptVideo"
//收到对方挂断视频
#define NotificationRecieveDelineVideo  @"NotificationRecieveDelineVideo"
//收到对方关闭摄像头
#define NotificationRecieveCloseCamera  @"NotificationRecieveCloseCamera"
//收到对方打开摄像头 userinfo 中 RemoteView为对方视频view
#define NotificationRecieveOpenCamera  @"NotificationRecieveOpenCamera"
@class JoyIMSocial;

@protocol JoyIMSocialDelegate <NSObject>
@optional
- (void)recevDataWithSocket:(JoyIMSocial *)socket messageType:(NSString *)msgCmd subMessageType:(NSString *)msgSubCmd resultCode:(int)code info:(id)info error:(NSError *)error;
- (void)socketConnectedWithSocket:(JoyIMSocial *)socket;
- (void)socketDisconnectedWithSocket:(JoyIMSocial *)socket;
@end

@interface JoyIMSocial : NSObject
@property(nonatomic)BOOL isConnected;
@property(nonatomic)long sessionId;
@property(nonatomic,weak)id<JoyIMSocialDelegate>delegate;
+(id)shareSocket;
- (BOOL)openSocketWithHost:(NSString *)host onPort:(int)port;
- (void)closeSocket;
//2、注册用户：
//输入：用户名，密码（明文，系统自己用md5加密），用户类型：0：患者，1：医生，2：管理员
//输出：成功：1，失败：0
- (BOOL)registerWithUser:(NSString *)userName passWord:(NSString *)password userType:(JoyIMSocialUserType) joyIMSocialUserType;

//3、登录
//输入：用户名，密码（明文，系统自己用MD5加密），
//用户类型：userType = 0：患者，1：医生，2：管理员
//设备类型：logintype = 0表示android登录，1表示IOS登录，2表示WEBIM登录
//输出：发送成功：1，发送失败：0
- (BOOL)loginWithUser:(NSString *)userName passWord:(NSString *)password userType:(JoyIMSocialUserType) joyIMSocialUserType loginType:(JoyIMSocialLoginType)logintype;


//4、发送消息
//输入：
//fromId发送者ID，
//toId接收者ID，
//msg消息正文，
//msgType消息类型：实时消息|截断消息
-(BOOL)sendWithMessage:(NSString*)msg fromeId:(long)fromid toId:(long)toid msgType:(NSString *)msgtype;

//5、发送文件
//输入：
//发送者ID，接收者ID， 文件路径，  文件大小，
//文件类型fileType：voice、picture、data、video等
//消息类型msgType:实时消息|截断消息
- (BOOL)sendFileWithFilePath:(NSString *)path fromId:(long)fromid toId:(long)toid fileLength:(int)length fileType:(NSString *)flieType voiceTime:(int)time msgType:(NSString *)msgType;

//6、发送心跳消息
//输入：发送者ID
- (BOOL)sendHeartFromId:(long)fromid;

//7、视频呼叫
//输入：发送者ID，接收者ID
//输出：发送成功：1，发送失败：0
//返回字典里 可以修改View的frame调整显示位置
//RocalView  返回显示本地视频的view
//RemoteView 返回显示远程视频的view

- (NSDictionary *)callUserVideoWithFromId:(long)fromid toId:(long)toid ;


//8、响应呼叫
//输入：发送者ID,接收者ID, 响应动作：act: 1:同意，0：拒绝
//输出：发送成功：1，发送失败：0
//isAccept = yes 时 返回以下两个参数
//返回字典里 LocalView  返回显示本地视频的view RemoteView 返回显示远程视频的view
// isAccept = no 时 返回nil
- (NSDictionary *)respondsVideoCallWithFromId:(long)fromid toid:(long)toid accept:(BOOL)isAccept;

//9、挂断
- (BOOL)delineVideoWithFromId:(long)fromid toid:(long)toid;
    
//发送语音通话
- (BOOL)callUserVoiceWithFromId:(long)fromid toId:(long)toid ;
//响应语音通话
- (BOOL)respondsVoiceCallWithFromId:(long)fromid toid:(long)toid accept:(BOOL)isAccept;
    
//、挂断语音通话
- (BOOL)delineVoiceWithFromId:(long)fromid toid:(long)toid;
//切换摄像头方向
- (void)switchCamaraWithFront:(BOOL)isFront;
//视频切换语音
- (void)videoToVoiceWithFromId:(long)fromid toId:(long)toid;
//视频中关闭摄像头
- (void)closeVideoWithFromId:(long)fromid toId:(long)toid;
//视频中打开摄像头
- (void)openVideoWithFromId:(long)fromid toId:(long)toid;
//呼叫web端视频
- (BOOL)callWebUserVideoWithFromId:(long)fromid toId:(long)toid ;
//呼叫web端语音
- (BOOL)callWebUserVoiceWithFromId:(long)fromid toId:(long)toid ;

@end
