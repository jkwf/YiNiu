//
//  MyViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/30.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "MyViewController.h"
#import "DiyView.h"
#import "Masonry.h"
#import "Header.h"
#import "MyTableViewCell.h"
#import "HeadImageViewController.h"
@interface MyViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic , strong)DiyView *topView;
@property(nonatomic , strong)DiyView *personalView;
@property(nonatomic , strong)DiyView *myConsumptionView;
@property(nonatomic , strong)DiyView *strategyView;
@property(nonatomic , strong)DiyView *virtualGoldView;
@property(nonatomic , strong)DiyView *renyibiView;
@property(nonatomic , strong)DiyView *mySpaceView;
@property(nonatomic , strong)DiyView *focusOnPeopleView;
@property(nonatomic , strong)DiyView *myFansView;
@property(nonatomic , strong)DiyView *setUpView;
@property(nonatomic , strong)DiyView *recommandToFirendView;
@property(nonatomic , strong)DiyView *feedbackView;
@property(nonatomic , strong)UITableView *myTableView;
@property(nonatomic , strong)NSArray *nameArray;
@property(nonatomic , strong)NSArray *iconArray;
@end

static NSString *cellIndentifier = @"cell";
@implementation MyViewController
//-(void)viewWillLayoutSubviews
//{
//    [self.personalView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.personalView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.myConsumptionView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.myConsumptionView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.strategyView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.strategyView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.virtualGoldView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.virtualGoldView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.renyibiView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.renyibiView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.mySpaceView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.mySpaceView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.focusOnPeopleView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.focusOnPeopleView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.myFansView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.myFansView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.setUpView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.setUpView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.recommandToFirendView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.recommandToFirendView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//    [self.feedbackView.rightIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo((self.feedbackView.bounds.size.height-self.view.bounds.size.height/36)/2);
//        make.width.mas_equalTo(self.view.bounds.size.height/36);
//        make.height.mas_equalTo(self.view.bounds.size.height/36);
//    }];
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.topView.userNameLabel.text = LoginNickName;
}

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
//    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"我";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
//    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];

    
//    UIImage  *image =[[UIImage imageNamed:@"leftback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.topView = [[DiyView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height/9)];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.headView.image=[UIImage imageWithData:fetchFile];
    if (!self.topView.headView.image)
    {
        [self.topView.headView setImage:[UIImage imageNamed:@"headImage"]];
    }

    [self.view addSubview:self.topView];
  
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(myTapAction:)];
    [self.topView addGestureRecognizer:tap];
    
    
//    tap.view.tag =1001;
    
