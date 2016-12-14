//
//  GroupMemberListVC.m
//  柴火圈
//
//  Created by 姬荣康 on 2016/12/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "GroupMemberListVC.h"
#import "GroupMemberListCell.h"


@interface GroupMemberListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>{

    NSMutableArray *_sourceArr;
    UICollectionView *_collectionView;
}

@end

@implementation GroupMemberListVC


- (void)getSourceData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.groupId forKey:@"qid"];
    
    [WebShareData getDataFromWebWithParams:dic urlString:getCircleAPIURL(@"mod=index&ac=qmember") successBlock:^(NSDictionary *dicInfo) {
        
        if ([dicInfo isKindOfClass:[NSArray class]]) {
            _sourceArr = [NSMutableArray arrayWithArray:(NSArray *)dicInfo];
            [_collectionView reloadData];
//            NSLog(@"-------------%@",_sourceArr);
        }
        
//
        
    } failBlock:^(NSError *error) {
        
        
    }];

    

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"圈成员(%@人)",self.num];
    _sourceArr = [NSMutableArray array];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(multip(78),multip(78));
    layout.minimumLineSpacing = 0;//行间距
    
    layout.minimumInteritemSpacing = 0;//列间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainScreenW, MainScreenH) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"GroupMemberListCell" bundle:nil] forCellWithReuseIdentifier:@"GroupMemberListCell"];
    
   
    [self getSourceData];
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _sourceArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GroupMemberListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupMemberListCell" forIndexPath:indexPath];
    
    [cell confignWithDic:_sourceArr[indexPath.row]];
    // Configure the cell
    
    return cell;
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
