//
//  GuanyuViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/23.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "GuanyuViewController.h"

@interface GuanyuViewController ()

@end

@implementation GuanyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于GPC";
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.3, 80, KSCREENWIDTH*0.4, KSCREENWIDTH*0.4)];
    logo.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logo];
    
    
    NSString * url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Content_URL,6]];
    NSLog(@"地址------>>>>%@",url);
    
    [Tools POST:url params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj[@"data"]);
         if ([responseObj[@"data"][@"type"] isEqualToNumber:@6]) {
             
             NSDictionary *dict = responseObj[@"data"];
             
             
             UILabel *ruleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, KSCREENWIDTH-20, 300)];
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