//    self.personalView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+10, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.personalView.backgroundColor = [UIColor whiteColor];
//    [self.personalView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.personalView.userNameLabel.text = @"个人信息";
//    self.personalView.contentLabel.text = @"编辑";
//    [self.view addSubview:self.personalView];
//    [self.personalView addGestureRecognizer:tap];
//    self.personalView.tag = 101;
//
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
////    tap.view.tag =1002;
//
//    
//    self.myConsumptionView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+10+1+self.view.bounds.size.height/15, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.myConsumptionView.backgroundColor = [UIColor whiteColor];
//    [self.myConsumptionView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.myConsumptionView.userNameLabel.text = @"我的消费";
//    [self.view addSubview:self.myConsumptionView];
//    [self.myConsumptionView addGestureRecognizer:tap2];
//    self.myConsumptionView.tag = 102;
//    
//    
//    self.strategyView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+10+2+self.view.bounds.size.height/15*2, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.strategyView.backgroundColor = [UIColor whiteColor];
//    [self.strategyView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.strategyView.userNameLabel.text = @"策略宝";
//    [self.view addSubview:self.strategyView];
//    self.strategyView.tag = 103;
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.strategyView addGestureRecognizer:tap3];
//    
//    
//    self.virtualGoldView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+10+3+self.view.bounds.size.height/15*3, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.virtualGoldView.backgroundColor = [UIColor whiteColor];
//    [self.virtualGoldView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.virtualGoldView.userNameLabel.text = @"虚拟金";
//    [self.view addSubview:self.virtualGoldView];
//    self.virtualGoldView.tag = 104;
//    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.virtualGoldView addGestureRecognizer:tap4];
//    
//    self.renyibiView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+10+4+self.view.bounds.size.height/15*4, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.renyibiView.backgroundColor = [UIColor whiteColor];
//    [self.renyibiView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.renyibiView.userNameLabel.text = @"任易币";
//    [self.view addSubview:self.renyibiView];
//    self.renyibiView.tag = 105;
//    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.renyibiView addGestureRecognizer:tap5];
//    
//    self.mySpaceView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+20+4+self.view.bounds.size.height/15*5, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.mySpaceView.backgroundColor = [UIColor whiteColor];
//    [self.mySpaceView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.mySpaceView.userNameLabel.text = @"我的空间";
//    [self.view addSubview:self.mySpaceView];
//    self.mySpaceView.tag = 106;
//    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.mySpaceView addGestureRecognizer:tap6];
//    
//    self.focusOnPeopleView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+20+5+self.view.bounds.size.height/15*6, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.focusOnPeopleView.backgroundColor = [UIColor whiteColor];
//    [self.focusOnPeopleView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.focusOnPeopleView.userNameLabel.text = @"关注的人";
//    [self.view addSubview:self.focusOnPeopleView];
//    self.focusOnPeopleView.tag = 107;
//    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.focusOnPeopleView addGestureRecognizer:tap7];
//    
//    self.myFansView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+20+6+self.view.bounds.size.height/15*7, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.myFansView.backgroundColor = [UIColor whiteColor];
//    [self.myFansView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.myFansView.userNameLabel.text = @"我的粉丝";
//    self.myFansView.contentLabel.text = @"68968900";
//    [self.view addSubview:self.myFansView];
//    self.myFansView.tag = 108;
//    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.myFansView addGestureRecognizer:tap8];
//    
//    self.setUpView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+30+6+self.view.bounds.size.height/15*8, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.setUpView.backgroundColor = [UIColor whiteColor];
//    [self.setUpView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.setUpView.userNameLabel.text = @"设置";
//    [self.view addSubview:self.setUpView];
//    self.setUpView.tag = 109;
//    UITapGestureRecognizer *tap9 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.setUpView addGestureRecognizer:tap9];
//    
//    self.recommandToFirendView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+30+7+self.view.bounds.size.height/15*9, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.recommandToFirendView.backgroundColor = [UIColor whiteColor];
//    [self.recommandToFirendView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.recommandToFirendView.userNameLabel.text = @"推荐给好友";
//    [self.view addSubview:self.recommandToFirendView];
//    self.recommandToFirendView.tag = 110;
//    UITapGestureRecognizer *tap10 = [[UITapGestureRecognizer alloc]
//                                    initWithTarget:self action:@selector(myTapAction:)];
//    [self.recommandToFirendView addGestureRecognizer:tap10];
//    
//    self.feedbackView = [[DiyView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+64+30+8+self.view.bounds.size.height/15*10, self.view.bounds.size.width, self.view.bounds.size.height/15)];
//    self.feedbackView.backgroundColor = [UIColor whiteColor];
//    [self.feedbackView.headView setImage:[UIImage imageNamed:@"ren"]];
//    self.feedbackView.userNameLabel.text = @"反馈意见";
//    [self.view addSubview:self.feedbackView];
//    self.feedbackView.tag = 111;
//    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc]
//                                     initWithTarget:self action:@selector(myTapAction:)];
//    [self.feedbackView addGestureRecognizer:tap11];
    self.nameArray = [NSArray arrayWithObjects:@"个人信息",@"我的消费",@"策略宝",@"虚拟金",@"任易币",@"我的空间",@"关注的人",@"我的粉丝",@"设置",@"推荐给好友",@"反馈意见" ,nil];
    self.iconArray = [NSArray arrayWithObjects:@"xixni",@"xiaofei",@"celve",@"xuni",@"jinbi",@"kongjian",@"guanzhu",@"fensi",@"shezhi",@"fenxiang",@"fankui", nil];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+self.view.bounds.size.height/9, self.view.bounds.size.width, self.view.bounds.size.height-(64+self.view.bounds.size.height/9)) style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.bounces = NO;
