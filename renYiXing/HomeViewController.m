//
//  HomeViewController.m
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "HomeViewController.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>
#import "HomeCollectionViewCell.h"
#import "OptionalViewController.h"
#import "TransactionViewController.h"
#import "DiyView.h"
#import "MyViewController.h"
#import "Header.h"
#import "WebViewController.h"
#import "WithdrawDepositViewController.h"
#import "FirewoodViewController.h"
#import "RankingViewController.h"
#import "ZhenDuanViewController.h"
#import "UIImageView+WebCache.h"
@interface HomeViewController ()<WKNavigationDelegate,WKUIDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>{
    NSMutableArray *_bannerArr;
    UICollectionView *_collectionView;

}
@property(nonatomic , strong)WKWebView *web;
@property(nonatomic , strong)NSMutableArray *imageArray;
@property(nonatomic , strong)NSMutableArray *titleArray;
@property(nonatomic , strong)DiyView *topView;
@end

static NSString *cellIndentifier = @"cell";
@implementation HomeViewController

-(void)creatImage
{
    self.imageArray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    for (int i = 0; i< 12; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"1%03d",i]];
        [self.imageArray addObject:image];
    }
    NSArray *temparr = @[@"策略交易",@"排名跟单",@"柴火圈",@"策略排名",@"业绩",@"充值提现",@"大师空间",@"宝贝空间",@"培训视频",@"阅读",@"投资诊所",@"段子王"];
    [self.titleArray addObjectsFromArray:temparr];
}


- (void)getBannerImg{
    _bannerArr = [NSMutableArray array];
    
    [WebShareData getDataFromWebWithParams:@{} urlString:getAPIURL(@"mod=interface&ac=banner") successBlock:^(id dicInfo) {
       
        if ([dicInfo isKindOfClass:[NSArray class]]) {
            _bannerArr = [NSMutableArray arrayWithArray:dicInfo];
            [self createBannerView];
        }
    } failBlock:^(NSError *error) {
        
    }];
}

- (void)createBannerView{
    //    创建滚动视图 UIScrollView
    //    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height/9+20+self.view.bounds.size.width/4*3, self.view.bounds.size.width, self.view.bounds.size.height-self.view.bounds.size.height/9-self.view.bounds.size.width/4*3-100)];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    //    (self.view.bounds.size.height-(self.topView.frame.size.height+collection.frame.size.height+30+49))
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //    //    设置scrollView代理
    scrollView.delegate = self;
    //    //    设置缩小比例
    //    scrollView.minimumZoomScale = 0.5;
    //    //    设置放大比例
    //    scrollView.maximumZoomScale = 2.0;
    
    
    //    设置滑动内容区域面积大小  是十分重要的属性
    //    该属性来决定scrollView是否能够滑动
    //    宽度决定 是否能够水平滑动
    //    高度决定 是否能够垂直滑动
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*_bannerArr.count, 0);
    //    设置scrollView的偏移量 决定当前显示哪张图片 同样也是重要的属性
    scrollView.contentOffset = CGPointMake(0,0);
    //    决定是否整屏翻动 默认为NO
    scrollView .pagingEnabled = YES;
    //    边界是否有回弹效果 默认为YES
    scrollView.bounces = NO;
    
    // 点击状态栏 是否回到顶部 默认为YES
    //    只有垂直滑动的时候 才会有效果
    scrollView.scrollsToTop = YES;
    
    //    设置是否能滚动 默认为YES
    //    滚动的开启和关闭 跟交互是没有任何关系的
    //    scrollView.scrollEnabled = NO;
    
    //    水平方向滚动条是否显示 默认为YES
    scrollView.showsHorizontalScrollIndicator =NO;
    
    //    水平方向滚动条是否显示 默认为YES
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    scrollView.frame = CGRectMake(0, _collectionView.bottom + 10, MainScreenW, MainScreenH - _collectionView.bottom - 69 - 64);
    
    //    for循环创建每一个小的scrollView
    //    大的scrollView上装载类三个小的scrollView
    //    每一个小的scrollView装载了一个imageView
    for (int i = 0; i < _bannerArr.count; i++) {
        //        每一个小的scrollView
        UIScrollView *smallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(MainScreenW*i, 0, MainScreenW, scrollView.bounds.size.height)];
        NSLog(@"%f",scrollView.frame.size.height);
        smallScrollView.backgroundColor = [UIColor blackColor];
        smallScrollView.delegate = self;
        //        smallScrollView.minimumZoomScale = 0.5;
        //        smallScrollView.maximumZoomScale = 2.0;
        
        //        每一个小的scrollView上的imageView
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenW,smallScrollView.bounds.size.height)];
        
    
        [imageView sd_setImageWithURL:[NSURL URLWithString:getBannerUrl([_bannerArr[i] objectForKey:@"pic"])] placeholderImage:[UIImage imageNamed:@"banner"]];
