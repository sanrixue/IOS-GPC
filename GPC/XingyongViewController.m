//
//  XingyongViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/19.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "XingyongViewController.h"
#import "RuleViewController.h"
#import "HistoryViewController.h"
#import "XinYongModel.h"
#import "XinYongCell.h"

@interface XingyongViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel *_xinLab;
    
    NSMutableArray *_array;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XingyongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的GPC信用积分";
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"xinyong"]];
    [self.view addSubview:bkImage];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT * 0.7, KSCREENWIDTH, 200) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //注册表格单元
    [self.tableView registerClass:[XinYongCell class] forCellReuseIdentifier:xinyongIndentifier];
    
    [self.tableView reloadData];
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    
    _xinLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5 - 100, KSCREENHEIGHT * 0.3 + 40, 200, 60)];
    _xinLab.textColor = [UIColor whiteColor];
    _xinLab.font = [UIFont systemFontOfSize:70];
    _xinLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_xinLab];

 
    
    NSString * url3 = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:ScoreSum_URL,userModel.user_id]];
    NSLog(@"地址------>>>>%@",url3);
    
    [Tools POST:url3 params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj);
         
         
         _xinLab.text = [NSString stringWithFormat:@"%@", responseObj[@"sum"]];
         
         
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];
    

    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5 - 100, KSCREENHEIGHT * 0.3 + 100, 200, 120)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:30];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    lab.text = @"信用积分";
    
    
    UIButton *ruleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT * 0.9, KSCREENWIDTH * 0.5, KSCREENHEIGHT * 0.1)];
    ruleBtn.backgroundColor = [UIColor clearColor];
    [ruleBtn addTarget:self action:@selector(ruleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ruleBtn];
    
    UIButton *historyBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5, KSCREENHEIGHT * 0.9, KSCREENWIDTH * 0.5, KSCREENHEIGHT * 0.1)];
    historyBtn.backgroundColor = [UIColor clearColor];
    [historyBtn addTarget:self action:@selector(historyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:historyBtn];
    
    
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: YES];
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    _array = [NSMutableArray array];
    
    NSString * url = [NSString stringWithFormat:Main_URL,ScoreAll_URL];
    
    NSDictionary *dic = @{@"uid":userModel.user_id,
                          @"currentPage":@"1"};
    
    
    [Tools POST:url params:dic superviewOfMBHUD:nil  success:^(id responseObj)
     {
         NSMutableArray *array = [NSMutableArray array];
         
         array = [responseObj[@"data"][@"result"] mutableCopy];
         
         NSLog(@"!!!!!!%@",array);
         
         if (array.count >3) {
             for (int i = 0; i<3; i++) {
                 NSDictionary *dic = array[i];
                 [_array addObject:dic];
             }
             NSLog(@"%@",_array);
             
         } else if (array.count > 0) {
             _array = array;
         }
         
           [self.tableView reloadData];
     } failure:^(NSError *error)
     {
         NSLog(@"请求失败: %@",error);
         
     }];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     NSLog(@"%ld",_array.count);
  
    return _array.count;
    
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取出模型
    NSDictionary *dic  = _array[indexPath.row];
    
    XinYongModel *xinyongModel = [XinYongModel xinyongWithDict:dic];
    
    XinYongCell *cell = [tableView dequeueReusableCellWithIdentifier:xinyongIndentifier];
    
    //传递模型给cell
    cell.xinyongModel = xinyongModel;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.frame = cell.frame;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//Cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}




- (void)ruleBtnClick {
    RuleViewController *ruleVC = [[RuleViewController alloc] init];
    
    [self.navigationController pushViewController:ruleVC animated:YES];
    
}

- (void)historyBtnClick {
    HistoryViewController *historyVC = [[HistoryViewController alloc] init];
    
    [self.navigationController pushViewController:historyVC animated:YES];
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
