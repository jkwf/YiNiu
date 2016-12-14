//
//  NewFriendTableViewController.m
//  JoyIM
//
//  Created by Longxun on 16/9/17.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import "NewFriendTableViewController.h"
#import "RecentTableViewCell.h"
@interface NewFriendTableViewController ()

@end

@implementation NewFriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initPopButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)actionAgree:(UIButton *)btn{
//    <JoyIM>
//    <type>req</type>
//    <cmd>acceptFriend</cmd>
//    <sessionID>7552666</sessionID>
//    <toID>1421792</toID>
//    <groupID>1234</groupID>
//    <time>1472280683</time>
//    <msg>test</msg>
//    </JoyIM>
    BulletinObj *o = self.dataList[btn.tag];
    AddFirend *f = [[AddFirend alloc] init];
    f.type = PTL_REQ;
    f.cmd = PTL_CMD_Accept_Friend;
    f.sessionID = [[SocketOprationData shareInit] sessionID];
    f.msg = @"同意";
    f.toID = o.fromID;
    f.groupID = @"0";
    f.time = o.time;
    
    [[SocketOprationData shareInit] sendReqDataWithObj:f tag:f.cmd objecte:self call:@selector(sendFinish:)];
    RecentTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    cell.rejectBtn.hidden = YES;
    [cell.agreeBtn setTitle:@"已接受" forState:UIControlStateNormal];
    cell.agreeBtn.enabled = NO;

}
- (void)sendFinish:(id)obj{
    [WDAlert showAlertWithMessage:@"发送成功" time:1.];
}
- (void)actionReject:(UIButton *)btn{
    BulletinObj *o = self.dataList[btn.tag];
    AddFirend *f = [[AddFirend alloc] init];
    f.type = PTL_REQ;
    f.cmd = PTL_CMD_Reject_Friend;
    f.sessionID = [[SocketOprationData shareInit] sessionID];
    f.msg = @"拒绝";
    f.toID = o.fromID;
    f.groupID = @"0";
    f.time = o.time;
    
    [[SocketOprationData shareInit] sendReqDataWithObj:f tag:f.cmd objecte:self call:@selector(sendFinish:)];
    RecentTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    cell.rejectBtn.hidden = YES;
    [cell.agreeBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
    cell.agreeBtn.enabled = NO;

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"RecentTableViewCell";
    RecentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"RecentTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        
        
    }

    
    UIButton *btn = cell.agreeBtn;
    cell.tipLabel.hidden = YES;
    cell.agreeBtn.hidden = NO;
    cell.headerImage.image = [UIImage imageNamed:@"5"];
    BulletinObj *obj = self.dataList[indexPath.row];
    cell.nickNameLabel.text = obj.fromID;
    cell.rejectBtn.hidden = YES;
    cell.msgLabel.text = obj.msg;
    if ([obj.bulletinType integerValue] == 1) {//请求
        [btn setTitle:@"同意" forState:UIControlStateNormal];
        cell.rejectBtn.hidden = NO;
        cell.rejectBtn.tag = indexPath.row;
        cell.agreeBtn.tag = indexPath.row;
        [cell.agreeBtn addTarget:self action:@selector(actionAgree:) forControlEvents:UIControlEventTouchUpInside];
         [cell.rejectBtn addTarget:self action:@selector(actionReject:) forControlEvents:UIControlEventTouchUpInside];
        btn.enabled = YES;
    }else if ([obj.bulletinType integerValue] == 2) {//接受
        [btn setTitle:@"已接受" forState:UIControlStateNormal];
        btn.enabled = NO;
    }else if ([obj.bulletinType integerValue] == 3) {//拒绝
        [btn setTitle:@"已拒绝" forState:UIControlStateNormal];
        btn.enabled = NO;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}
@end
