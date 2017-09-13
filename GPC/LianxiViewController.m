//
//  LianxiViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/23.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "LianxiViewController.h"

@interface LianxiViewController ()

@end

@implementation LianxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"联系我们";
    
    
    
    
    [self addImageName:@"logo" Frame:CGRectMake(KSCREENWIDTH * 0.3, 80, KSCREENWIDTH*0.4, KSCREENWIDTH*0.4)];
    
    [self addImageName:@"lianxi1" Frame:CGRectMake(KSCREENWIDTH * 0.25, 235, 45, 45)];
    
    [self addImageName:@"lianxi4" Frame:CGRectMake(KSCREENWIDTH * 0.25, 295, 45, 45)];
    
    [self addImageName:@"lianxi2" Frame:CGRectMake(KSCREENWIDTH * 0.25, 355, 45, 45)];
    
    [self addImageName:@"lianxi3" Frame:CGRectMake(KSCREENWIDTH * 0.25, 415, 45, 45)];
    

//    [self addLabelName:@"联系电话\n12345678945" Frame:CGRectMake(KSCREENWIDTH * 0.3+50, 230, 150, 50)];
//    [self addLabelName:@"官方网站\nwww.GPC.com" Frame:CGRectMake(KSCREENWIDTH * 0.3+50, 290, 150, 50)];
//    [self addLabelName:@"电子邮箱\ncontact@PGC.com" Frame:CGRectMake(KSCREENWIDTH * 0.3+50, 350, 150, 50)];
//    [self addLabelName:@"微信账号\n12345678945" Frame:CGRectMake(KSCREENWIDTH * 0.3+50, 410, 150, 50)];
    
    NSString * url = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Content_URL,9]];
    NSLog(@"地址------>>>>%@",url);
    
    [Tools POST:url params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj[@"data"]);
         if ([responseObj[@"data"][@"type"] isEqualToNumber:@9]) {
             
            [self addLabelName:[NSString stringWithFormat:@"电子邮箱\n%@",responseObj[@"data"][@"content"]] Frame:CGRectMake(KSCREENWIDTH * 0.25+50, 350, 250, 50)];
             
            
         } else {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请检查您的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alert show];
             
         }
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];
    
    NSString * url2 = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Content_URL,8]];
    NSLog(@"地址------>>>>%@",url2);
    
    [Tools POST:url2 params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj[@"data"]);
         if ([responseObj[@"data"][@"type"] isEqualToNumber:@8]) {
             
               [self addLabelName:[NSString stringWithFormat:@"官方网站\n%@",responseObj[@"data"][@"content"]] Frame:CGRectMake(KSCREENWIDTH * 0.25+50, 290, 250, 50)];
             
             
         } else {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请检查您的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alert show];
             
         }
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];

    NSString * url3 = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Content_URL,10]];
    NSLog(@"地址------>>>>%@",url3);
    
    [Tools POST:url3 params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj[@"data"]);
         if ([responseObj[@"data"][@"type"] isEqualToNumber:@10]) {
             
             [self addLabelName:[NSString stringWithFormat:@"微信账号\n%@",responseObj[@"data"][@"content"]] Frame:CGRectMake(KSCREENWIDTH * 0.25+50, 410, 250, 50)];
             
             
         } else {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请检查您的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alert show];
             
         }
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];
    
    NSString * url4 = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:Content_URL,6]];
    NSLog(@"地址------>>>>%@",url4);
    
    [Tools POST:url4 params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj[@"data"]);
         if ([responseObj[@"data"][@"type"] isEqualToNumber:@6]) {
             
             [self addLabelName:[NSString stringWithFormat:@"联系电话\n%@",responseObj[@"data"][@"content"]] Frame:CGRectMake(KSCREENWIDTH * 0.25+50, 230, 250, 50)];
             
             
         } else {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请检查您的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alert show];
             
         }
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];
    


}

- (void)addImageName:(NSString *)name Frame:(CGRect)frame {
    UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
    image.image = [UIImage imageNamed:name];
    [self.view addSubview:image];
}

- (void)addLabelName: (NSString *)name Frame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.numberOfLines = 2;
    label.textColor = [UIColor grayColor];
    label.text = name;
    [self.view addSubview:label];
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
