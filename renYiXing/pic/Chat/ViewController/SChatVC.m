//
//  SChatVC.m
//  SChatUI
//
//  Created by tongxuan on 16/7/27.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "SChatVC.h"
#import "SChatToolBar.h"
#import "ChatBaseCell.h"
#import "ChatBaseModel.h"
#import "ChatTextCell.h"
#import "ChatTextModel.h"
#import "ChatImageCell.h"
#import "ChatImageModel.h"
#import "ChatRecordModel.h"
#import "ChatRecordCell.h"
#import "GroupMemberListVC.h"
#import "ChatRecordVC.h"
#import "UIResponder+Router.h"
#import<AssetsLibrary/AssetsLibrary.h>
#import<AVFoundation/AVCaptureDevice.h>
#import<AVFoundation/AVMediaFormat.h>
#import "TestViewController.h"
#import "DealPictureMode.h"
#define NavigationBarH      CGRectGetMaxY(self.navigationController.navigationBar.frame)

@interface SChatVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
   
    NSTimeInterval _systemAnimationTime;        // 系统动画时间
}
@property (nonnull, strong)  NSMutableArray * dataArr;
@property (nonatomic, strong) UITableView * chatTable;
@property (nonatomic, strong) SChatToolBar * chatToolBar;

@property (nonatomic, strong) ChatTextCell * textCell;
@property (nonatomic, strong) ChatImageCell * imageCell;
@property (nonatomic, strong) ChatRecordCell * recordCell;
@property (nonatomic, strong) NSString *myUserid;
@end


@implementation SChatVC
- (void)setPersonDic:(UserInfo *)personDic{

    if ([personDic isKindOfClass:[CircleInfo class]]) {
        self.isCircle = YES;
            CircleInfo *c = (CircleInfo *)personDic;
            UserInfo *u = [[UserInfo alloc] init];
            u.nickname = c.qname;
            u.fid = c.qid;
            u.pic = c.qimg;
            u.content = c.num;
            _personDic = u;
            
        
    }else{
        self.isCircle = NO;
        _personDic = personDic;
    }
}

/**
 群联系人列表
 */
- (void)btn1Click{
    
    
    GroupMemberListVC *vc = [[GroupMemberListVC alloc]init];
   
    vc.groupId = [NSString stringWithFormat:@"%@",_personDic.fid];
    vc.num = [NSString stringWithFormat:@"%@",_personDic.content];
    [self.navigationController pushViewController:vc animated:YES];


}

/**
 群聊天记录
 */
- (void)btn2Click{
    
    
    ChatRecordVC *vc = [[ChatRecordVC alloc]init];
    
    vc.groupId = [NSString stringWithFormat:@"%@",_personDic.fid];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPopButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    _dataArr = [NSMutableArray array];
    
    
    if (self.isCircle) {
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, 20, 20);
        [btn1 setBackgroundImage:[UIImage imageNamed:@"Shake_icon_peopleHL"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *r = [[UIBarButtonItem alloc]initWithCustomView:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, 0, 20, 20);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"xiaofei"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *c = [[UIBarButtonItem alloc]initWithCustomView:btn2];
        
        
//        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Shake_icon_peopleHL"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick)];
//        
//        UIBarButtonItem *center = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"xiaofei"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick)];
        
        
        self.navigationItem.rightBarButtonItems = @[r,c];
        
    }
    
    
    
//    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = self.personDic.nickname;
    self.myUserid = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];
    [self loadUI];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //NSLog(@"%@",note.userInfo);
        
        NSValue *value = [note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        
        //CGRect rect = [value CGRectValue];
        CGRect rect;
        [value getValue:&rect];
        
        [UIView animateWithDuration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            [UIView setAnimationCurve:[[note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
            
            
            self.chatToolBar.frame = CGRectMake(0, rect.origin.y-ToolBarHeight -64, CGRectGetWidth(self.chatToolBar.frame), CGRectGetHeight(self.chatToolBar.frame));
            self.chatTable.frame = CGRectMake(0, 0, MainScreenW, self.chatToolBar.frame.origin.y);
            
            if (_dataArr.count > 0) {
                [self.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArr.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
            }
            
            
            
//
            
            
            
            //            CGRect r = wself.chatTable.frame;
            //            r.size.height = ScreenHeight-NavigationBarH-ToolBarHeight-rect.size.height;
            //            wself.chatTable.frame = r;
            
            //            inputView.frame = CGRectMake(0, rect.origin.y-inputView.frame.size.height, inputView.frame.size.width, inputView.frame.size.height);
            //            tableView.frame = CGRectMake(0, 0, ScreenWidth, inputView.frame.origin.y);
        }];
    }];
    

    
    
    
    
    
    
    
    
    
    
    
    
    
}
- (void)leftBarButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradWillShow:) name:UIKeyboardDidChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchMsg:) name:NotificationFetchMsg object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchMsg:) name:NotificationFetchGroupMsg object:nil];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.chatTable) {
//        [self.view endEditing:YES];
    }}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark loadUI
