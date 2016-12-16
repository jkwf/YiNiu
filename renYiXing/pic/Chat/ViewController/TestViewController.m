//
//  TestViewController.m
//  AppRTC
//
//  Created by Longxun on 16/6/15.
//  Copyright © 2016年 ISBX. All rights reserved.
//




#import "TestViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "RTCEAGLVideoView.h"
#import "RTCMediaStream.h"
#import "RTCPeerConnectionFactory.h"
#import "RTCMediaConstraints.h"
#import "RTCPeerConnection.h"
#import "RTCPair.h"
#import "RTCVideoCapturer.h"
#import "RTCVideoTrack.h"
#import "RTCAudioTrack.h"
#import "RTCICECandidate.h"
#import "RTCICEServer.h"
#import "RTCSessionDescriptionDelegate.h"
#import "RTCSessionDescription.h"
#import "SRWebSocket.h"
#import "NSDictionary+YYAdd.h"
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"]
#define VideoPath [DOCSFOLDER stringByAppendingPathComponent:@"test.mp4"]
//#define WebsocketUrl @"ws://linux.joysw.cn:8080/yitongxun/chat?"
#import "Websocket.h"//ws://linux.joysw.cn
//#define Websocket @"http://47.90.53.138:8080/yitongxun/map?"
//#define Websocket @"ws://smartdd.excellandtech.com:8080/yitongxun/chat?"
@interface TestViewController ()<RTCPeerConnectionDelegate, RTCSessionDescriptionDelegate, SRWebSocketDelegate,RTCEAGLVideoViewDelegate>
{
    RTCPeerConnectionFactory *_factory;
    NSString *localId;
    NSString *remotId;
    RTCICEServer *ice;
    RTCEAGLVideoView *remote_view;
    RTCEAGLVideoView * local_view;
    RTCMediaConstraints*sdp;
    RTCVideoTrack*remoteVideoTrack;
    UIButton *okBtn;
    UIButton *noBtn;
    UIButton *endBtn;
}
@property(nonatomic, strong) RTCMediaStream    *local_media_stream;
@property(nonatomic, strong) RTCPeerConnection *peerConnection;
@property(nonatomic, strong) SRWebSocket *socket;

@property(nonatomic) BOOL isInitiator;
@end

@implementation TestViewController


- (RTCMediaConstraints *)defaultMediaStreamConstraints {
    NSArray *mandatoryConstraints = @[];
    
    NSArray *optionalConstraints = @[];
                                     
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:mandatoryConstraints
     optionalConstraints:optionalConstraints];
    return constraints;
}

- (RTCMediaConstraints *)defaultAnswerConstraints {
    return [self defaultOfferConstraints];
}

- (RTCMediaConstraints *)defaultOfferConstraints {
    NSArray *mandatoryConstraints = @[
                                      [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],
                                      [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                      ];
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:mandatoryConstraints
     optionalConstraints:nil];
    return constraints;
}

