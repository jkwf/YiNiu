//
//  BodyCardImageViewController.m
//  easyTrader
//
//  Created by 朱佳伟 on 16/7/5.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "BodyCardImageViewController.h"
#import "Header.h"

@interface BodyCardImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic , strong)UIImageView *bodyImageView;
@property(nonatomic , strong)UIView *bottomView;
@end

@implementation BodyCardImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"手持身份证照片";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    self.bodyImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bodyImage"]];
    self.bodyImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bodyImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bodyImageView];
    
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapAction:)];
    [self.bodyImageView addGestureRecognizer:imageTap];
    
    UILabel *firstLabel = [[UILabel alloc]init];
//    firstLabel.backgroundColor = [UIColor redColor];
    firstLabel.textColor = [UIColor grayColor];
    firstLabel.font = [UIFont systemFontOfSize:18];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.text = @"请上传手持身份证照片如样图";
    firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:firstLabel];
    
    UILabel *secondlabel = [[UILabel alloc]init];
    secondlabel.textColor = [UIColor grayColor];
    secondlabel.font = [UIFont systemFontOfSize:18];
    secondlabel.textAlignment = NSTextAlignmentCenter;
    secondlabel.text = @"请保证身份证正面清晰可确认";
    secondlabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:secondlabel];
    
    UILabel *thirdlabel = [[UILabel alloc]init];
    thirdlabel.textColor = [UIColor grayColor];
    thirdlabel.font = [UIFont systemFontOfSize:18];
    thirdlabel.textAlignment = NSTextAlignmentCenter;
    thirdlabel.text = @"请保证露出您的手臂";
    thirdlabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:thirdlabel];
    
    
    [self.bodyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(self.view.bounds.size.width/6);
        make.right.equalTo(self.view.mas_right).offset(-self.view.bounds.size.width/6);
        make.top.equalTo(self.view.mas_top).offset(self.view.bounds.size.width/6+64);
        make.height.mas_equalTo(self.view.bounds.size.width/2);
    }];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.bodyImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(self.view.bounds.size.height/25);
    }];
    
    [secondlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(firstLabel.mas_bottom);
        make.height.mas_equalTo(self.view.bounds.size.height/25);
    }];
    
    [thirdlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(secondlabel.mas_bottom);
        make.height.mas_equalTo(self.view.bounds.size.height/25);
    }];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [submitBtn setFrame:CGRectMake(0, 0, 100, 30)];
    submitBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:179/255.0  blue:214/255.0  alpha:1.0];
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [submitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
//    submitBtn.font = [UIFont systemFontOfSize:12];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bodyImageView.mas_left);
        make.right.equalTo(self.bodyImageView.mas_right);
        make.top.equalTo(thirdlabel.mas_bottom).offset(self.view.bounds.size.width/6);
        make.height.mas_equalTo(self.view.bounds.size.height/13);
    }];
    
    UILabel *forthLabel = [[UILabel alloc]init];
    forthLabel.text = @"您的信息仅用于认证，不对他人公开";
    forthLabel.textColor = [UIColor grayColor];
    forthLabel.font = [UIFont systemFontOfSize:14];
    forthLabel.textAlignment = NSTextAlignmentCenter;
    forthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:forthLabel];
    
    [forthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(submitBtn.mas_bottom).offset(5);
        make.height.mas_equalTo(firstLabel.mas_height);
    }];
    
    
    //    相机相册弹出视图
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/4)];
    //    self.bottomView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0  blue:250 / 255.0 alpha:0.5];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    //    边框效果：
    [self.bottomView.layer setMasksToBounds:YES];//设置边框可见
    //    self.bottomView.layer.borderColor = [[UIColor blackColor] CGColor];
    //    [self.bottomView.layer setBorderWidth:0.8];
    //    阴影层：
    self.bottomView.layer.shadowOffset = CGSizeMake(0, 3);
    self.bottomView.layer.shadowRadius = 5.0;
    self.bottomView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bottomView.layer.shadowOpacity = 0.8;
    
    //    相册按钮
    UIButton *imageLibraryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    imageLibraryBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [imageLibraryBtn setTitle:@"相册" forState:UIControlStateNormal];
    imageLibraryBtn.tag = 100;
    imageLibraryBtn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [imageLibraryBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside ];
    
//    UILabel *photoLabel = [[UILabel alloc]init];
//    photoLabel.textAlignment = NSTextAlignmentCenter;
//    photoLabel.textColor = [UIColor orangeColor];
//    photoLabel.text = @"相册";
//    photoLabel.font = [UIFont systemFontOfSize:15];
//    [imageLibraryBtn addSubview:photoLabel];
    [self.bottomView addSubview:imageLibraryBtn];
    
    //    相机按钮
    UIButton *photoBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    photoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [photoBtn setTitle:@"相机" forState:UIControlStateNormal];
    photoBtn.tag = 101;
    photoBtn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [photoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside ];
    
//    UILabel *cameraLabel = [[UILabel alloc]init];
//    cameraLabel.textAlignment = NSTextAlignmentCenter;
//    cameraLabel.textColor = [UIColor orangeColor];
//    cameraLabel.text = @"相机";
//    cameraLabel.font = [UIFont systemFontOfSize:15];
//    [photoBtn addSubview:cameraLabel];
    [self.bottomView addSubview:photoBtn];
    
    //    取消按钮
    UIButton *cancleBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.tag = 102;
    cancleBtn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [cancleBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside ];
    
//    UILabel *thirdLabel = [[UILabel alloc]init];
//    thirdLabel.textAlignment = NSTextAlignmentCenter;
//    thirdLabel.textColor = [UIColor orangeColor];
//    thirdLabel.text = @"取消";
//    thirdLabel.font = [UIFont systemFontOfSize:15];
//    [cancleBtn addSubview:thirdLabel];
    [self.bottomView addSubview:cancleBtn];
    [self.view addSubview:self.bottomView];

    
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(self.bottomView.mas_top).offset(10);
        make.height.mas_equalTo((self.view.bounds.size.height/4-40)/3);
    }];
    
    [imageLibraryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(photoBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(photoBtn.mas_height);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(imageLibraryBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(photoBtn.mas_height);
    }];
    
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)submitBtnAction:(UIButton *)btn
{
    NSLog(@"133");
}

-(void)imageTapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"1234");
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height/4*3, self.view.bounds.size.width, self.view.bounds.size.height/4);
    }];

}


//  相机相册按钮事件方法
-(void)btnAction:(UIButton *)btn
{
    if (btn.tag == 100)
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
    else if(btn.tag == 101)
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
    else if(btn.tag == 102)
    {
        //        self.choseLabel.userInteractionEnabled = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/3+49);
        }];
        //        self.view.backgroundColor = [UIColor whiteColor];
//        self.shadowView.hidden = YES;
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
     self.bodyImageView.image = image;
    
    // 上传图片压缩方法
//    NSData *imagedata = UIImageJPEGRepresentation(image, 0.1);

    // 模态返回
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/4);
    }];
    
       
 
}

//点击cancel 调用的方法
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    // 模态返回
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [UIView animateWithDuration:0.25 animations:^{
//        self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/4);
//    }];
//}
#pragma mark- 缩放图片
//-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
//{
//    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
//    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
//    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return scaledImage;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