//        imageView.image = [UIImage imageNamed:@"banner"];
        [smallScrollView addSubview:imageView];
        [scrollView addSubview:smallScrollView];
        
    }
    
    
    //    ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    //    UIPageControl
    //    如果要使用的话 通常只会与scrollView进行结合使用
    //    pageControl当前值 会随着 scrollView的偏移量变化而变化
    //    而scrollView 偏移量  通常也会 随着pageControl的当前变化而变化
    UIPageControl *page = [[UIPageControl alloc]init];
    page.frame = CGRectMake(0, MainScreenH - 5- 69 - 64, MainScreenW, 5);
//    page.translatesAutoresizingMaskIntoConstraints = NO;
//        page.backgroundColor = [UIColor purpleColor];
    //    设置有几页（几个小原点）
    page.numberOfPages = _bannerArr.count;
    //    设置当前点的颜色
    page.currentPageIndicatorTintColor = [UIColor cyanColor];
    
    //    设置非当前点的颜色
    page.pageIndicatorTintColor = [UIColor grayColor];
    
    //    设置默认当前所在点
    //    所有小原点 是从左到右 由0开始
    page.currentPage = 0;
    [page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:page];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loginWithIm];
    
    
    self.topView.userNameLabel.text = LoginNickName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor= [UIColor blackColor];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationItem.title = @"任意行";
    [self creatImage];
    [self getBannerImg];
    //    先创建一个布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //    创建一个UICollectionView对象
    //    collectionViewLayout 是集合视图一部分的布局方式
    //    控制集合师徒整体的  上 左 下 右的边距
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/9+10, self.view.bounds.size.width, self.view.bounds.size.width/4*3) collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
    //    设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:cellIndentifier];
    [self.view addSubview:_collectionView];
    

    self.topView = [[DiyView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/9)];
    self.topView.backgroundColor = [UIColor whiteColor];
//    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.topView.headView.image=[UIImage imageWithData:fetchFile];
    if (!self.topView.headView.image)
    {
        [self.topView.headView setImage:[UIImage imageNamed:@"headImage"]];
    }

    [self.view addSubview:self.topView];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.topView addGestureRecognizer:tap];
    
    
   
    
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(collection.mas_bottom).offset(10);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
//        make.width.mas_equalTo(self.view.bounds.size.width);
//    }];
//
//    [page mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-5);
//        make.width.mas_equalTo(self.view.mas_width);
//    }];

}

#pragma mark === 返回多少分区====
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;//跟tableView一样 如果不实现该方法 默认分区是1
}

#pragma mark ===每个分区下 返回多少行====
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

#pragma mark === 返回cell====

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    
    cell.picImageView.image = self.imageArray[indexPath.row];
    cell.label.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = @"";
            web.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 1:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = @"";
            web.navigationItem.title = self.titleArray[indexPath.row];

            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 2:{

            FirewoodViewController *firewoodVc = [[FirewoodViewController alloc]init];
            [self.navigationController pushViewController:firewoodVc animated:YES];
            
            
            
        }
            
            break;
        case 3:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = @"";
            web.navigationItem.title = self.titleArray[indexPath.row];

            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 4:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = @"";
            web.navigationItem.title = self.titleArray[indexPath.row];

            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 5:
        {
            WithdrawDepositViewController *withdrawDepositVc = [[WithdrawDepositViewController alloc]init];
            [self.navigationController pushViewController:withdrawDepositVc animated:YES];
        }
            
            break;
        case 6:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = URLTeacherList;
            //[self presentViewController:web animated:YES completion:nil];
            web.navigationItem.title = self.titleArray[indexPath.row];
            [web.navigationController setNavigationBarHidden:YES animated:NO];
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 7:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString =  URLApplayBaby;
            web.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 8:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = URLVideoList;
            web.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 9:
        {
            WebViewController *web = [[WebViewController alloc] init];
            web.urlString = URLBookList;
            web.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:web animated:YES];
        }
            break;
        case 10:
        {
            ZhenDuanViewController *vc = [[ZhenDuanViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 11:
        {

            StoryKingViewController *storykingVc = [[StoryKingViewController alloc]init];
            [self.navigationController pushViewController:storykingVc animated:YES];

        }
            break;
            
        default:
            break;
    }
}
- (void)loginWithIm{
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{NODE_USER_NAME:LoginUserName,NODE_PASSWORD:[LoginPassword md5String],NODE_DOMAIN:@"9000"}];
    [[SocketOprationData shareInit] sendReqDataWithValueDic:dict tag:PTL_CMD_LOGIN objecte:self call:@selector(loginResult:)];
    
    
}

