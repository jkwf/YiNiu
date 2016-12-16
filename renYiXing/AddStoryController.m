//
//  AddStoryController.m
//  柴火圈
//
//  Created by JOYSW on 16/8/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "AddStoryController.h"
#import "UIView+SDAutoLayout.h"
#import "CXXChooseImageViewController.h"
#import "UITextView+WZB.h"  
@interface AddStoryController ()<UITextViewDelegate,CXXChooseImageViewControllerDelegate>

@property(nonatomic,strong)CXXChooseImageViewController *chooseImageVC;

@property(nonatomic,strong)UITextView *textView;

@end

@implementation AddStoryController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"发布段子";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;

    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction)];
    rightBarButton.tintColor = [UIColor whiteColor];
    
//    调整textview的光标位置
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.navigationItem.rightBarButtonItem = rightBarButton;

    [self textView];
    
    CXXChooseImageViewController *imageVC=[[CXXChooseImageViewController alloc]init];
    imageVC.delegate=self;
    self.chooseImageVC=imageVC;
    [self addChildViewController:imageVC];
    
    [imageVC setOrigin:CGPointMake(0, _textView.height+64) ItemSize:CGSizeMake(self.view.width*0.21,self.view.height*0.11) rowCount:4];
    
    [self.view addSubview:imageVC.view];
    
    imageVC.maxImageCount=9;
    
}

-(UITextView*)textView{

    if (!_textView)
    {
        _textView =[[UITextView alloc]initWithFrame:CGRectMake(0,64, self.view.width, 200)];
        _textView.placeholder=@"内容（必填)";
        _textView.placeholderColor=[UIColor blackColor];
        [self.view addSubview:_textView];
        
    }
    
    return _textView;
}


- (void)chooseImageViewControllerDidChangeCollectionViewHeigh:(CGFloat)height{
    
    self.chooseImageVC.view.frame =  CGRectMake(0, 200, [[UIScreen mainScreen] bounds].size.width, height);
    
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark --- 发布 ----
-(void)rightBarButtonAction
{
  
    if ([_textView.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
        return;
    }
    [_textView resignFirstResponder];//收起键盘
    [SVProgressHUD showWithStatus:@"正在发布"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [WebShareData uploadImageWithParams:@{@"userid":LoginUserId,@"content":_textView.text} withImageArray: _chooseImageVC.dataArr withUrlStr:getAPIURL(@"mod=interface&ac=circle") withSuccessBlock:^(NSDictionary *dicInfo) {
        NSLog(@"%@",dicInfo);
        if ([[dicInfo objectForKey:@"result"]integerValue]==1)
        {
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
            [SVProgressHUD dismissWithDelay:2.0 completion:^{
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
        }
        
        
    } withFailBlock:^(NSError *error) {
        
        NSLog(@"----error：%@",error);
    }];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
}

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
