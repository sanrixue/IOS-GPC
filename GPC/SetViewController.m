//
//  SetViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "SetViewController.h"
#import "CreatControls.h"
#import "LianxiViewController.h"
#import "GuanyuViewController.h"
#import "FankuiViewController.h"
#import "AppDelegate.h"
#import "DBManager.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_titles;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置中心";
    
    _titles = @[@[@"意见反馈"], @[ @"联系我们"], @[@"关于GPC"]];
    
    [self createTableView];
    
    
    UIButton *outBtn = [[UIButton alloc] init];
    outBtn.frame = CGRectMake(0, 150 * KSCREENWIDTH / 375.0 + 72, KSCREENWIDTH, 45 * KSCREENWIDTH / 375.0);
    [outBtn setTitle:@"退出" forState:UIControlStateNormal];
    outBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [outBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [outBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [outBtn addTarget:self action:@selector(outBtnClick) forControlEvents:UIControlEventTouchUpInside];
    outBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    
    [self.view addSubview:outBtn];
}

- (void)outBtnClick {
    NSLog(@"退出登录");
    
    [[DBManager sharedManager] deleteUserModel];
    
     AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //退出登录
    [appDelegate setupLoginViewController];
    
    

}
//创建表示图
-(void)createTableView{
    
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStyleGrouped];
    }
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.scrollEnabled = NO;
    
//    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    
}

//显示多少数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_titles[section] count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 * KSCREENWIDTH / 375.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.text = _titles[indexPath.section][indexPath.row];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.textLabel.textColor = [UIColor grayColor];
    
    return cell;
}

//点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;
    if ([title isEqualToString:@"意见反馈"]) {
        FankuiViewController *fanVC = [[FankuiViewController alloc] init];
        
        [self.navigationController pushViewController:fanVC animated:YES];
        
    }else if ([title isEqualToString:@"关于GPC"]){
        
        GuanyuViewController *guanVC = [[GuanyuViewController alloc] init];
        
        [self.navigationController pushViewController:guanVC animated:YES];
        
    }else if ([title isEqualToString:@"联系我们"]){
        
        LianxiViewController *lianxiVC = [[LianxiViewController alloc] init];
        
        [self.navigationController pushViewController:lianxiVC animated:YES];
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1 * KSCREENWIDTH/375.0;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
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
