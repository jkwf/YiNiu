//
//  AddStoryController.m
//  柴火圈
//
//  Created by JOYSW on 16/8/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "AddStoryController.h"
#import "UIView+SDAutoLayout.h"

@interface AddStoryController ()<UITextViewDelegate>

@end

@implementation AddStoryController
{
    UITextView *_contentView;
    UILabel *_placeholderLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"发布段子";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    UILabel *tempLabel = [[UILabel alloc]init];
//    tempLabel.text = @"发布";
//    tempLabel.textColor = [UIColor whiteColor];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonAction)];
    rightBarButton.tintColor = [UIColor whiteColor];
    
//    调整textview的光标位置
    self.automaticallyAdjustsScrollViewInsets = false;
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    
    UITextView *contentView = [UITextView new];
//    contentView.backgroundColor = [UIColor greenColor];
    _contentView = contentView;
    _contentView.delegate = self;
    [backView addSubview:_contentView];
    
    UILabel *templabel = [UILabel new];
    templabel.text = @"内容（必填）";
    templabel.textColor = [UIColor grayColor];
    templabel.font = [UIFont systemFontOfSize:14];
    _placeholderLabel = templabel;
    [_contentView addSubview:_placeholderLabel];
    
    UIImageView *addImageView = [UIImageView new];
    [addImageView setImage:[UIImage imageNamed:@"zhuanfa"]];
//    addImageView.backgroundColor = [UIColor redColor];
    [backView addSubview:addImageView];
    
    [self.view sd_addSubviews:@[backView]];
    
    
    backView.sd_layout
    .topSpaceToView(self.view,64)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(self.view.bounds.size.height/2);
    
    _contentView.sd_layout
    .leftSpaceToView(backView,10)
    .rightSpaceToView(backView,10)
    .topSpaceToView(backView,10)
    .bottomSpaceToView(backView,15+self.view.bounds.size.height/9);
    
    _placeholderLabel.sd_layout
    .leftSpaceToView(_contentView,5)
    .topSpaceToView(_contentView,5)
    .rightSpaceToView(_contentView,5)
    .heightIs(15);
    
    addImageView.sd_layout
    .leftSpaceToView(backView,15)
    .topSpaceToView(_contentView,5)
    .heightIs(self.view.bounds.size.height/9)
    .widthIs(self.view.bounds.size.height/9);
    
    
    
    
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    // Do any additional setup after loading the view.
}


-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}


-(void)rightBarButtonAction
{
    NSLog(@"fabu");
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeholderLabel.text = @"内容（必填）";
    }else{
        _placeholderLabel.text = @"";
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_contentView resignFirstResponder];
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
