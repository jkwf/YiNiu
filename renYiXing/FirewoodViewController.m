//
//  FirewoodViewController.m
//  柴火圈
//
//  Created by JOYSW on 16/7/13.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "FirewoodViewController.h"
#import "FirewoodCell.h"
#import "FirewoodHeaderView.h"
#import "Masonry.h"
#import "FirewoodModel.h"
#import "Header.h"
#import "DemoVC9.h"
#import "GCDSocket.h"
#import "AddFirend.h"
#import "CircleTableViewController.h"
#import "RecentViewController.h"
#import "NewFriendTableViewController.h"

#define NavigationBarH      CGRectGetMaxY(self.navigationController.navigationBar.frame)

@interface FirewoodViewController()<UITableViewDataSource,UITableViewDelegate>{
    UIView *_menuView;
}
@property(nonatomic , strong)UITableView *firewoodTableView;
@property(nonatomic , strong)NSMutableArray *modelArray;
@property (nonatomic,strong) NSArray *buddylist;
@property(nonatomic, strong)FetchBulletinRsp *fetchBulletinRsp;

@end

static NSString *cellIndentifier = @"cell";
static NSString *headerView = @"head";
@implementation FirewoodViewController


-(void)setModel
{
    self.modelArray = [NSMutableArray array];
    UserInfo *user = [[UserInfo alloc] init];
    user.pic = @"circle9";
    user.nickname = @"新朋友";
    user.content = @"";
    user.time = @"";
    [self.modelArray addObject:user];
//    NSArray *nameArr = @[@"测试101",@"测试003",@"测试002",@"测试005",@"周周",@"测试100"];
//    for (int i = 1; i < 7; i++)
//    {
//        FirewoodModel *tableModel = [[FirewoodModel alloc]init];
//
//        tableModel.userName = nameArr[i-1];
//        tableModel.headImageName = [NSString stringWithFormat:@"%d",i];
////        tableModel.nickName = [NSString stringWithFormat:@"zhangsan%d",i];
//        
//        [self.modelArray addObject:tableModel];
//    }
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [[SocketOprationData shareInit] sendReqDataWithValueDic:dic tag:PTL_CMD_FRIEND_LIST objecte:self call:@selector(finishFrdList:)];
    [self fetchData];
}

- (void)fetchData{
    Wself
    [WebShareData getDataFromWebWithParams:@{@"mod":@"index",@"ac":@"contact",@"userid":[[SocketOprationData shareInit] sessionID]} urlString:[NSString stringWithFormat:@"%@%@",CIRCLEURL,@"mod=index&ac=contact"] successBlock:^(NSDictionary *dicInfo) {
        Sself
        NSArray *arr = ([dicInfo isKindOfClass:[NSArray class]])?(NSArray *)dicInfo:@[dicInfo];
        for (NSDictionary *dic in arr) {
            UserInfo *ff = [UserInfo modelWithDictionary:dic];
            [sself.modelArray addObject:ff];
        }
        [sself.firewoodTableView reloadData];
        
    } failBlock:^(NSError *error) {
        
    }];
}

- (void)finishFrdList:(NSDictionary *)dic{
    if (dic[NODE_RRD_LIST]) {
        if ([dic[NODE_RRD_LIST] isKindOfClass:[NSString class]]){
            return;
        }
        NSArray *arr  = dic[NODE_RRD_LIST][NODE_USER];
        for (NSDictionary *dic in arr) {
            UserInfo *ff = [UserInfo modelWithDictionary:dic];
            [self.modelArray addObject:ff];
        }
        [self.firewoodTableView reloadData];
    }
}


//- (void)dealloc {
//    
////    [[EMClient sharedClient].contactManager removeDelegate:self];
//}

- (NSArray *)buddylist {
    if (!_buddylist) {
        _buddylist = [NSArray array];
    }
    return _buddylist;
}

