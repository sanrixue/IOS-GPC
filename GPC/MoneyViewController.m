//
//  MoneyViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "MoneyViewController.h"
#import "AddMoneyViewController.h"
#import "AddYajinViewController.h"
#import "MingXiViewController.h"

@interface MoneyViewController (){
    UILabel *_moneyLab;
    UILabel *_yajinLab;

}

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"wodeqianbao"]];
//    [ self.view setBackgroundColor:bgColor];
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"wodeqianbao"]];
    [self.view addSubview:bkImage];
    
                        
    self.navigationItem.title = @"我的钱包";
    
    //右侧侧滑按钮
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 75, 25);
    [rightbtn addTarget:self action:@selector(ClickrightItem) forControlEvents:UIControlEventTouchUpInside];
    [rightbtn setImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setUI];
}

- (void)setUI {
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];

    
    _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5 - 100, KSCREENHEIGHT * 0.3 + 40, 200, 60)];
    _moneyLab.textColor = [UIColor whiteColor];
    _moneyLab.font = [UIFont systemFontOfSize:60];
    _moneyLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_moneyLab];
    
    _moneyLab.text = userModel.user_wallet;

    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5 - 120, KSCREENHEIGHT * 0.3 + 100, 240, 120)];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:20];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    lab.text = @"车费余额（元）";
    
    
    _yajinLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5 - 50, KSCREENHEIGHT * 0.75, 100, 40)];
    _yajinLab.textColor = [UIColor whiteColor];
    _yajinLab.font = [UIFont systemFontOfSize:18];
    _yajinLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_yajinLab];
    
    _yajinLab.text = [NSString stringWithFormat:@"押金%@元",userModel.user_deposit];
    
    
    UIButton *moneyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT * 0.9, KSCREENWIDTH * 0.5, KSCREENHEIGHT * 0.1)];
    moneyBtn.backgroundColor = [UIColor clearColor];
    [moneyBtn addTarget:self action:@selector(moneyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moneyBtn];
    
    UIButton *yajinBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5, KSCREENHEIGHT * 0.9, KSCREENWIDTH * 0.5, KSCREENHEIGHT * 0.1)];
    yajinBtn.backgroundColor = [UIColor clearColor];
    [yajinBtn addTarget:self action:@selector(yajinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yajinBtn];
}

- (void)moneyBtnClick {
    AddMoneyViewController *addMoney = [[AddMoneyViewController alloc] init];
    
    [self.navigationController pushViewController:addMoney animated:YES];
    
}

- (void)yajinBtnClick {
    AddYajinViewController *addYajin = [[AddYajinViewController alloc] init];
    
    [self.navigationController pushViewController:addYajin animated:YES];
}


- (void)ClickrightItem {
    MingXiViewController *mingxiVC = [[MingXiViewController alloc] init];
    
    [self.navigationController pushViewController:mingxiVC animated:YES];
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