- (RTCMediaConstraints *)defaultPeerConnectionConstraints {
    NSArray *mandatoryConstraints = @[
                                      [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],
                                      [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                      ];
    NSArray *optionalConstraints = @[
                                     [[RTCPair alloc] initWithKey:@"DtlsSrtpKeyAgreement" value:@"true"]
                                     ];
    
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:mandatoryConstraints
     optionalConstraints:optionalConstraints];
    return constraints;
}
- (RTCMediaConstraints *)defaultVideoConstraints{
    NSArray *optionalConstraints = @[
                                     [[RTCPair alloc] initWithKey:@"MinWidth" value:@"176"],
                                     [[RTCPair alloc] initWithKey:@"MinHeight" value:@"144"],
                                     [[RTCPair alloc] initWithKey:@"MaxWidth" value:@"400"],
                                     [[RTCPair alloc] initWithKey:@"MaxHeight" value:@"300"]
                                     ];
    
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:nil
     optionalConstraints:optionalConstraints];
    return constraints;

}
- (void)openSocket{
    NSString *str = [NSString stringWithFormat:@"%@roomId=%@&userName=%@",WebSocketAddress,self.roomId,[[SocketOprationData shareInit] loginInfo][NODE_USERId]];
    _socket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:str]] ;
    _socket.delegate = self;
    [_socket open];
}
- (void)initPeer{
//    [self openSocket];
    sdp = [self defaultPeerConnectionConstraints];
     _factory = [[RTCPeerConnectionFactory alloc] init];
    //@"turn:linux.joysw.cn:3478"
    ice = [[RTCICEServer alloc] initWithURI:[NSURL URLWithString:TurnUrl]
                                   username:TurnUserName
                                   password:TurnPassword];        local_view = [[RTCEAGLVideoView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:local_view];
    
        _local_media_stream = [_factory mediaStreamWithLabel:@"ARDAMS"];
    
        NSString *camera_id = nil;
    
        for (AVCaptureDevice *dev in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] ) {
            if (dev.position == AVCaptureDevicePositionBack) {
                camera_id = [dev localizedName];
                break;
            }
        }
    
    RTCVideoCapturer *capturer = [RTCVideoCapturer capturerWithDeviceName:camera_id];
    
    
    RTCVideoSource *source     = [_factory videoSourceWithCapturer:capturer constraints:[self defaultVideoConstraints]];
        RTCVideoTrack *video_track = [_factory videoTrackWithID:@"ARDAMSv0" source:source];
    local_view.delegate = self;
    [video_track addRenderer:local_view];
    //self.isVideo = YES;
    if (self.isVideo) {
         [_local_media_stream addVideoTrack:video_track];
    }
   
    [_local_media_stream addAudioTrack:[_factory audioTrackWithID:@"ARDAMSa0"]];
    

    
   remote_view = [[RTCEAGLVideoView alloc] initWithFrame:CGRectZero];
    remote_view.delegate = self;
    [self.view addSubview:remote_view];
    
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
}




