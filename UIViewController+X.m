//
//  UIViewController+X.m
//  RenYiXing
//
//  Created by 姬荣康 on 2016/11/29.
//  Copyright © 2016年 姬荣康. All rights reserved.
//

#import "UIViewController+X.h"

@implementation UIViewController (X)



/**
 * 通过照相机获取一张图片
 */
- (void)openCamera {
    
    
    /**
     *  UIImagePickerControllerSourceType
     *
     *  SourceType pickerController 的类型
     *  UIImagePickerControllerSourceTypePhotoLibrary,     从 所有 相册中选择
     *  UIImagePickerControllerSourceTypeCamera,           弹出照相机
     *  UIImagePickerControllerSourceTypeSavedPhotosAlbum  从 moment 相册中选择
     */
    
    BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    if (isCameraSupport) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        [AppHelper toastMessage:@{@"message":@"模拟器就别闹了"}];
    }
    
    
    
}

/**
 * 打开用户相册 获取一张图片
 */
- (void)openAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    /**
     *  UIImagePickerControllerSourceType
     *
     *  SourceType pickerController 的类型
     *  UIImagePickerControllerSourceTypePhotoLibrary,     从 所有 相册中选择
     *  UIImagePickerControllerSourceTypeCamera,           弹出照相机
     *  UIImagePickerControllerSourceTypeSavedPhotosAlbum  从 moment 相册中选择
     */
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing =YES;
    [self presentViewController:picker animated:YES completion:nil];
}


/**
 *  弹出验证码界面
 *
 *  @param action <#action description#>
 */
- (void)verifyWithAction:(SEL)action {
    
    /*
     @property (nonatomic, strong) UIView *bgView;
     @property (nonatomic, strong) UIView *kuang;
     @property (nonatomic, strong) UIImageView *code;
     @property (nonatomic, strong) UITextField *edit;
     @property (nonatomic, strong) UIButton *cancel;
     @property (nonatomic, strong) UIButton *commit;
     */
    
    CGFloat width = self.view.bounds.size.width-60;
    
    UIView *bgView = [[UIView alloc] initWithFrame:ApplicationDelegate.window.bounds];
    bgView.tag = 8088;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    [self.view addSubview:bgView];
    
    
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap2];
    
    
    
    
    UIView *kuang = [[UIView alloc] init];
    kuang.center = CGPointMake(bgView.centerX, bgView.centerY - 64);
    kuang.bounds = CGRectMake(0, 0, width, 160);
    kuang.layer.cornerRadius = 15;
    kuang.backgroundColor = [UIColor colorWithRed:0.18f green:0.20f blue:0.22f alpha:1.00f];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, width - 80, 40)];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"提示";
    titleLab.font = [UIFont systemFontOfSize:15];
    [kuang addSubview:titleLab];
    
    
    
    
    
    UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, width, 80)];
    msgView.backgroundColor = [UIColor colorWithRed:0.23f green:0.25f blue:0.27f alpha:1.00f];
    [kuang addSubview:msgView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 0.5)];
    lineView1.backgroundColor = [UIColor blackColor];
    [msgView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 79.5, width, 0.5)];
    lineView2.backgroundColor = [UIColor blackColor];
    [msgView addSubview:lineView2];
    
    UILabel *msgLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, width - 40, 40)];
    msgLab.textColor = [UIColor whiteColor];
    msgLab.text = @"圈主设置了权限，需申请才能加入";
    msgLab.font = [UIFont systemFontOfSize:15];
    msgLab.textColor = [UIColor whiteColor];
    [msgView addSubview:msgLab];
    
    
    
    UITextField *edit = [[UITextField alloc] initWithFrame:CGRectMake(15, 43, width - 30, 30)];
    edit.tag = 679;
    edit.textColor = [UIColor whiteColor];
    edit.backgroundColor = [UIColor colorWithRed:0.18f green:0.20f blue:0.22f alpha:1.00f];
    edit.borderStyle = UITextBorderStyleRoundedRect;
    edit.font = [UIFont systemFontOfSize:15];
    [msgView addSubview:edit];
    
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(removeAlertView) forControlEvents:UIControlEventTouchUpInside];
    cancel.frame = CGRectMake(0, 120, width/2, 40);
    cancel.titleLabel.font = [UIFont fontWithName:@"Verdana" size:15];
    [kuang addSubview:cancel];
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    [commit setTitle:@"确定" forState:UIControlStateNormal];
    commit.titleLabel.font = [UIFont systemFontOfSize:15];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commit addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    commit.frame = CGRectMake(width/2, 120, width/2, 40);
    commit.titleLabel.font = [UIFont fontWithName:@"Verdana" size:15];
    [kuang addSubview:commit];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(width/2, 120, 0.5, 40)];
    line.backgroundColor = [UIColor blackColor];
    [kuang addSubview:line];
    
    
    
    [bgView addSubview:kuang];
}

- (void)hidden {
    [self.view endEditing:YES];
}

- (void)removeAlertView {
    UIView *view = [self.view viewWithTag:8088];
    [view removeFromSuperview];
}


- (CGSize)labSizeWithString:(NSString *)str withFont:(int)font withLabWidth:(CGFloat)labW{
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(labW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size;
    
}




@end