//    self.myTableView.scrollEnabled = NO;
    //    注册MyTableViewCell类型的cell
    [self.myTableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:cellIndentifier];
    [self.view addSubview:self.myTableView];
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    else
    {
        return 3;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height/15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    先用取出对应model
    //    因为使用哪一种cell 是根据model的性别来决定的
    //    如果性别为男  使用MyTableViewCell类型
   
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0)
    {
        if (indexPath.row==0)
        {
            cell.contentLabel.text = @"编辑";
        }
        cell.nameLabel.text = self.nameArray[indexPath.row];
        NSString *str = self.iconArray[indexPath.row];
        cell.iconImageView.image = [UIImage imageNamed:str];
    
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row == 2)
        {
            cell.contentLabel.text = @"83943344";
        }
        cell.nameLabel.text = self.nameArray[indexPath.row+5];
        NSString *str = self.iconArray[indexPath.row+5];
        cell.iconImageView.image = [UIImage imageNamed:str];
    }
    else
    {
        cell.nameLabel.text = self.nameArray[indexPath.row+8];
        NSString *str = self.iconArray[indexPath.row+8];
        cell.iconImageView.image = [UIImage imageNamed:str];
    }
    
//    NSString *str =self.iconArray[indexPath.row];
//    cell.iconImageView.image = [UIImage imageNamed:str];
        return cell;
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        PersonalViewController *personalVc = [[PersonalViewController alloc]init];
        MyConsumptionViewController *myConsumptionVC = [[MyConsumptionViewController alloc]init];
        StrategyViewController *strategyVc = [[StrategyViewController alloc]init];
        MySpaceViewController *mySpaceVc = [[MySpaceViewController alloc]init];
        RenyibiViewController *renyibiVc = [[RenyibiViewController alloc]init];
        VirtualGoldViewController *virtualGoldVc = [[VirtualGoldViewController alloc]init];
        FocusOnPeopleViewController *focusOnVc = [[FocusOnPeopleViewController alloc]init];
        MyFansViewController *myFansVc = [[MyFansViewController alloc]init];
        SetupViewController *setUpVc = [[SetupViewController alloc]init];
        FeedbackViewController *feedbackVc = [[FeedbackViewController alloc]init];
        RecommandToFriend *recommandTofriendVc = [[RecommandToFriend alloc]init];

        switch (indexPath.section) {
            case 0:
                if (indexPath.row==0)
                {
                    [self.navigationController pushViewController:personalVc animated:NO];
                }
                else if(indexPath.row==1)
                {
                [self.navigationController pushViewController:myConsumptionVC animated:NO ];
                }
                else if(indexPath.row == 2)
                {
                    [self.navigationController pushViewController:strategyVc animated:NO ];
                }
                else if(indexPath.row == 3)
                {
                    [self.navigationController pushViewController:virtualGoldVc animated:NO ];
                }
                else if(indexPath.row == 4)
                {
                    [self.navigationController pushViewController:renyibiVc animated:NO ];
                }
                break;
            case 1:
                if (indexPath.row==0)
                {
                    [self.navigationController pushViewController:mySpaceVc animated:NO ];
                }
                else if(indexPath.row==1)
                {
                    [self.navigationController pushViewController:focusOnVc animated:NO ];
                }
                else if(indexPath.row == 2)
                {
                     [self.navigationController pushViewController:myFansVc animated:NO ];
                }
                break;
            case 2:
                if (indexPath.row==0)
                {
                     [self.navigationController pushViewController:setUpVc animated:NO ];
                }
                else if(indexPath.row==1)
                {
                    [self.navigationController pushViewController:recommandTofriendVc animated:NO ];
                }
                else if(indexPath.row == 2)
                {
                    [self.navigationController pushViewController:feedbackVc animated:NO ];
                }
                break;
            default:
                break;
        }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)myTapAction:(UITapGestureRecognizer *)tap
{
    PersonalDataViewController *personalDataVc = [[PersonalDataViewController alloc]init];
    personalDataVc.UserName = self.topView.userNameLabel.text;
    personalDataVc.personalDataBlock=^(UIImage *headerImage){
        
        self.topView.headView.image=headerImage;
        
        if (_myBlock)
        {
            _myBlock(headerImage);
        }
        
        
    };
    [self.navigationController pushViewController:personalDataVc animated:NO];
    NSLog(@"gerenziliao");

}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
