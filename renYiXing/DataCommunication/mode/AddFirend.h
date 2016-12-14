//
//  AddFirend.h
//  JoyIM
//
//  Created by Longxun on 16/9/16.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserInfo : NSObject
@property(nonatomic, strong)NSString *nickname ;
@property(nonatomic, strong)NSString *content;
@property(nonatomic, strong)NSString *fid;
@property(nonatomic, strong)NSString *pic;
@property(nonatomic, strong)NSString *time;
@end

@interface UserInfomation : NSObject
/* BankCardNumber = "";
 Birthday = "";
 CanMeetCreate = 0;
 CompanyName = "";
 Depart = "\U6240\U6709\U7528\U6237";
 DepositBank = "";
 Domain = 9000;
 Education = "";
 Email = "";
 FansCount = "";
 Gender = "";
 IpInfo = "0.0.0.0";
 Job = "";
 Language = 0;
 LastIP = 0;
 Mobile = 11111111121;
 NickName = "\U66f4\U597dh";
 OnlineDays = 0;
 OnlineToday = 0;
 PhotpUrl = "";
 Postalcode = "";
 Province = "";
 RealNickName = "";
 ShowEmail = 0;
 Status = 1;
 StatusPhotoUrl = "";
 "Street_addr" = "";
 TeleOffice = "";
 Theme = "";
 UserID = 10003275;
 UserName = 11111111121;
 UserStatusNo = "";
 Version =         (
 unkown,
 unkown
 );
 publishVideoUrl = "";
 "sip_name" = "";
 "sip_psw" = "";
*/
@property(nonatomic, strong)NSString *UserName ;
@property(nonatomic, strong)NSString *UserID;
@property(nonatomic, strong)NSString *Street_addr;
@property(nonatomic, strong)NSString *PhotpUrl;
@property(nonatomic, strong)NSString *NickName;
@end

@interface CircleInfo : NSObject
@property(nonatomic, strong)NSString *creatorid ;
@property(nonatomic, strong)NSString *qname ;
@property(nonatomic, strong)NSString *qid;
@property(nonatomic, strong)NSString *qimg;
@property(nonatomic, strong)NSString *num;
@end

@interface Friend : NSObject
@property(nonatomic, strong)NSString *nickName ;
@property(nonatomic, strong)NSString *online;
@property(nonatomic, strong)NSString *userId;
@property(nonatomic, strong)NSString *userName;
@end
@interface AddFirend : NSObject
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic, strong)NSString *groupID;
@property(nonatomic, strong)NSString *toID;
@property(nonatomic, strong)NSString *msg;
@property(nonatomic, strong)NSString *result;
@property(nonatomic, strong)NSString *err;
@property(nonatomic, strong)NSString *time;
//<JoyIM>
//<type>req</type>
//<cmd>addFriend</cmd>
//<sessionID>1421792</sessionID>
//<groupid>1234</groupid>
//<toID>7552666</toID>
//<msg>你好!我是张可，请求加您为好友</msg>
//</JoyIM>


@end


@interface HasBulletin : NSObject
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic, strong)NSString *groupID;
@property(nonatomic, strong)NSString *touID;
@property(nonatomic, strong)NSString *fromID;
@property(nonatomic, strong)NSString *msg;

@end


@interface FetchBulletinFriend : NSObject
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic, strong)NSString *userID;
@property(nonatomic, strong)NSString *fromID;

//<JoyIM>
//<type>req</type>
//<cmd>fetchBulletin</cmd>
//<sessionID>7552666</sessionID>
//<userID>7552666</userID >
//<fromID>1421792</fromID> //如果为0 表示获取所有未读的信息
//</JoyIM>

@end


@interface FetchBulletinRsp: NSObject
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic, strong)NSDictionary *bulletinList;
@property(nonatomic, strong)NSMutableArray *arrayList;


//其中消息类型：<bulletinType>n</bulletinType>
//n=1 请求加好友
//n=2 接受加好友
//n=3拒绝加好友
//
//<JoyIM>
//<type>rsp</type>
//<cmd>fetchBulletin</cmd>
//<sessionID>7552666</sessionID>
//<bulletinList>
//<bulletin>
//<fromID>1421792</ fromID>
//<toID>7552666</toID>
//<time>1472280683</time>
//<bulletinType>1</bulletinType>
//<msg>你好!我是张可，请求…</msg>
//<groupID>0</groupID>
//</bulletin>
//<bulletin>
//<fromID>2421792</ fromID>
//<toID>7552666</toID>
//<time>1472280683</time>
//<bulletinType>1</bulletinType>
//<msg>你好!我是张可，请求…</msg>
//<groupID>0</groupID>
//</bulletin>
//</bulletinList>
//</JoyIM>

@end

@interface BulletinObj : NSObject
@property(nonatomic, strong)NSString *groupID;
@property(nonatomic, strong)NSString *toID;
@property(nonatomic, strong)NSString *fromID;
@property(nonatomic, strong)NSString *msg;
@property(nonatomic, strong)NSNumber *bulletinType;
@property(nonatomic, strong)NSString *time;
@end

@interface  QueryUserRequestMode: NSObject
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic)long long meetingID;
@end

@interface  SearchUserRequestMode: NSObject
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic, strong)NSString *userName;
@property(nonatomic, strong)NSString *userID;
@end

@interface  AddCircle: NSObject
/*
<type>req</type>
<sessionID>1421788</sessionID>
<userID>1421788</userID>
<cmd>addGroup</cmd>
<newpasswd>e10adc3949ba59abbe56e057f20f883e</newpasswd> // md5,可以为空,聊天室用
<name>joysw202 </name>       群或聊天室名
<groupType>0</groupType>      类型：0、1、2、3、4、5 (聊天室暂时未用此项)
< bulletin >测试会议室</bulletin>	 群或聊天室公告
<theme>111</theme>	         群或聊天室主题
<mode>0</mode>         0:普通群   1：临时群    10: 普通聊天室 ，11：临时聊天室
*/
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic, strong)NSString *userID;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *bulletin;
@property(nonatomic, strong)NSString *theme;
@property(nonatomic, strong)NSString *mode;
@property(nonatomic, strong)NSString *newpasswd;
@property(nonatomic, strong)NSString *groupType;

@end

@interface GroupMsg : NSObject
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *cmd;
@property(nonatomic, strong)NSString *sessionID;
@property(nonatomic, strong)NSString *groupID;
@property(nonatomic, strong)NSString *timeStamp;
@property(nonatomic, strong)NSString *msg;
@property(nonatomic, strong)NSString *fileType;

@end

@interface FetchGroupMsg : NSObject
//<groupid>1123</groupid><fromid>10003298</fromid><time>1479041355</time><msg>vvbnnm</msg></group></list><result>1</result><err>ok</err><timeStamp>1479041354893</timeStamp>
@property(nonatomic, strong)NSString *groupid;
@property(nonatomic, strong)NSString *fromid;
@property(nonatomic, strong)NSString *time;
@property(nonatomic, strong)NSString *msg;
@end
