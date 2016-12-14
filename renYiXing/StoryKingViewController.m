//
//  StoryKingViewController.m
//  柴火圈
//
//  Created by JOYSW on 16/7/13.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "StoryKingViewController.h"
#import "StoryKingModel.h"
#import "StoryKingCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "AddStoryController.h"

@interface StoryKingViewController()<UITableViewDataSource,UITableViewDelegate>

@end

static NSString *cellIndentifier = @"cell";
@implementation StoryKingViewController
{
    NSMutableArray *_modelArray;
    UITableView *_storyTableView;
    
}

-(void)setModel
{
    _modelArray = [NSMutableArray array];
    for (int i = 1; i < 7; i++)
    {
        StoryKingModel *model = [[StoryKingModel alloc]init];
        model.headerImageName = [NSString stringWithFormat:@"%d",i];
        model.userName = [NSString stringWithFormat:@"张三%d",i];
        model.StoryContent = @"我大松附件司法解释紧i 机构打击够ID结构地方机构ID负疚感哦定地方机构迪佛个举动风格我大松附件司法解释紧i 机构打击够ID结构地方机构ID负疚感哦定地方机构迪佛个举动风格我大松附件司法解释紧i 机构打击够ID结构地方机构ID负疚感哦定地方机构迪佛个举动风格我大松";
        model.good = [NSString stringWithFormat:@"%d",100+i];
        model.discus = [NSString stringWithFormat:@"%d",1000+i];
        model.share = [NSString stringWithFormat:@"%d",1234+i];
        [_modelArray addObject:model];
    }
}


-(void)viewDidLoad
{
//    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"段子王";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
    
    
    UIImage  *image1 =[[UIImage imageNamed:@"tianjia3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self setModel];
    
    _storyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _storyTableView.delegate = self;
    _storyTableView.dataSource = self;
    [_storyTableView registerClass:[StoryKingCell class] forCellReuseIdentifier:cellIndentifier];
    _storyTableView.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    [self.view addSubview:_storyTableView];
    
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryKingModel *model = _modelArray[indexPath.row];
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
//    return [_storyTableView cellHeightForIndexPath:indexPath model:model.StoryContent keyPath:@"model" cellClass:[StoryKingCell class] contentViewWidth:[self cellContentViewWith]];
    return [_storyTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[StoryKingCell class] contentViewWidth:[self cellContentViewWith]];
//    return 200;
}


- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryKingModel *model = _modelArray[indexPath.row];
    
    StoryKingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[StoryKingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.model = model;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)rightBarButtonAction
{
    NSLog(@"123");
    AddStoryController *addVc = [[AddStoryController alloc]init];
    [self.navigationController pushViewController:addVc animated:NO];
}

@end
