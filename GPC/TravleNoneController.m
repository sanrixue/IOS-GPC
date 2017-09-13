//
//  TravleNoneController.m
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "TravleNoneController.h"
#import "DBManager.h"

@interface TravleNoneController ()

@end

@implementation TravleNoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的行程";
    
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"qianbaoback"]];
    [self.view addSubview:bkImage];
    
    
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.layer.cornerRadius = 100*0.5;
    icon.layer.masksToBounds = YES;
    icon.layer.borderWidth = 4;
    icon.layer.borderColor = [UIColor whiteColor].CGColor;
    icon.frame = CGRectMake(0, 0, 100, 100);
    icon.center = self.view.center;
    [self.view addSubview:icon];
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    NSLog(@"%@",userModel.user_logo);
    
    //读取图片
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",userModel.user_id]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    if (image) {
        icon.image = image;
        
    } else if ([[NSString stringWithFormat:@"%@",userModel.user_logo] isEqualToString:@"(null)"]) {
        icon.image = [UIImage imageNamed:@"default.jpg"];
        
    } else {
        [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,userModel.user_logo]]];
    }

    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.15, KSCREENHEIGHT * 0.5 + 80, KSCREENWIDTH*0.7, 20)];
    lab.text = @"您还没有行车记录";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lab];

    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.15, KSCREENHEIGHT * 0.5 + 110, KSCREENWIDTH*0.7, 20)];
    lab2.text = @"快来体验GPC单车吧!";
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.textColor = [UIColor whiteColor];
    lab2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lab2];
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
