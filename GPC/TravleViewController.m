//
//  TravleViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "TravleViewController.h"
#import "TravleCell.h"
#import "TravleModel.h"
#import "TravleInfoController.h"
#import "MJRefresh.h"
#import "OrderidModel.h"

@interface TravleViewController ()<UITableViewDelegate,UITableViewDataSource>{
    //头试图
    UIView *_headerView;
    
    int isPage;          //页数
    
     NSMutableArray * _array;
    //头像
    UIImageView *_imageview;
    
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TravleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的行程";
    
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"qianbaoback"]];
    [self.view addSubview:bkImage];
    
    
    _array = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //注册表格单元
    [self.tableView registerClass:[TravleCell class] forCellReuseIdentifier:travleIndentifier];
    
    self.tableView.mj_footer =  [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(UpTableView)];
    
    //绑定下拉刷新
    [self load];

}


#pragma mark - ----------------------------------TableView上拉刷新下拉加载更多方法
//设置绑定下拉刷新
-(void)load
{
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
        // 设置文字
    [header setTitle:@"下拉开始刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    //   header.stateLabel.font = [UIFont systemFontOfSize:15];
    //    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
//    header.stateLabel.textColor = [UIColor whiteColor];  //刷新文字颜色
//    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];  //设置刷新时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    self.tableView.mj_header = header;
}
//下拉刷新
-(void)loadNewData
{
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    //如果是下拉刷新，page为1
    isPage=1;
    //如果是下拉刷新，将原有的所有元素全部移除
    NSString * url = [NSString stringWithFormat:Main_URL,Record_URL];
    
    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"currentPage":[NSString stringWithFormat:@"%d",isPage]};
    
    [Tools POST:url params:dic superviewOfMBHUD:nil  success:^(id responseObj)
     {
         _array = [responseObj[@"data"][@"result"] mutableCopy];
         
         NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",_array);
         
         if (_array.count<5)
         {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
         }
         [self.tableView reloadData];
         [self.tableView.mj_header endRefreshing];
     } failure:^(NSError *error)
     {
         NSLog(@"请求失败: %@",error);
         [self.tableView.mj_header endRefreshing];
     }];
}
//上拉加载更多
- (void)UpTableView
{
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //    设置文字
        [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"已经全部加载" forState:MJRefreshStateNoMoreData];
//    // 设置字体
//    //  footer.stateLabel.font = [UIFont systemFontOfSize:17];
//    // 设置颜色
//    footer.stateLabel.textColor = [UIColor whiteColor];
    
 
    
    [footer beginRefreshing];
    // 设置footer
    self.tableView.mj_footer = footer;
    
}
-(void)loadMoreData
{
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];

    
    isPage++;
    NSString * url = [NSString stringWithFormat:Main_URL,Record_URL];
    
    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"currentPage":[NSString stringWithFormat:@"%d",isPage]};

    
    [Tools POST:url params:dic superviewOfMBHUD:nil  success:^(id responseObj)
     {
         NSArray * ary = responseObj[@"data"][@"result"];
         
         if (ary.count==0)
         {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
         }
         else
         {
             [_array addObjectsFromArray:responseObj[@"data"][@"result"]];
             [self.tableView reloadData];
             [self.tableView.mj_footer endRefreshing];
         }
     } failure:^(NSError *error) {
         NSLog(@"请求失败: %@",error);
         [self.tableView.mj_footer endRefreshing];
     }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    TravleModel *travleModel = [TravleModel travleWithDict:dic];
    

    
    TravleCell *cell = [tableView dequeueReusableCellWithIdentifier:travleIndentifier];
    
    //传递模型给cell
    cell.travleModel = travleModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _array[indexPath.row];
    
    OrderidModel *model = [OrderidModel shareModel];
    model.dict = dic;
    
    NSLog(@"orderid   %@",model.dict);
    
    
    
    
    TravleInfoController *travleVC = [[TravleInfoController alloc] init];
    
    [self.navigationController pushViewController:travleVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        //头像视图
        if (_headerView == nil) {
            
            _headerView  = [[UIView alloc] init];
            
            _imageview = [[UIImageView alloc]init];
            
            [_headerView addSubview:_imageview];
            
            
            _imageview.layer.cornerRadius = 100*0.5;
            _imageview.layer.masksToBounds = YES;
            _imageview.layer.borderWidth = 4;
            _imageview.layer.borderColor = [UIColor whiteColor].CGColor;
            
            
            
            [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.mas_equalTo(_headerView.mas_centerX);
                make.centerY.mas_equalTo(_headerView.mas_centerY).offset(10*KSCREENWIDTH/375.0);
                make.size.mas_equalTo(CGSizeMake(100,100));
            }];
            
        }
        
        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
        
        NSLog(@"%@",userModel.user_logo);
        
        //读取图片
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",userModel.user_id]];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
        if (image) {
            _imageview.image = image;
            
        } else if ([[NSString stringWithFormat:@"%@",userModel.user_logo] isEqualToString:@"(null)"]) {
            _imageview.image = [UIImage imageNamed:@"default.jpg"];
            
        } else {
            [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,userModel.user_logo]]];
        }
        
        return _headerView;
        
    } else {
        
        return nil;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 120;
    } else{
        
        return 0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