- (void)waitForAnswer {
    //[self drainMessageQueueIfReady];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPeer];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setTitle:@"结束" forState:UIControlStateNormal];
    endBtn.frame = CGRectMake((self.view.frame.size.width-50)/2., self.view.frame.size.height-200, 50, 50);
    endBtn.tag =3;
    [endBtn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
    
    if (self.iscall) {
        
        
       
        
//        [[JoyIMSocial shareSocket] callUserVoiceWithFromId:[[JoyIMSocial shareSocket] sessionId] toId:(long)self.personDic.fid];
        
        
        [[Websocket shareInit] connectWithId:self.personDic.fid type:Invite_Type_Video event:WS_Event_Call];
        endBtn.hidden = NO;
    }else{
        endBtn.hidden = YES;
        okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setTitle:@"接受" forState:UIControlStateNormal];
        okBtn.frame = CGRectMake(50, self.view.frame.size.height-200, 50, 50);
        okBtn.tag = 1;
        [okBtn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okBtn];
        
        noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [noBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        noBtn.frame = CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-200, 50, 50);
        noBtn.tag =2;
        [noBtn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:noBtn];
        
    }
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(otherAction:) name:WSOtherAction object:nil];
    
}
- (void)actionButton:(UIButton *)btn{
    if (btn.tag == 1) {
        [[Websocket shareInit] connectWithId:self.toId type:Invite_Type_Video event:WS_Event_Agree];
        
        [self openSocket];
        okBtn.hidden = YES;
        noBtn.hidden = YES;
        endBtn.hidden = NO;
    }else if (btn.tag == 2) {
        [[Websocket shareInit] connectWithId:self.toId type:Invite_Type_Video event:WS_Event_Hangup];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (btn.tag == 3) {
        [[Websocket shareInit] connectWithId:self.toId type:Invite_Type_Video event:WS_Event_Deline];
        [self.socket close];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)otherAction:(NSNotification *)noti{
    NSDictionary *dic = [noti object];
    if ([dic[@"event"] isEqualToString:WS_Event_Agree]) {
        self.roomId = dic[@"roomId"];
        [self openSocket];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}
// Triggered when the SignalingState changed.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
 signalingStateChanged:(RTCSignalingState)stateChanged{
    
}

// Triggered when media is received on a new stream from remote peer.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
           addedStream:(RTCMediaStream *)stream{
    NSLog(@"////////////////addstream");
    dispatch_async(dispatch_get_main_queue(), ^{
    if (stream.videoTracks.count) {
        remoteVideoTrack = stream.videoTracks.lastObject;
        [remoteVideoTrack addRenderer:remote_view];
    }
    });

  
    
 
}

// Triggered when a remote peer close a stream.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
         removedStream:(RTCMediaStream *)stream{
    NSLog(@"////////////////stream");

}

// Triggered when renegotiation is needed, for example the ICE has restarted.
- (void)peerConnectionOnRenegotiationNeeded:(RTCPeerConnection *)peerConnection{
    
}

// Called any time the ICEConnectionState changes.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
  iceConnectionChanged:(RTCICEConnectionState)newState{
    
}

// Called any time the ICEGatheringState changes.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
   iceGatheringChanged:(RTCICEGatheringState)newState{
    
}

// New Ice candidate have been found.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
       gotICECandidate:(RTCICECandidate *)candidate{

    NSString *event = @"ice_candidate";
    NSMutableDictionary *msg = [NSMutableDictionary dictionary];
    msg[@"event"] = event;
    msg[@"fromId"] = localId;
    
    msg[@"toId"] = remotId;
    NSMutableDictionary *candidateJson = [NSMutableDictionary dictionary];
    candidateJson[@"candidate"]=candidate.sdp;
    candidateJson[@"sdpMid"]=candidate.sdpMid;
    candidateJson[@"sdpMLineIndex"]=@(candidate.sdpMLineIndex);
    
   // NSString *candidateJson = [@{@"candidate":candidate.sdp, @"sdpMid":candidate.sdpMid, @"sdpMLineIndex":@(candidate.sdpMLineIndex)} jsonStringEncoded];
    msg[@"candidate"] = candidateJson;
    NSString *jsonString = [msg jsonStringEncoded];
    [_socket send:jsonString];
    
    //[_peerConnection addICECandidate:candidate];
}

// New data channel has been opened.
- (void)peerConnection:(RTCPeerConnection*)peerConnection
    didOpenDataChannel:(RTCDataChannel*)dataChannel{
    
}


// Called when creating a session.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
didCreateSessionDescription:(RTCSessionDescription *)sdp
                 error:(NSError *)error{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            NSLog(@"Failed to create session description. Error: %@", error);
            return;
        }
        
        NSString *type = [sdp.type lowercaseString];
        NSString *event = type;
        NSMutableDictionary *msg = [NSMutableDictionary dictionary];
        msg[@"event"] = event;
        msg[@"fromId"] = localId;

        msg[@"toId"] = remotId;
        
        NSMutableDictionary * sdpjson =[NSMutableDictionary dictionary];
        sdpjson[@"type"]= sdp.type;
        sdpjson[@"sdp"] = sdp.description;
        
        
       // NSString *sdpJson = [@{@"type":type, @"sdp":sdp.description}// jsonStringEncoded];
        msg[@"sdp"] = sdpjson;
        NSString *jsonString = [msg jsonStringEncoded];
        [_socket send:jsonString];
        [_peerConnection setLocalDescriptionWithDelegate:self
                                      sessionDescription:sdp];
        

    });

    
}

