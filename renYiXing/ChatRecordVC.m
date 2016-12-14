//
//  ChatRecordVC.m
//  柴火圈
//
//  Created by 姬荣康 on 2016/12/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "ChatRecordVC.h"
#import "RecordCell.h"
@interface ChatRecordVC ()<UITableViewDelegate,UITableViewDataSource>{

    __weak IBOutlet UISearchBar *_searchBar;
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray *_sourceArr;
}

@end

@implementation ChatRecordVC
- (void)getSourceData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.groupId forKey:@"qid"];
    
    [WebShareData getDataFromWebWithParams:dic urlString:getCircleAPIURL(@"mod=index&ac=qrecor") successBlock:^(NSDictionary *dicInfo) {
        
        if ([dicInfo isKindOfClass:[NSArray class]]) {
            _sourceArr = [NSMutableArray arrayWithArray:(NSArray *)dicInfo];
            [_tableView reloadData];
            //            NSLog(@"-------------%@",_sourceArr);
        }
        
        //
        
    } failBlock:^(NSError *error) {
        
        
    }];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *msg = [_sourceArr[indexPath.row] objectForKey:@"qmsg"];
    CGFloat height = [self labSizeWithString:msg withFont:13 withLabWidth:MainScreenW - 16].height;
    if (height < 20) {
        return 60;
    }else{
        return height + 40;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getSourceData];
    
    _sourceArr = [NSMutableArray array];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"RecordCell" bundle:nil] forCellReuseIdentifier:@"RecordCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell" forIndexPath:indexPath];
    return cell;
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
