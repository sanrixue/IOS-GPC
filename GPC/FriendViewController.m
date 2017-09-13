//
//  FriendViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "FriendViewController.h"
#import "UMSocial.h"

@interface FriendViewController ()<UMSocialUIDelegate>

@property(nonatomic,strong)UIView * Share_View;            //分享视图

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"邀请好友";
    
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT-KSCREENWIDTH*0.2-60, KSCREENWIDTH, 30)];
    lab.text = @"-------------------分享到-------------------";
    lab.textColor = [UIColor grayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    

    _Share_View = [[UIView alloc]initWithFrame:CGRectMake(0, KSCREENHEIGHT-KSCREENWIDTH*0.2-30, KSCREENWIDTH, KSCREENWIDTH*0.2+30)];
    _Share_View.backgroundColor = [UIColor whiteColor];
    _Share_View.alpha = 1.0;
    [self.view addSubview:_Share_View];

    float Button_Width = 60*KSCREENWIDTH/375;
    for (int i=0; i<3; i++)
    {
        UIButton * Share_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        Share_Btn.frame = CGRectMake(i*Button_Width + (i+1)*(KSCREENWIDTH/4-0.75*Button_Width), 10, Button_Width, Button_Width);
        Share_Btn.backgroundColor = [UIColor whiteColor];
        [Share_Btn setBackgroundImage:[UIImage imageNamed:@[@"QQ",@"微博",@"微信分享"][i]] forState:UIControlStateNormal];
        Share_Btn.layer.cornerRadius = Button_Width/2;
        Share_Btn.layer.masksToBounds = YES;
        Share_Btn.tag = i+1;
        [Share_Btn addTarget:self action:@selector(TouchShareButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_Share_View addSubview:Share_Btn];
        
        UILabel * name_label = [[UILabel alloc]init];
        name_label.frame = CGRectMake(i*Button_Width + (i+1)*(KSCREENWIDTH/4-0.75*Button_Width), CGRectGetMaxY(Share_Btn.frame)+5, Button_Width, 20);
        
        name_label.text = @[@"QQ",@"微博",@"微信"][i];
        name_label.textAlignment = NSTextAlignmentCenter;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>7.0)
        {
            name_label.font = [UIFont systemFontOfSize:14];
        }
        else
        {
            name_label.font = [UIFont systemFontOfSize:12];
        }
        name_label.textColor = COLOR(82, 81, 94, 1.0);
        [_Share_View addSubview:name_label];
    }
}


#pragma mark - 点击分享按钮
-(void)TouchShareButton:(UIButton *)sender
{
    if (sender.tag==1)
    {
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:[UIImage imageNamed:@"loading58x58"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                [self didFinishGetUMSocialDataInViewController:response];
            }
        }];
    }
    if (sender.tag==2)
    {
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享文字内容" image:[UIImage imageNamed:@"loading58x58"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                [self didFinishGetUMSocialDataInViewController:response];
            }
        }];
    }
    if (sender.tag==3)
    {
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:
         [UIImage imageNamed:@"loading58x58"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse)
         {
             if (shareResponse.responseCode == UMSResponseCodeSuccess)
             {
                 [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina completion:^(UMSocialResponseEntity *response){ NSLog(@"SnsInformation is %@",response.data); }];
                 //  [self didFinishGetUMSocialDataInViewController:shareResponse];
             }
         }];
    }
    
}

///回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"分享成功的平台名称----->>>> %@",[[response.data allKeys] objectAtIndex:0]);
    }
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