// Called when setting a local or remote description.
- (void)peerConnection:(RTCPeerConnection *)peerConnection
didSetSessionDescriptionWithError:(NSError *)error{

    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            NSLog(@"Failed to set session description. Error: %@", error);
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: @"Failed to set session description.",
                                       };
            
            return;
        }
        // If we're answering and we've just set the remote offer we need to create
        // an answer and set the local description.
        
        if (_peerConnection.localDescription == nil) {
            [_peerConnection addStream:_local_media_stream];
            [_peerConnection createAnswerWithDelegate:self constraints:sdp];
        }
        
    });

}




#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"WebSocket connection opened.");
//    self.state = kARDWebSocketChannelStateOpen;
//    if (_roomId.length && _clientId.length) {
//        [self registerWithCollider];
//    }

}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSString *messageString = message;
    NSData *messageData = [messageString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:messageData
                                                    options:0
                                                      error:nil];
    if (![jsonObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Unexpected message: %@", jsonObject);
        return;
    }
    NSDictionary *wssMessage = jsonObject;

    NSLog(@"======================%@",wssMessage);
    NSString *event = wssMessage[@"event"];
    if ([event isEqualToString:@"set_id"]) {
        localId = wssMessage[@"id"];
    }else if ([event isEqualToString:@"user_join"]){
        remotId = wssMessage[@"id"];
         _peerConnection = [_factory peerConnectionWithICEServers:[NSArray arrayWithObject:ice] constraints:sdp delegate:self];
        [_peerConnection addStream:_local_media_stream];
        [_peerConnection createOfferWithDelegate:self constraints:sdp];
        
    }else if ([event isEqualToString:@"offer"]){
        remotId = wssMessage[@"fromId"];
        _peerConnection = [_factory peerConnectionWithICEServers:[NSArray arrayWithObject:ice] constraints:sdp delegate:self];
        [_peerConnection setRemoteDescriptionWithDelegate:self sessionDescription:[[RTCSessionDescription alloc] initWithType:wssMessage[@"sdp"][@"type"] sdp:wssMessage[@"sdp"][@"sdp"]]];
        
    }else if ([event isEqualToString:@"answer"]){
        remotId = wssMessage[@"fromId"];
        [_peerConnection setRemoteDescriptionWithDelegate:self sessionDescription:[[RTCSessionDescription alloc] initWithType:wssMessage[@"sdp"][@"type"] sdp:wssMessage[@"sdp"][@"sdp"]]];
        
    }else if ([event isEqualToString:@"ice_candidate"]){
        remotId = wssMessage[@"fromId"];
        NSDictionary *dic = wssMessage[@"candidate"];
        [_peerConnection addICECandidate:[[RTCICECandidate alloc] initWithMid:dic[@"sdpMid"] index:[dic[@"sdpMLineIndex"] integerValue] sdp:dic[@"candidate"]]];
    }else if ([event isEqualToString:@"user_leave"]){
        
    }
    return;
    
    
//    NSString *payload = wssMessage[kARDWSSMessagePayloadKey];
//    ARDSignalingMessage *signalingMessage =
//    [ARDSignalingMessage messageFromJSONString:payload];
//    NSLog(@"WSS->C: %@", payload);
//    [_delegate channel:self didReceiveMessage:signalingMessage];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"WebSocket error: %@", error);
    //self.state = kARDWebSocketChannelStateError;
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(NSString *)reason
         wasClean:(BOOL)wasClean {
    NSLog(@"视频的 WebSocket closed with code: %ld reason:%@ wasClean:%d",
          (long)code, reason, wasClean);
//    NSParameterAssert(_state != kARDWebSocketChannelStateError);
//    self.state = kARDWebSocketChannelStateClosed;
}
#pragma mark -------

- (void)videoView:(RTCEAGLVideoView*)videoView didChangeVideoSize:(CGSize)size{
    if (videoView == local_view) {
       
        
    }else if (videoView == remote_view) {
         local_view.frame = CGRectMake(self.view.frame.size.width-110, self.view.frame.size.height-160, 100,150);
         remote_view.frame = self.view.bounds;
        [self.view bringSubviewToFront:local_view];
    }
}



@end
