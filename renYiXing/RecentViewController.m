//
//  RecentViewController.m
//  柴火圈
//
//  Created by Longxun on 16/10/26.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "RecentViewController.h"
#import "SChatVC.h"
#import "FirewoodCell.h"
@interface RecentViewController ()
@property (nonatomic, strong)NSMutableArray *modelArray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation RecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.modelArray = [NSMutableArray array];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor whiteColor];
    [self.tableview registerClass:[FirewoodCell class] forCellReuseIdentifier:@"cellIndentifier"];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    先用取出对应model
    //    因为使用哪一种cell 是根据model的性别来决定的
    //    如果性别为男  使用MyTableViewCell类型
    
    FirewoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIndentifier" forIndexPath:indexPath];
    UserInfo *model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SChatVC *chatVC = [[SChatVC alloc]init];
    
    //    FirewoodModel *model = self.modelArray[indexPath.row];
    //    ChatViewController *chatVc = [[ChatViewController alloc]initWithConversationChatter:model.userName conversationType:eConversationTypeChat];
    //
    //    chatVc.title = model.userName;
    //    chatVc.title = @"111";
    chatVC.personDic = self.modelArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
}
- (void)fetchData{
    Wself
    [WebShareData getDataFromWebWithParams:@{@"mod":@"index",@"ac":@"information",@"userid":[[SocketOprationData shareInit] sessionID]} urlString:[NSString stringWithFormat:@"%@mod=index&ac=information",CIRCLEURL] successBlock:^(NSDictionary *dicInfo) {
        Sself
        NSArray *arr = ([dicInfo isKindOfClass:[NSArray class]])?(NSArray *)dicInfo:@[dicInfo];
        for (NSDictionary *dic in arr) {
            UserInfo *ff = [UserInfo modelWithDictionary:dic];
            [sself.modelArray addObject:ff];
        }
        [sself.tableview reloadData];
    } failBlock:^(NSError *error) {
        
    }];
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