-(void)loadView
{
    [super loadView];
    [self initPopButton];
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.text = @"柴火圈";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];
    
    
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setImage:[UIImage imageNamed:@"tianjia3"] forState:UIControlStateNormal];
    //[backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateHighlighted];
    [rightBarButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.frame =CGRectMake(0, 0, 25,25);
    UIBarButtonItem *items = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem = items;
    
//    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
//
//        if (!error) {
//            NSLog(@"获取成功 -- %@", buddyList);
////            EMBuddy * buddy = buddyList[indexPath.row];
//                for (EMBuddy *bubby in buddyList)
//                {
//                    FirewoodModel *model = [[FirewoodModel alloc]init];
//                    model.userName = bubby.username;
//                    model.headImageName = @"ren";
//                    [self.modelArray addObject:model];
//                }
//
////            [_modelArray removeAllObjects];
////            [_modelArray addObjectsFromArray:buddyList];
//            [_firewoodTableView reloadData];
//        }
//    } onQueue:dispatch_get_main_queue()];
    
}
-(void)viewDidLoad
{
   
    

    
    [self setModel];

    
    
    self.firewoodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.firewoodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.firewoodTableView.backgroundColor = [UIColor whiteColor];
    [self.firewoodTableView registerClass:[FirewoodCell class] forCellReuseIdentifier:cellIndentifier];
    [self.firewoodTableView registerClass:[FirewoodHeaderView class] forHeaderFooterViewReuseIdentifier:@"head"];
    self.firewoodTableView.delegate = self;
    self.firewoodTableView.dataSource = self;
    [self.view addSubview:self.firewoodTableView];
    
//    //签协议
//    [ [EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [self addNotificationFor:self Name:PTL_CMD_Fetch_Bulletin];
    FetchBulletinFriend *ff = [[FetchBulletinFriend alloc] init];
    ff.cmd = PTL_CMD_Fetch_Bulletin;
    ff.sessionID = [[SocketOprationData shareInit] sessionID];
    ff.fromID = @"0";
    ff.type = PTL_REQ;
    ff.userID = ff.sessionID;
    [[SocketOprationData shareInit] sendReqDataWithObj:ff tag:PTL_CMD_Fetch_Bulletin objecte:nil call:nil];
}
- (void)completeFunction:(NSNotification *)obj{
    self.fetchBulletinRsp = obj.object;
    [self.firewoodTableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height/9;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FirewoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    UserInfo *model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NewFriendTableViewController *f = [[NewFriendTableViewController alloc] init];
        f.dataList = self.fetchBulletinRsp.arrayList;
        f.title = @"新朋友";
        [self.navigationController pushViewController:f animated:YES];
        return;
    }
    SChatVC *chatVC = [[SChatVC alloc]init];
    chatVC.isCircle = NO;
//    FirewoodModel *model = self.modelArray[indexPath.row];
//    ChatViewController *chatVc = [[ChatViewController alloc]initWithConversationChatter:model.userName conversationType:eConversationTypeChat];
//    
//    chatVc.title = model.userName;
//    chatVc.title = @"111";
    chatVC.personDic = self.modelArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FirewoodHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"
                                   ];
    header.RecentContactsBtn.tag = 2001;
    header.StockBtn.tag = 2002;
    header.FuturesBtn.tag = 2003;
    header.OutsideBtn.tag = 2004;
    header.StrategyBtn.tag = 2005;
    header.BugBtn.tag = 2006;
    header.StrategyAdviceBtn.tag = 2007;
    header.myBtn.tag = 2008;
    header.CustomerBtn.tag = 2009;
    [header.RecentContactsBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.StockBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.FuturesBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.OutsideBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.StrategyBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.BugBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.StrategyAdviceBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.myBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [header.CustomerBtn addTarget:self action:@selector(RecentContactsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.bounds.size.height/9*4+4+40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)leftBarButtonAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)addAction
{
//    EMError *error = [[EMClient sharedClient].contactManager addContact:@"1234599" message:@"我想加您为好友"];
//    if (!error) {
//        NSLog(@"添加成功");
//    }

    PopView *pop = [[PopView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:pop];

    return;
   
    NSLog(@"tianjia");
}

//-(void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message
//{
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"收到来自%@的请求", username] message:message preferredStyle:(UIAlertControllerStyleAlert)];
//    UIAlertAction * acceptAction = [UIAlertAction actionWithTitle:@"好" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *  action) {
//        EMError * error;
//        // 同意好友请求的方法
//        if ([[EaseMob sharedInstance].chatManager acceptBuddyRequest:username error:&error] && !error) {
//            NSLog(@"发送同意成功");
//            [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
//                
//                if (!error) {
//                    NSLog(@"获取成功 -- %@", buddyList);
//                    for (EMBuddy *bubby in buddyList)
//                    {
//                        FirewoodModel *model = [[FirewoodModel alloc]init];
//                        model.userName = bubby.username;
//                        model.headImageName = @"ren";
//                        [self.modelArray addObject:model];
//                    }
//                    [_firewoodTableView reloadData];
//                }
//            } onQueue:dispatch_get_main_queue()];
//            
//        }
//    }];
//    UIAlertAction * rejectAction = [UIAlertAction actionWithTitle:@"滚" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//        EMError * error;
//        // 拒绝好友请求的方法
//        if ([[EaseMob sharedInstance].chatManager rejectBuddyRequest:username reason:@"滚, 快滚!" error:&error] && !error) {
//            NSLog(@"发送拒绝成功");
//        }
//    }];
//    [alertController addAction:acceptAction];
//    [alertController addAction:rejectAction];
//    [self showDetailViewController:alertController sender:nil];
//}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    NSLog(@"同意");
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername
{
    NSLog(@"拒绝");
}

