//
//  RuleViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/19.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "RuleViewController.h"


@interface RuleViewController ()<UIAlertViewDelegate>

@end

@implementation RuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"规则解读";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.5 - 100, 80, 200, 40)];
    lab.text = @"骑车规则";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:20];
    lab.textColor = [UIColor grayColor];
    [self.view addSubview:lab];
    
    UILabel *lineLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 121, KSCREENWIDTH, 1)];
    lineLab1.backgroundColor = [UIColor lightGrayColor];
    lineLab1.alpha = 0.5;
    [self.view addSubview:lineLab1];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.85, 86, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"che"] forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;
    [self.view addSubview:btn];
    
    
    
    NSString * url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Content_URL,1]];
    NSLog(@"地址------>>>>%@",url);
   
    [Tools POST:url params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj[@"data"]);
         if ([responseObj[@"data"][@"type"] isEqualToNumber:@1]) {
             
             NSDictionary *dict = responseObj[@"data"];
      
             
             UILabel *ruleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 125, KSCREENWIDTH-20, 300)];
             ruleLab.textColor = [UIColor grayColor];
             ruleLab.numberOfLines = 0;
             ruleLab.text = dict[@"content"];
             [self.view addSubview:ruleLab];
        
             
         } else {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请检查您的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alert show];
             
         }
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];

    

    
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