- (void)loginResult:(NSDictionary *)dic{
    int r = [dic[NODE_RESULT_NAME] intValue];
    if (r == 1){
        
        SetLoginUserId(dic[@"sessionID"]);
        SetLoginNickName(dic[@"nickname"]);
        SetSynchronize;
        
    }else{
        [AppHelper toastMessage:@{@"message":dic[NODE_ERR_NAME]}];
    }
}




#pragma mark === 返回每个item的高和宽====

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //    返回每一个item的大小 也就是宽和高
    //    return CGSizeMake(100, 150);
    
    //    返回item大小 要比 返回cell的方法 先执行
    //    也就是说 我们在返回item的大小的方法里 根本就取不到cell 所以根本无法控制 cell上的imageView和label
    
    
    
    //    1.得到image的大小
//    UIImage *tempImage = self.imageArray[indexPath.row];
//    
//    CGSize size = tempImage.size;
//    //    2.因为我们item的宽度固定是100  我们需要得到image原本的宽度  和100之间 缩放了多少倍
//    CGFloat scale = size.width/100;
//    
//    //    3.我们得到的缩放的倍数 是宽度和100之间的  高度同理
//    CGFloat tempHeight = size.height/scale;
//    
//    //    4.最终我们的宽度  return 回去的是固定的100 高度return是动态的
//    //    height得到的是图片的高度 还要加上label和上边距，下边距
    return CGSizeMake((self.view.frame.size.width-3)/4,(self.view.frame.size.width-3)/4);
    
}

#pragma mark === 返回上 左 下 右的边距====
//所指的这些边距  是针对于 集合视图整体来说的
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark === 返回行间距====
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark === 返回列间距====
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//
//

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    MyViewController *myVc = [[MyViewController alloc]init];
    myVc.userName = self.topView.userNameLabel.text;
    myVc.myBlock=^(UIImage *headerImage){
    
        self.topView.headView.image=headerImage;
        
    };
    [self.navigationController pushViewController:myVc animated:YES];
    
}




//
//==================scrollView====================

#pragma mark  ----pageControl触发方法
- (void)pageAction:(UIPageControl *)page
{
    //    取出大的scrollView
    //    因为大的scrollView是self.view第一个添加的视图
    UIScrollView *tempScroll = self.view.subviews[2];
    //    大scrollView的偏移量 ＝ 小原点的当前值
    //    tempScroll.contentOffset = CGPointMake(200*page.currentPage,0);
    
    [tempScroll setContentOffset:CGPointMake(page.currentPage*self.view.frame.size.width, 0) animated:YES];
}



//#pragma mark ---决定哪个视图能够缩放-----
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return scrollView.subviews[0];
//}
//
//#pragma mark ---- 视图缩放的时候触发的方法----
//-(void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    UIImageView *imageView = scrollView.subviews[0];
//    
//    //    控制缩放比例的大小 会强制变成该缩放比例
//    //    必须是在视图允许缩放之后  在进行设置该比例
//    //    scrollView.zoomScale = 1;
//    
//    imageView.center = CGPointMake(scrollView.frame.size.width/2, scrollView.frame.size.height/2);
//}


#pragma mark ====已经开始滚动的代理方法=====
// 只要是滚动状态  会一直调用这个方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"已经开始滚动");
}


#pragma mark ====开始拖拽的代理方法=====
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"开始拖拽");
}


#pragma mark ====结束拖拽的代理方法=====
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"结束拖拽");
}


#pragma mark ====开始减速触发的代理方法=====
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"开始减速");
}

#pragma mark ====结束减速触发的代理方法=====
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"结束减速");
    //    取出page page同样是加在self.view  并且第二个加上的视图
    UIPageControl *tempPage = self.view.subviews[3];
    //    page的当前值 ＝ 大的scrollview偏移量 / 视图本身的宽度
    tempPage.currentPage = scrollView.contentOffset.x/self.view.frame.size.width;
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
