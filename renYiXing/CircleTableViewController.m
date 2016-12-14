//
//  CircleTableViewController.m
//  柴火圈
//
//  Created by Longxun on 16/10/14.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "CircleTableViewController.h"
#import "SChatVC.h"

#import "FirewoodCell.h"
@interface CircleTableViewController (){

    int _selected;

}
@property (nonatomic, strong)NSMutableArray *modelArray;
@end

@implementation CircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPopButton];
    self.modelArray = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[FirewoodCell class] forCellReuseIdentifier:@"cellIndentifier"];
    
    if (self.type == 10086) {
        [self getMyCircleData];
    }else{
        [self fetchData];
    }
    
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
    cell.numMember.hidden = NO;
   // UserInfo *model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.modelArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type != 10086) {
        CircleInfo *model = self.modelArray[indexPath.row];
        _selected = indexPath.row;
        [self checkoutOurStatusWithModel:model];
        
    }else{
        SChatVC *chatVC = [[SChatVC alloc]init];
         chatVC.personDic = self.modelArray[indexPath.row];
        chatVC.isCircle = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
    
    
    
    
    
    //    FirewoodModel *model = self.modelArray[indexPath.row];
    //    ChatViewController *chatVc = [[ChatViewController alloc]initWithConversationChatter:model.userName conversationType:eConversationTypeChat];
    //
    //    chatVc.title = model.userName;
    //    chatVc.title = @"111";
   
//
}


/**
 申请加入
 */
- (void)commitCode{
    
    UITextField *t = [ApplicationDelegate.window viewWithTag:679];
    NSLog(@"----------%@",t.text);
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"UserInfo":@{@"RealNickName":@"",@"UserPsw":[self.passTextField.text md5String],@"UserName":self.phoneNumberTextField.text,@"NickName":self.littleNameTextField.text}}];
//    dict[@"cmd"] = PTL_CMD_REGISTER;
//    dict[@"type"] = PTL_REQ;
//    dict[@"sessionID"] = @"000000";
    
    
    
    CircleInfo *model = self.modelArray[_selected];
    
    NSDictionary *dict = @{@"type":PTL_REQ,@"cmd":@"joinGroup",@"sessionID":[[SocketOprationData shareInit] sessionID],@"groupID":model.qid,@"creatorID":model.creatorid,@"msg":t.text};
    
    [[SocketOprationData shareInit] sendReqDataWithValueDic:[dict mutableCopy] tag:@"joinGroup" objecte:self call:@selector(joinGroupResult:)];
    
    
    
    
    
    
    [self removeAlertView];
    
    
}


/**
 申请结果

 @param dic <#dic description#>
 */
- (void)joinGroupResult:(NSDictionary*)dic{
    
    if ([dic[@"result"] intValue] == 1) {
        [AppHelper toastMessage:@{@"message":@"已提交申请"}];
    }else{
        [AppHelper toastMessage:@{@"message":dic[@"err"]}];
    }
}



/**
 判断自己是不是已经在群里
 */
- (void)checkoutOurStatusWithModel:(CircleInfo *)model{
    
    NSDictionary *dic = @{@"userid":[[SocketOprationData shareInit] sessionID],@"groupid":model.qid};
    [WebShareData getDataFromWebWithParams:dic urlString:[NSString stringWithFormat:@"%@mod=index&ac=isgroup",CIRCLEURL] successBlock:^(NSDictionary *dicInfo) {
        
        //在群里
        if ([dicInfo[@"result"] intValue] == 1) {
            
            SChatVC *chatVC = [[SChatVC alloc]init];
            chatVC.personDic = (UserInfo *)model;
            
            [self.navigationController pushViewController:chatVC animated:YES];
            
        //不在群里
        }else{
             [self verifyWithAction:@selector(commitCode)];
        }
        
    } failBlock:^(NSError *error) {
        
    }];



}





/**
 获取我的圈子列表
 */
- (void)getMyCircleData{
    Wself
    [WebShareData getDataFromWebWithParams:@{@"userid":[[SocketOprationData shareInit] sessionID]} urlString:[NSString stringWithFormat:@"%@%@",CIRCLEURL,@"mod=index&ac=mygroup"] successBlock:^(NSDictionary *dicInfo) {
        Sself
        NSArray *arr = ([dicInfo isKindOfClass:[NSArray class]])?(NSArray *)dicInfo:@[dicInfo];
        for (NSDictionary *dic in arr) {
            CircleInfo *ff = [CircleInfo modelWithDictionary:dic];
            [sself.modelArray addObject:ff];
        }
        [sself.tableView reloadData];
    } failBlock:^(NSError *error) {
        
    }];

}

- (void)fetchData{
    Wself
    [WebShareData getDataFromWebWithParams:@{@"mod":@"index",@"ac":@"group",@"type":@(self.type),@"num":@(0)} urlString:CIRCLEURL successBlock:^(NSDictionary *dicInfo) {
        
        Sself
        NSArray *arr = ([dicInfo isKindOfClass:[NSArray class]])?(NSArray *)dicInfo:@[dicInfo];
        for (NSDictionary *dic in arr) {
            CircleInfo *ff = [CircleInfo modelWithDictionary:dic];
            [sself.modelArray addObject:ff];
        }
        [sself.tableView reloadData];
    } failBlock:^(NSError *error) {
        
    }];
}
@end