- (void)loadUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chatTable];
    [self.view addSubview:self.chatToolBar];

}

#pragma mark loadData
- (void)loadData {
    self.dataArr = [NSMutableArray array];
    
    
    self.textCell = [self.chatTable dequeueReusableCellWithIdentifier:@"ChatTextCell"];
    self.imageCell = [self.chatTable dequeueReusableCellWithIdentifier:@"ChatImageCell"];
    self.recordCell = [self.chatTable dequeueReusableCellWithIdentifier:@"ChatRecordCell"];

    
    [self performSelector:@selector(fetch) withObject:nil afterDelay:0.5];
}

- (void)fetch {
   

    
    
    
    NSArray *arr = [[CoreDataTool shareData] queryMsgWithKey:self.personDic.fid meetingID:[self.personDic.fid longLongValue] countNum:10];
    
    [self dealDataWithArray:arr];
    if (self.isCircle) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [[SocketOprationData shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_FetchGroupMsg objecte:self call:@selector(fetchFinish:)];
        return;
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        
        [[SocketOprationData shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_FETCH_MSG objecte:self call:@selector(fetchFinish:)];
    }
    
}
- (void)fetchMsg:(NSNotification *)obj{

    [self fetchFinish:obj.object];
//    self.noReadMsg = [SaveDataUtil readNoReadMessage];
//    [self.leftTableView reloadData];
//    [self queryMsgShow];
}
- (void)fetchFilefinish:(NSDictionary *)dic{
    
}
- (void)dealDataWithArray:(NSArray *)arr{
    for (NSDictionary *d in arr) {
        if ([d isKindOfClass:[MessageObject class]]) {
            MessageObject *obj = (MessageObject *)d;
            NSLog(@"---------------%@",obj.msg);
            
            if (![obj.keyfromTo isEqualToString:self.personDic.fid]) {
                continue;
            }
            NSString *msg = obj.msg;
            if ([msg hasPrefix:@"[{"] && [msg hasSuffix:@"}]"]){
                msg = [msg stringByReplacingOccurrencesOfString:@"[{" withString:@""];
                msg = [msg stringByReplacingOccurrencesOfString:@"}]" withString:@""];
                NSArray *arr = [msg componentsSeparatedByString:@"|"];
                NSString *fileName = arr[0];
                if ([fileName hasPrefix:@"url:"]) {
                    fileName = [fileName stringByReplacingOccurrencesOfString:@"url:" withString:@""];
                    fileName = [fileName stringByReplacingOccurrencesOfString:@" " withString:@""];
                }
                NSArray *arrType = [arr[1] componentsSeparatedByString:@":"];
                if ([arrType[1] isEqualToString:MessageTypeVoice]) {
                    
                    NSArray *timelong = [arr[2] componentsSeparatedByString:@":"];
                    ChatRecordModel * recordModel = [ChatRecordModel new];
                    recordModel.receiveUrl = fileName;
                    recordModel.timeLength = [timelong[1] integerValue];
                    recordModel.isSender = 0;
                    [_dataArr addObject:recordModel];
                }else if ([arrType[1] isEqualToString:MessageTypePicture]){
                    ChatImageModel * imgModel = [ChatImageModel new];
                    imgModel.receiveImg = fileName;
                    imgModel.isSender = 0;
                    [_dataArr addObject:imgModel];
                }
                
            }else{
                ChatTextModel * textModel = [ChatTextModel new];
                textModel.receiveText = obj.msg;
                textModel.sendText = obj.msg;
                textModel.isSender = [obj.fromID isEqualToString:self.myUserid]?YES:NO;
                [_dataArr addObject:textModel];
            }
        }else{
            NSString *msg = d[NODE_MSG];
            if ([msg hasPrefix:@"[{"]){
                msg = [msg stringByReplacingOccurrencesOfString:@"[{" withString:@""];
                msg = [msg stringByReplacingOccurrencesOfString:@"}]" withString:@""];
                NSArray *arr = [msg componentsSeparatedByString:@"|"];
                NSString *fileName = arr[0];
                if ([fileName hasPrefix:@"url:"]) {
                    fileName = [fileName stringByReplacingOccurrencesOfString:@"url:" withString:@""];
                    fileName = [fileName stringByReplacingOccurrencesOfString:@" " withString:@""];
                }
                NSArray *arrType = [arr[1] componentsSeparatedByString:@":"];
                if ([arrType[1] isEqualToString:MessageTypeVoice]) {
                    
                    NSArray *timelong = [arr[2] componentsSeparatedByString:@":"];
                    ChatRecordModel * recordModel = [ChatRecordModel new];
                    recordModel.receiveUrl = fileName;
                    recordModel.timeLength = [timelong[1] integerValue];
                    recordModel.isSender = 0;
                    [_dataArr addObject:recordModel];
                    if ([recordModel.receiveUrl hasPrefix:@"http://"]) {
                        
                        [[DealPictureMode shareInstance] sessionDownloadWithURL:recordModel.receiveUrl filename:[recordModel.receiveUrl lastPathComponent] downSuccess:^(NSString *path) {
                            NSLog(@"downsuccess");
                        } downError:^(NSError *error) {
                            NSLog(@"downerror");
                        }];
                    }
                }else if ([arrType[1] isEqualToString:MessageTypePicture]){
                    ChatImageModel * imgModel = [ChatImageModel new];
                    imgModel.receiveImg = fileName;
                    imgModel.isSender = 0;
                    [_dataArr addObject:imgModel];
                }
                
            }else{
                ChatTextModel * textModel = [ChatTextModel new];
                textModel.receiveText = d[NODE_MSG];
                textModel.isSender = NO;
                [_dataArr addObject:textModel];
            }
        }
    }
    [_chatTable reloadData];
    [self scrrollToEnd];
}
- (void)fetchFinish:(NSDictionary *)dic{
    
    
    if (self.isCircle) {
        if ([dic[@"list"] isKindOfClass:[NSString class]]) {
            return;
        }
        NSArray *arr = dic[@"list"][@"group"];
        if ([arr isKindOfClass:[NSDictionary class]]) {
            NSDictionary *tempDic = (NSDictionary*)arr;
            arr = @[tempDic];
        }
        
        [self dealDataWithArray:arr];
    }
    if ([dic[@"chat"] isKindOfClass:[NSString class]]) {
        return;
    }
    NSArray *arr = dic[@"chat"][@"item"];
    if ([arr isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = (NSDictionary*)arr;
        arr = @[tempDic];
    }
    
    [self dealDataWithArray:arr];
    
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = _dataArr[indexPath.row];
    
    if ([model isKindOfClass:[ChatTextModel class]]) {
        model = (ChatTextModel*)model;
        
        ChatTextCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTextCell"];
        [cell reloadUIWithData:_dataArr[indexPath.row]];
        return cell;

    }else if ([model isKindOfClass:[ChatImageModel class]]){
        ChatImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatImageCell"];
        [cell reloadUIWithData:_dataArr[indexPath.row]];
        return cell;

    }else if ([model isKindOfClass:[ChatRecordModel class]]){
        ChatRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatRecordCell"];
        [cell reloadUIWithData:_dataArr[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = _dataArr[indexPath.row];
    
    if ([model isKindOfClass:[ChatTextModel class]]) {
        [self.textCell reloadUIWithData:_dataArr[indexPath.row]];
        return [self.textCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }else if ([model isKindOfClass:[ChatImageModel class]]){
        [self.imageCell reloadUIWithData:_dataArr[indexPath.row]];
        return [self.imageCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }
    else if ([model isKindOfClass:[ChatRecordModel class]]){
        [self.recordCell reloadUIWithData:_dataArr[indexPath.row]];
        return [self.recordCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2) {
        if (buttonIndex == 0) {
            
            TestViewController *vc = [[TestViewController alloc] init];
            vc.personDic = self.personDic;
            vc.iscall = YES;
            vc.isVideo = YES;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }else if (buttonIndex == 1) {
            TestViewController *vc = [[TestViewController alloc] init];
            vc.personDic = self.personDic;
            vc.iscall = YES;
            vc.isVideo = NO;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
        
        return;
    }else{
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            if (buttonIndex == 0) {
                // 拍照
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                    //无权限
                    [[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"您还未允许%@获取您的相机，需要去设置开启%@的相机权限",app_Name,app_Name] delegate:nil cancelButtonTitle:@"" otherButtonTitles:@"确定", nil] show];
                }else {
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                }
                
            }else if (buttonIndex == 1) {
                // 相册
                ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
                if(author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
                    //无权限
                    [[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"您还未允许%@获取您的相册，需要去设置开启%@的相册权限",app_Name,app_Name] delegate:nil cancelButtonTitle:@"" otherButtonTitles:@"确定", nil] show];
                    return;
                }else {
                    
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    //return;
                }
            }else if (buttonIndex == 2) {
                return;
            }
        }
        else {
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];

    }
   
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    /**
     UIImagePickerControllerCropRect = "NSRect: {{0, 0}, {2668, 1772}}";
     UIImagePickerControllerEditedImage = "<UIImage: 0x7fb855926d90> size {748, 496} orientation 0 scale 1.000000";
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x7fb85352ee70> size {2668, 1772} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=106E99A1-4F6A-45A2-B320-B0AD4A8E8473&ext=JPG";
     */
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
        
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    ChatImageModel * imgModel = [ChatImageModel new];
    imgModel.sendLocalImg = image;
    imgModel.isSender = 1;
    [_dataArr addObject:imgModel];
    [self.chatTable insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_dataArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    [self scrrollToEnd];
//    [self layoutAfterInsertRow];
    NSString *name = [NSString stringWithFormat:@"%d.jpg",(int)[NSDate date].timeIntervalSince1970];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:name];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{NODE_TO_ID:self.personDic.fid,@"fileUrl":[NSURL fileURLWithPath:path].absoluteString,@"action":@"send",@"sort":@"offline",@"fileType":MessageTypePicture,@"code":@"utf8",@"msgSubType":@"imMsg"}];
    
    [[FileSocket shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_SEND_FILE objecte:self call:@selector(finishUpLoad:)];

    // 模拟
    [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@1,@"success":@0,@"failed":@0,@"data":imgModel,@"dataClass":imgModel.class} afterDelay:0];
    [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@0,@"success":@1,@"failed":@0,@"data":imgModel,@"dataClass":imgModel.class} afterDelay:2];
}
- (void)finishUpLoad:(id)obj{
    NSLog(@"-------------%@",obj);
}
/**
 *  滚动到底部
 */
- (void)scrrollToEnd {
    if ([self.dataArr count]==0) {
        return;
    }
    Wself
    // 等待insertRow操作完成之后再滚动到底部
    [UIView animateWithDuration:_systemAnimationTime animations:^{
        
    } completion:^(BOOL finished) {
        Sself
        [wself.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:sself.dataArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }];
}

- (void)layoutAfterInsertRow {
//    Wself
//    CGFloat h = [self tableView:self.chatTable heightForRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArr.count-1 inSection:0]];
//    [UIView animateWithDuration:_systemAnimationTime animations:^{
//        wself.chatTable.contentInset = UIEdgeInsetsMake(wself.chatTable.contentInset.top-h, 0, 0, 0);
//    } completion:^(BOOL finished) {
//        
//    }];
}

#pragma mark action
- (void)keyboradWillShow:(NSNotification *)sender {
    Wself
    if (!self) {
        return;
    }
    
    if (sender.name == UIKeyboardDidChangeFrameNotification&& self.chatToolBar.inputTF.inputView) {
        return;
    }
    NSDictionary * dic = sender.userInfo;
    /**
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 216}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 775}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 775}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 216}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 216}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     */
    
    _systemAnimationTime = [dic[UIKeyboardAnimationDurationUserInfoKey] floatValue]?:0.25;
    CGRect keyboardRect = [dic[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardRect.size.height;
    
    CGRect chatBarNewFrame = CGRectMake(0, ScreenHeight-NavigationBarH-ToolBarHeight-keyboardH, CGRectGetWidth(self.chatToolBar.frame), CGRectGetHeight(self.chatToolBar.frame));

    [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [UIView setAnimationCurve:[[sender.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
        wself.chatToolBar.frame = chatBarNewFrame;
       // wself.chatTable.contentInset = UIEdgeInsetsMake(-wself.chatTable.contentSize.height+chatBarNewFrame.origin.y, 0, 0, 0);
        CGRect r = wself.chatTable.frame;
        r.size.height = ScreenHeight-NavigationBarH-ToolBarHeight-keyboardH;
        wself.chatTable.frame = r;
        [self scrrollToEnd];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboradWillHide:(NSNotification *)sender {
    Wself
    NSDictionary * dic = sender.userInfo;
    CGRect chatBarNewFrame = CGRectMake(0, ScreenHeight-NavigationBarH-ToolBarHeight, CGRectGetWidth(self.chatToolBar.frame), CGRectGetHeight(self.chatToolBar.frame));
    
    [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        wself.chatToolBar.frame = chatBarNewFrame;
        //wself.chatTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        CGRect r = wself.chatTable.frame;
        r.size.height = ScreenHeight-NavigationBarH-ToolBarHeight;
        wself.chatTable.frame = r;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)sendFinish:(NSDictionary *)dic{
    int n = [dic[NODE_RESULT_NAME] intValue];
    if (n!= 1) {
        [WDAlert showAlertWithMessage:@"发送失败" time:1.5];
    }
    
    [self.chatTable scrollToRow:_dataArr.count-1 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:NO];
    
//    ChatTextModel * textModel = [ChatTextModel new];
//    textModel.sendText = dic[NODE_MSG];
//    textModel.isSender = 1;
//    if (n==1) {
//        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@0,@"success":@0,@"failed":@1,@"data":textModel,@"dataClass":textModel.class} afterDelay:0];
//    }else{
//        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@0,@"success":@0,@"failed":@0,@"data":textModel,@"dataClass":textModel.class} afterDelay:0];
//    }
}
// 传递事件
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if (self.isCircle){
        if ([eventName isEqualToString:@"SChatToolBarInputViewItemEvent"]) {
            // 点击‘+’之后，弹出选择视图的触发事件
            NSInteger index = [userInfo[@"itemIndex"] floatValue];
            if (index == 0) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                              initWithTitle:nil
                                              delegate:self
                                              cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照", @"相册",nil];
                actionSheet.tag = 1;
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];
               
            }else if (index == 1){
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                              initWithTitle:nil
                                              delegate:self
                                              cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                              otherButtonTitles:@"视频", @"语音",nil];
                actionSheet.tag = 2;
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];
                
                
            }else if (index == 2){
            
                NSLog(@"==============%@",@"发红包了");
            
            }else{
                NSLog(@"==============%@",@"转账");
            }
            
            
            
            
            
            
        }else if ([eventName isEqualToString:@"SChatToolBarSendTextEvent"]) {
            // 发送文字
            NSString * text = userInfo[@"text"];
            ChatTextModel * textModel = [ChatTextModel new];
            textModel.sendText = text;
            textModel.isSender = 1;
            [_dataArr addObject:textModel];
            
            MessageObject *mode = [[MessageObject alloc] init];
            mode.keyfromTo = self.personDic.fid;
            mode.msg = text;
            mode.fromID = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];
            mode.toId = self.personDic.fid;
            mode.userName = [[SocketOprationData shareInit] loginInfo][NODE_USER_NAME];
            mode.toUsername = self.personDic.nickname;
            mode.meetingId = @([self.personDic.fid intValue]);
            mode.time = [SaveDataUtil getNowTimeStamp];
            mode.msgType = @(MSGTYPE_Person);
            [[CoreDataTool shareData] insertModel:[NSArray arrayWithObject:mode] KeyID:mode.keyfromTo];
            
            [self.chatTable reloadData];
            [self scrrollToEnd];
            [self layoutAfterInsertRow];
            GroupMsg *msg = [[GroupMsg alloc] init];
            msg.groupID = self.personDic.fid;
            msg.type = PTL_REQ;
            msg.cmd = PTL_CMD_GroupMsg;
            msg.msg = text;
            msg.timeStamp = mode.time;
            //msg.fileType = @"";
            msg.sessionID = [[SocketOprationData shareInit] sessionID];
            [[SocketOprationData shareInit] sendReqDataWithObj:msg tag:PTL_CMD_GroupMsg objecte:self call:@selector(sendFinish:)];
            
            
            
        }else if ([eventName isEqualToString:@"SChatToolBarRecordDidFinishEvent"]) {
            // 发送语音
            NSString * url = userInfo[@"recordUrl"];
            NSNumber * time = userInfo[@"recordTime"];
            
            ChatRecordModel * recordModel = [ChatRecordModel new];
            recordModel.sendUrl = url;
            recordModel.timeLength = time.floatValue;
            recordModel.isSender = 1;
            [_dataArr addObject:recordModel];
            [self.chatTable insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_dataArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
            [self scrrollToEnd];
            [self layoutAfterInsertRow];
            
            // NSData *data = [[NSData alloc] initWithContentsOfFile:url options:NSDataReadingMappedIfSafe error:nil];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{NODE_TO_ID:self.personDic.fid,@"fileUrl":url,@"action":@"send",@"sort":@"offline",@"timeLong":@(time.intValue),@"fileType":MessageTypeVoice,@"code":@"utf8",@"msgSubType":@"imMsg"}];
            
            [[FileSocket shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_SEND_FILE objecte:self call:@selector(finishUpLoad:)];
            
            // 模拟
            //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@1,@"success":@0,@"failed":@0,@"data":recordModel,@"dataClass":recordModel.class} afterDelay:0];
            //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@0,@"success":@1,@"failed":@0,@"data":recordModel,@"dataClass":recordModel.class} afterDelay:2];
            
        }else if ([eventName isEqualToString:@"SChatCellResendMessageEvent"]) {
            // 重新发送
            
            // 模拟
            //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@1,@"success":@0,@"failed":@0,@"data":userInfo[@"data"],@"dataClass":userInfo[@"dataClass"]} afterDelay:0];
            //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@0,@"success":@1,@"failed":@0,@"data":userInfo[@"data"],@"dataClass":userInfo[@"dataClass"]} afterDelay:2];
            
        }else if ([eventName isEqualToString:@"SChatStopReplayRecordEvent"]) {
            // 关闭所有语音播放
            for (int i=0; i<_dataArr.count; i++) {
                id cell = [self.chatTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                if ([cell isKindOfClass:[ChatRecordCell class]]) {
                    [(ChatRecordCell *)cell stopReplayRecord];
                }
            }
        }

        return;
    }else{
        
        if ([eventName isEqualToString:@"SChatToolBarInputViewItemEvent"]) {
            // 点击‘+’之后，弹出选择视图的触发事件
            NSInteger index = [userInfo[@"itemIndex"] floatValue];
            NSInteger buttonIndex = index;
            if (index == 0) {
                // 发送图片
                UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                              initWithTitle:nil
                                              delegate:self
                                              cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照", @"相册",nil];
                actionSheet.tag = 1;
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];

                
                
                return;
            }else if (index == 1){
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                              initWithTitle:nil
                                              delegate:self
                                              cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                              otherButtonTitles:@"视频", @"语音",nil];
                actionSheet.tag = 2;
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];
                
                
            }else if (index == 2){
                
                NSLog(@"==============%@",@"发红包了");
                
            }else{
                NSLog(@"==============%@",@"转账");
            }
        }else if ([eventName isEqualToString:@"SChatToolBarSendTextEvent"]) {
            // 发送文字
            NSString * text = userInfo[@"text"];
            ChatTextModel * textModel = [ChatTextModel new];
            textModel.sendText = text;
            textModel.isSender = 1;
            [_dataArr addObject:textModel];
            
            MessageObject *mode = [[MessageObject alloc] init];
            mode.keyfromTo = self.personDic.fid;
            mode.msg = text;
            mode.fromID = [[SocketOprationData shareInit] loginInfo][NODE_SESSION_ID];
            mode.toId = self.personDic.fid;
            mode.userName = [[SocketOprationData shareInit] loginInfo][NODE_USER_NAME];
            mode.toUsername = self.personDic.nickname;
            mode.meetingId = @([self.personDic.fid intValue]);
            mode.time = [SaveDataUtil getNowTimeStamp];
            mode.msgType = @(MSGTYPE_Person);
            [[CoreDataTool shareData] insertModel:[NSArray arrayWithObject:mode] KeyID:mode.keyfromTo];

            //[self.chatTable insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_dataArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
            [self.chatTable reloadData];
            
            
            
            [self scrrollToEnd];
            [self layoutAfterInsertRow];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{NODE_TO_ID:self.personDic.fid,NODE_TOUSERNAME:self.personDic.nickname,NODE_MSG:text,@"code":@"utf8",@"msgSubType":@"imMsg"}];
            [[SocketOprationData shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_SEND_MSG objecte:self call:@selector(sendFinish:)];
            
            // 模拟
            //[self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@1,@"success":@0,@"failed":@0,@"data":textModel,@"dataClass":textModel.class} afterDelay:0];
            
        }else if ([eventName isEqualToString:@"SChatToolBarRecordDidFinishEvent"]) {
            // 发送语音
            NSString * url = userInfo[@"recordUrl"];
            NSNumber * time = userInfo[@"recordTime"];
            
            ChatRecordModel * recordModel = [ChatRecordModel new];
            recordModel.sendUrl = url;
            recordModel.timeLength = time.floatValue;
            recordModel.isSender = 1;
            [_dataArr addObject:recordModel];
            [self.chatTable insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_dataArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
            [self scrrollToEnd];
            [self layoutAfterInsertRow];
            
           // NSData *data = [[NSData alloc] initWithContentsOfFile:url options:NSDataReadingMappedIfSafe error:nil];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{NODE_TO_ID:self.personDic.fid,@"fileUrl":url,@"action":@"send",@"sort":@"offline",@"timeLong":@(time.intValue),@"fileType":MessageTypeVoice,@"code":@"utf8",@"msgSubType":@"imMsg"}];
            
            [[FileSocket shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_SEND_FILE objecte:self call:@selector(finishUpLoad:)];
            
            // 模拟
    //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@1,@"success":@0,@"failed":@0,@"data":recordModel,@"dataClass":recordModel.class} afterDelay:0];
    //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@0,@"success":@1,@"failed":@0,@"data":recordModel,@"dataClass":recordModel.class} afterDelay:2];
            
        }else if ([eventName isEqualToString:@"SChatCellResendMessageEvent"]) {
            // 重新发送
            
            // 模拟
    //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@1,@"success":@0,@"failed":@0,@"data":userInfo[@"data"],@"dataClass":userInfo[@"dataClass"]} afterDelay:0];
    //        [self performSelector:@selector(sendNetworkMessage:) withObject:@{@"start":@0,@"success":@1,@"failed":@0,@"data":userInfo[@"data"],@"dataClass":userInfo[@"dataClass"]} afterDelay:2];
            
        }else if ([eventName isEqualToString:@"SChatStopReplayRecordEvent"]) {
            // 关闭所有语音播放
            for (int i=0; i<_dataArr.count; i++) {
                id cell = [self.chatTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                if ([cell isKindOfClass:[ChatRecordCell class]]) {
                    [(ChatRecordCell *)cell stopReplayRecord];
                }
            }
        }

    }
}
// 模拟联网发送消息
- (void)sendNetworkMessage:(NSDictionary *)dic {
//    ChatBaseCell * cell = nil;
    if ([dic[@"start"] boolValue]) {
        // 开始发送
        if ([dic[@"data"] isKindOfClass:[ChatBaseModel class]]) {
            [(ChatBaseModel *)dic[@"data"] setStart:YES];
            [(ChatBaseModel *)dic[@"data"] setSuccess:NO];
            [(ChatBaseModel *)dic[@"data"] setFailed:NO];
        }
    }else if ([dic[@"success"] boolValue]) {
        // 成功
        if ([dic[@"data"] isKindOfClass:[ChatBaseModel class]]) {
            [(ChatBaseModel *)dic[@"data"] setStart:NO];
            [(ChatBaseModel *)dic[@"data"] setSuccess:YES];
            [(ChatBaseModel *)dic[@"data"] setFailed:NO];
        }
    }else if ([dic[@"failed"] boolValue]) {
        // 失败
        if ([dic[@"data"] isKindOfClass:[ChatBaseModel class]]) {
            [(ChatBaseModel *)dic[@"data"] setStart:NO];
            [(ChatBaseModel *)dic[@"data"] setSuccess:NO];
            [(ChatBaseModel *)dic[@"data"] setFailed:YES];
            [(ChatBaseModel *)dic[@"data"] setResendData:dic];
        }
    }
    
    NSInteger row = [_dataArr indexOfObject:dic[@"data"]];
    ChatBaseCell * cell = [self.chatTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    [cell layoutWarningViewWithDict:dic];
}

#pragma mark getter
- (UITableView *)chatTable {
    if (!_chatTable) {
        _chatTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationBarH-ToolBarHeight) style:UITableViewStylePlain];
        _chatTable.delegate = self;
        _chatTable.dataSource = self;
        _chatTable.tableFooterView = [UIView new];
        _chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [_chatTable registerClass:[ChatBaseCell class] forCellReuseIdentifier:@"ChatBaseCell"];
        [_chatTable registerClass:[ChatTextCell class] forCellReuseIdentifier:@"ChatTextCell"];
        [_chatTable registerClass:[ChatImageCell class] forCellReuseIdentifier:@"ChatImageCell"];
        [_chatTable registerClass:[ChatRecordCell class] forCellReuseIdentifier:@"ChatRecordCell"];
    }
    return _chatTable;
}
- (SChatToolBar *)chatToolBar {
    if (!_chatToolBar) {
        _chatToolBar = [SChatToolBar new];
        _chatToolBar.frame = CGRectMake(0, ScreenHeight-NavigationBarH-ToolBarHeight, ScreenWidth, ToolBarHeight);
    }
    return _chatToolBar;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ 销毁了",self.class);
}

@end
