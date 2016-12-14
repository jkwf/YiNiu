//
//  Comm.h
//  JoyIM
//
//  Created by Eben on 2/22/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#ifndef JoyIM_Comm_h
#define JoyIM_Comm_h


#define PTL_REQ @"req"
#define PTL_RSP @"rsp"
#define PTL_CMD_LOGIN @"login"
#define PTL_CMD_REGISTER @"InterfaceAddUser"
#define PTL_CMD_MODIFY_PWD @"modifyPsw"
#define PTL_CMD_USER_STATUS @"userStatus"
#define PTL_CMD_PUSH_STATUS @"pushStatus"
#define PTL_CMD_BACKUP_FRIEND @"backupFriend"
#define PTL_CMD_RESTORE_FRIEND @"restoreFriend"
#define PTL_CMD_SEND_FILE_FINISHED @"sendFileFinished"
#define PTL_CMD_DEPART @"depart"
#define PTL_CMD_DEPART_MEMBER @"departMember"
#define PTL_CMD_GROUP @"group"
#define PTL_CMD_GROUP_MEMBER @"groupMember"
#define PTL_CMD_GROUP_OFFLINE_MSG @"groupLeaveWord"
#define PTL_CMD_FRIEND_LIST @"fetchFriendList"
#define PTL_CMD_CHECK_USER_ONLINE @"checkUserOnline"

#define PTL_CMD_FETCH_MSG @"fetchMsg"
#define PTL_CMD_SEND_MSG @"sendMsg"
#define PTL_CMD_SEND_FILE @"sendFile"
#define PTL_CMD_RECV_FILE @"receiveFile"

#define PTL_CMD_FETCH_GROUP_MSG @"fetchGroupMsg"
#define PTL_CMD_GROUP_MSG @"groupMsg"
#define PTL_CMD_SEND_GROUP_MSG @"sendGroupMsg"
#define PTL_CMD_GetUserInfo @"getUserInfo"
#define PTL_CMD_ADD_FRIEND @"addFriend"
#define PTL_CMD_Has_Bulletin @"hasBulletin"
#define PTL_CMD_Fetch_Bulletin @"fetchBulletin"
#define PTL_CMD_Accept_Friend @"acceptFriend"
#define PTL_CMD_Reject_Friend @"rejectFriend"
#define PTL_CMD_FETCH_MEETING_MEMBER @"meetingMemberJyd"
#define PTL_CMD_RSP_MEETING_MEMBER  @"meetingMember"
#define PTL_CMD_AddGroup  @"addGroup"
#define PTL_CMD_GroupMsg @"groupMsg"
#define PTL_CMD_FetchGroupMsg @"fetchGroupMsg"

#define NODE_ROOT_NAME @"JoyIM"
#define NODE_TYPE_NAME @"type"
#define NODE_CMD_NAME @"cmd"
#define XmlDomainHead @"<JoyIM>"
#define XmlDomainEnd @"</JoyIM>"

#define NODE_RESULT_NAME @"result"
#define NODE_ERR_NAME @"err"
#define NODE_PASSWORD @"userPsw"
#define NODE_USER @"user"
#define NODE_USER_NAME @"userName"
#define NODE_MOBILE @"mobile"
#define NODE_EMAIL @"email"
#define NODE_SESSION_ID @"sessionID"
#define NODE_USERID @"userID"
#define NODE_USERId @"userId"
#define NODE_USER_STATUS @"status"
#define NODE_COMPANY @"company"
#define NODE_TITLE @"title"
#define NODE_JOB @"job"
#define NODE_PROVINCE @"province"
#define NODE_REGION @"region"
#define NODE_ADDRESS @"street_addr"
#define NODE_ZIPCODE @"postalcode"
#define NODE_TOUID @"toUid"
#define NODE_FILE_ID @"fileId"
#define NODE_FILE_NAME @"fileName"
#define NODE_GROUP @"group"
#define NODE_GROUP_ID @"groupID"
#define NODE_LIST @"list"
#define NODE_DEPART @"depart"
#define NODE_ID @"id"
#define NODE_NAME @"name"
#define NODE_PARENT_ID @"parentId"
#define NODE_DOMAIN_ID @"domainId"
#define NODE_DEPART_ID @"departID"
#define NODE_DOMAIN @"domain"

#define NODE_LOGINTYPE @"loginType"

#define NODE_MEMBER @"member"
#define NODE_GREATOR_ID @"creatorID"
#define NODE_BULLETIN @"bulletin"
#define NODE_THEME @"theme"
#define RECEIVED_DATA @"receivedData"
#define NODE_TIME @"time"
#define NODE_FROME_ID @"fromID"
#define NODE_FROM @"from"
#define NODE_TO @"to"
#define NODE_TO_ID @"toID"
#define NODE_MESSAGE @"msg"
#define NODE_NICK_NAME @"nickName"
#define NODE_ITEM @"item"
#define NODE_RRD_LIST @"frdList"

#define NODE_MEMBER_USERSIG @"userSig"
#define NODE_TOUSERNAME @"toUserName"
#define NODE_MSG @"msg"

#define NODE_USER_NAME_LITTLE @""
#define NODE_USERINFO @""
#define NODE_TELEPHONE @""
typedef enum enmPtlPair
{
    req = 1,
    rsp,
    
}PTLPair;

typedef enum enmPTlCmdType
{
    cmdLogin = 1,
    cmdmodifyPsw,
    cmdUserStatus,
    cmdPushStatus,
    cmdBackupFriend,
    cmdRestoreFriend,
    cmdSendFileFinished,
    cmdDepart,
    cmdDepartMember,
    cmdGroup,
    cmdGroupMember,
    cmdGroupLeaveWord,
    cmdBulletin,
    cmdVote,
    cmdMeetingList,
    cmdMeetingMember,
    cmdFriendList,
    cmdCheckUserOnline,
    cmdFetchMsg,
    cmdSendMsg,
    
    cmdGroupMsg,//发送
    cmdSendGroupMsg,//接受
    cmdregister,
    
}PTLCmdType;

typedef enum enmUserStatus:int
{
    online = 1,
    offline,
}UserStatus;

#endif
