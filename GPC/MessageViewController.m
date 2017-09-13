//
//  MessageViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h" 
#import "MessageModel.h"
#import "MessageInfoController.h"
#import "MJRefresh.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource> {
    int isPage;          //页数
}

@property (nonatomic, strong) NSMutableArray *arrayModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MessageViewController

- (NSMutableArray *)arrayModel
{
    if (_arrayModel == nil) {
        _arrayModel = [NSMutableArray array];
    }
    return _arrayModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的消息";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
    NSString * url = [NSString stringWithFormat:Main_URL,Message_URL];
    
    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"currentPage":[NSString stringWithFormat:@"%d",isPage]};
    
    [Tools POST:url params:dic superviewOfMBHUD:nil  success:^(id responseObj)
     {
         self.arrayModel = [responseObj[@"data"][@"result"] mutableCopy];
         
         NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",self.arrayModel);
         
         if (self.arrayModel.count<10)
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
    NSString * url = [NSString stringWithFormat:Main_URL,Message_URL];
    
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
             [self.arrayModel addObjectsFromArray:responseObj[@"data"][@"result"]];
             [self.tableView reloadData];
             [self.tableView.mj_footer endRefreshing];
         }
     } failure:^(NSError *error) {
         NSLog(@"请求失败: %@",error);
         [self.tableView.mj_footer endRefreshing];
     }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.arrayModel[indexPath.row];
    
    MessageModel *messageModel = [MessageModel messageWithDict:dic];
    
    MessageCell *cell = [MessageCell messageCellWith:tableView];
    
    cell.messageModel = messageModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MessageInfoController *infoVC = [[MessageInfoController alloc] init];
//    
//    [self.navigationController pushViewController:infoVC animated:YES];
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
