//
//  HeadImageViewController.m
//  easyTrader
//
//  Created by JOYSW on 16/7/8.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "HeadImageViewController.h"
#import "Header.h"
#import "PersonalViewController.h"
@interface HeadImageViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation HeadImageViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"个人资料";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    rightBarButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    self.headImageView = [[UIImageView alloc]init];
       self.headImageView.image=[UIImage imageWithData:fetchFile];
    if (!self.headImageView.image)
    {
        self.headImageView.image=[UIImage imageNamed:@"changehead"];
    }
    self.headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.headImageView];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setTitle:@"相机" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    photoBtn.backgroundColor = [UIColor colorWithRed:66/255.0 green:129/255.0 blue:63/255.0 alpha:1.0];
    photoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    photoBtn.layer.cornerRadius = self.view.bounds.size.width/22;
    photoBtn.tag = 100;
    [self.view addSubview:photoBtn];
    
    [photoBtn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *photoImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoImageBtn setTitle:@"从相册选一张" forState:UIControlStateNormal];
    [photoImageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    photoImageBtn.backgroundColor = [UIColor colorWithRed:97/255.0 green:181/255.0 blue:210/255.0 alpha:1.0];
    photoImageBtn.translatesAutoresizingMaskIntoConstraints = NO;
    photoImageBtn.layer.cornerRadius = self.view.bounds.size.width/22;
    photoImageBtn.tag =101;
    [self.view addSubview:photoImageBtn];
    [photoImageBtn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(self.view.bounds.size.width/3);
        make.right.equalTo(self.view.mas_right).offset(-self.view.bounds.size.width/3);
        make.top.equalTo(self.view.mas_top).offset(64+self.view.bounds.size.width/5);
        make.height.mas_equalTo(self.view.bounds.size.width/3);
    }];
    
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(self.view.bounds.size.width/5);
        make.right.equalTo(self.view.mas_right).offset(-self.view.bounds.size.width/5);
        make.top.equalTo(self.headImageView.mas_bottom).offset(self.view.bounds.size.width/5);
        make.height.mas_equalTo(self.view.bounds.size.width/13);
    }];
    
    [photoImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(self.view.bounds.size.width/5);
        make.right.equalTo(self.view.mas_right).offset(-self.view.bounds.size.width/5);
        make.top.equalTo(photoBtn.mas_bottom).offset(self.view.bounds.size.width/10);
        make.height.mas_equalTo(self.view.bounds.size.width/11);
    }];
    
 }

-(void)photoAction:(UIButton *)btn
{
    if (btn.tag == 101)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing= YES;//是否可以编辑
            
            //            picker.view.frame = CGRectMake(0, 0, 100, 100);
            //打开相册选择照片
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 模态进入相册
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    else if(btn.tag == 100)
    {
        // 如果有系统相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            //            picker.view.frame = CGRectMake(0, 0, 100, 100);
            //摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
        //如果没有系统相机提示用户
        else
        {
            //            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"您的设备没有摄像头" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //            [alertView show];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
            }];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }

}


#pragma mark - 拍摄完成后或者选择相册完成后自动调用的方法 -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image= [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    self.headImageView.image = image;
   // 模态返回
    [self dismissViewControllerAnimated:YES completion:nil];


}



-(void)saveAction{
    
    [WebShareData uploadImg:self.headImageView.image withImgName:@"picture" withFileName:@"userHeader.png" withParams:@{@"userid":LoginUserId} withUrlStr:getAPIURL(@"mod=interface&ac=modifiedpic") withSuccessBlock:^(NSDictionary *dicInfo) {
        
        if ([dicInfo[@"result"] intValue] == 1) {
            [AppHelper toastMessage:@{@"message":@"上传成功"}];
            
            [WebShareData uploadImg:self.headImageView.image withImgName:@"picture" withFileName:@"userHeader.png" withParams:@{@"userid":LoginUserId} withUrlStr:getCircleAPIURL(@"mod=index&ac=modifiedpic") withSuccessBlock:^(NSDictionary *dicInfo) {
                if ([dicInfo[@"result"] intValue] == 1) {
                    
                    NSData *data=UIImagePNGRepresentation(self.headImageView.image);
                    saveFile(data);//图片存储
                    SetSynchronize;
                    [AppHelper toastMessage:@{@"message":@"上传成功"}];
                    if (_headerImageBlock)
                    {
                        _headerImageBlock(self.headImageView.image);
                    }
                    
                    
                }else{
                    [AppHelper toastMessage:@{@"message":@"提交失败，请重试"}];
                }
            } withFailBlock:^(NSError *error) {
                [AppHelper toastMessage:@{@"message":@"提交失败，请重试"}];
            }];
        }else{
            [AppHelper toastMessage:@{@"message":@"提交失败，请重试"}];
        }

    } withFailBlock:^(NSError *error) {
        [AppHelper toastMessage:@{@"message":@"提交失败，请重试"}];
    }];
    
    
    
}

#pragma mark 保存图片到document

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 0.5);

    [imageData writeToFile:[self headerImgFilePathWithImgName] atomically:NO];
    
}

#pragma mark 头像地址
- (NSString *)headerImgFilePathWithImgName{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"userHeader.png"];
    
//    NSLog(@"------=========%@",fullPathToFile);
    
    return fullPathToFile;
}

#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}


@end