-(void)RecentContactsBtnAction:(UIButton *)btn
{
    if (btn.tag == 2001)
    {
        RecentViewController *vc = [[RecentViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"111");
    }
    else if (btn.tag == 2002)
    {

        CircleTableViewController *vc = [[CircleTableViewController alloc] init];
        vc.type = (int)btn.tag -2002+100;
        vc.navigationItem.title = @"股票圈";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"222");
    }
    else if (btn.tag == 2003)
    {
        CircleTableViewController *vc = [[CircleTableViewController alloc] init];
        vc.type = (int)btn.tag -2002+100;
        vc.navigationItem.title = @"期货圈";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"333");
    }
    else if (btn.tag == 2004)
    {
        CircleTableViewController *vc = [[CircleTableViewController alloc] init];
        vc.type = (int)btn.tag -2002+100;
        vc.navigationItem.title = @"外盘圈";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"444");
    }
    else if (btn.tag == 2005)
    {
        CircleTableViewController *vc = [[CircleTableViewController alloc] init];
        vc.type = (int)btn.tag -2001+100;
        vc.navigationItem.title = @"策略圈";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"555");
    }
    else if (btn.tag == 2006)
    {
//        CircleTableViewController *vc = [[CircleTableViewController alloc] init];
//        vc.type = (int)btn.tag -2001+100;
//        vc.navigationItem.title = @"BUG反馈圈";
//        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"666");
    }
    else if (btn.tag == 2007)
    {
//        CircleTableViewController *vc = [[CircleTableViewController alloc] init];
//        vc.type = (int)btn.tag -2001+100;
//        vc.navigationItem.title = @"策略建议圈";
//        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"777");
    }
    else if (btn.tag == 2008)
    {
        DemoVC9 *findVc = [[DemoVC9 alloc]init];
        [self.navigationController pushViewController:findVc animated:NO];
        NSLog(@"888");
    }
    else if (btn.tag == 2009)
    {
        CircleTableViewController *vc = [[CircleTableViewController alloc] init];
        vc.type = 10086;
        vc.navigationItem.title = @"客户圈";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"999");
    }
  
    
}


@end
