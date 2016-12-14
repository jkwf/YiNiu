//
//  SChatToolBar.m
//  SChatUI
//
//  Created by tongxuan on 16/7/28.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "SChatToolBar.h"
#import "SChatToolBarInputView.h"
#import "STextField.h"
#import "UIResponder+Router.h"
#import "SChatRecordHandle.h"
#import "Masonry.h"


#define Wself                           __weak typeof(self) wself = self;
#define Sself                           __strong typeof(wself) sself = wself;
#define ScreenWidth                     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight                    [UIScreen mainScreen].bounds.size.height

@interface SChatToolBar ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton * voiceBtn;
@property (nonatomic,strong) UIButton * addBtn;
@property (nonatomic,strong) UIButton *emojiBtn;
@property (nonatomic,strong) SChatToolBarInputView * chatInputView;

/**
 *  放置在输入框上的按钮(录音时候放置)
 */
@property (nonatomic,strong) UIButton * recordBtn;
@property (nonatomic,strong) SChatRecordHandle * recordHandle;
@end

@implementation SChatToolBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return  self;
}

#pragma mark loadUI
- (void)loadUI {
    Wself
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputViewItemDidChoose) name:@"kInputViewItemDidChoose" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputViewDidFinishRecord:) name:@"kInputViewDidFinishRecord" object:nil];
    
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:ToolBarBGColorImg]];
    [self addSubview:self.voiceBtn];
    [self addSubview:self.inputTF];
    [self addSubview:self.addBtn];
    [self addSubview:self.emojiBtn];
    
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(wself).offset(ToolBarLeftSpace);
        make.bottom.equalTo(wself).offset(-ToolBarLeftSpace);
        make.width.height.mas_equalTo(ToolBarHeight-ToolBarTopSpace).priority(300);
    }];
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.equalTo(wself.addBtn);
        make.left.equalTo(self.addBtn.mas_right);
        
    }];
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(wself.addBtn);
        make.left.equalTo(wself.emojiBtn.mas_right).offset(ToolBarLeftBtnRightSpace);
    }];
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.equalTo(wself.addBtn);
        make.right.equalTo(wself).offset(-ToolBarLeftSpace);
        make.left.equalTo(wself.inputTF.mas_right).offset(ToolBarRightBtnLeftSpace);
    }];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text && textField.text.length>0) {
        [self routerEventWithName:@"SChatToolBarSendTextEvent" userInfo:@{@"text":textField.text}];
        textField.text = @"";
    }
    return YES;
}

#pragma mark action
- (void)observeChatText:(UITextField *)sender {
    
    // 弹出选择项时，输入无效
    if (self.addBtn.selected) {
        sender.text = @"";
    }
}
// 右边按钮事件
- (void)addBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.inputTF.inputView = self.chatInputView;
    }else {
        self.inputTF.inputView = nil;
    }
    [self.inputTF reloadInputViews];
    [self.inputTF becomeFirstResponder];
}

// 左边按钮事件 (录音)
- (void)voiceBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;

    if (sender.selected) {
        self.recordBtn.frame = self.inputTF.frame;
        [self addSubview:self.recordBtn];
    }else {
        [self.recordBtn removeFromSuperview];
    }
}

- (void)inputViewItemDidChoose {
    [self.inputTF resignFirstResponder];
}

/**
 *  完成录音
 */
- (void)inputViewDidFinishRecord:(NSNotification *)sender {
    [self voiceBtnClick:self.voiceBtn];
    [self routerEventWithName:@"SChatToolBarRecordDidFinishEvent" userInfo:sender.object];
}

/**
 *  取消录音
 */
- (void)cancelRecord:(UIButton *)sender {
    [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
    [_recordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    [self.recordHandle cancelRecord];
}

/**
 *  开始录音
 */
- (void)startRecord:(UIButton *)sender {
    [_recordBtn setTitle:@"向上滑动，取消录音" forState:UIControlStateNormal];
    [_recordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    self.recordHandle = [SChatRecordHandle new];
    [self.recordHandle startRecord];
}

- (void)stopRecord:(UIButton *)sender {
    [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
    [_recordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self.recordHandle stopRecord];
}

#pragma mark getter
- (UIButton *)voiceBtn {
    if (!_voiceBtn) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceBtn setImage:[UIImage imageNamed:ToolBarLeftBtnNorImg] forState:UIControlStateNormal];
        [_voiceBtn setImage:[UIImage imageNamed:ToolBarLeftBtnHLightImg] forState:UIControlStateHighlighted];
        [_voiceBtn setImage:[UIImage imageNamed:TollBarLeftBtnSelImg] forState:UIControlStateSelected];
        _voiceBtn.selected = NO;
        [_voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceBtn;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:ToolBarRightBtnNorImg] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:ToolBarRightBtnHLightImg] forState:UIControlStateHighlighted];
        [_addBtn setImage:[UIImage imageNamed:ToolBarRightBtnSelImg] forState:UIControlStateSelected];
        _addBtn.selected = NO;
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (UIButton*)emojiBtn{
    if (!_emojiBtn) {
        _emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojiBtn setImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
        
        [_emojiBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiBtn;
}


- (STextField *)inputTF {
    if (!_inputTF) {
        _inputTF = [STextField new];
        _inputTF.placeholder = ToolBarInputViewPlaceHolder;
//        [_inputTF setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
//        [_inputTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//        // 左边站位图
//        _inputTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _inputTF.frame.size.height)];
//        _inputTF.leftViewMode = UITextFieldViewModeAlways;
        
        UIImage * tempImage = [UIImage imageNamed:ToolBarInputViewBGImg];
        tempImage = [tempImage resizableImageWithCapInsets:UIEdgeInsetsMake(40, 10, 10, 40) resizingMode:UIImageResizingModeStretch];
        _inputTF.background = tempImage;
        _inputTF.returnKeyType = UIReturnKeySend;
        _inputTF.delegate = self;
        [_inputTF addTarget:self action:@selector(observeChatText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTF;
}
- (SChatToolBarInputView *)chatInputView {
    if (!_chatInputView) {
        _chatInputView = [SChatToolBarInputView new];
        _chatInputView.backgroundColor = RGBACOLOR(0x2D, 0x32, 0x35, 1);
        SChatToolBarInputSingleItem * item = [SChatToolBarInputSingleItem new];
        item.icon = @"images";
        item.title = @"照片";
        
        SChatToolBarInputSingleItem * item1 = [SChatToolBarInputSingleItem new];
        item1.icon = @"video";
        item1.title = @"视频";
        
        SChatToolBarInputSingleItem * item2 = [SChatToolBarInputSingleItem new];
        item2.icon = @"wallet";
        item2.title = @"红包";
        
        SChatToolBarInputSingleItem * item3 = [SChatToolBarInputSingleItem new];
        item3.icon = @"trac";
        item3.title = @"转账";

        _chatInputView.allItems = @[item,item1,item2,item3];
    }
    return _chatInputView;
}
- (UIButton *)recordBtn {
    if (!_recordBtn) {
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordBtn.backgroundColor = [UIColor whiteColor];
        [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        [_recordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _recordBtn.titleLabel.font = [UIFont systemFontOfSize:15.];
        _recordBtn.layer.cornerRadius = 5;
        
        [_recordBtn addTarget:self action:@selector(cancelRecord:) forControlEvents:UIControlEventTouchUpOutside];
        [_recordBtn addTarget:self action:@selector(startRecord:) forControlEvents:UIControlEventTouchDown];
        [_recordBtn addTarget:self action:@selector(stopRecord:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recordBtn;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@ 销毁了",self.class);
}

@end
