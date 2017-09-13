//
//  LoginViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/26.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "LoginViewController.h"
#import "CreatControls.h"
#import "ViewController.h"
#import "UserModel.h"
#import "DBManager.h"

@interface LoginViewController ()<UIAlertViewDelegate>{
    UITextField *_phone;
    UITextField *_test;
    
    BOOL isPhone;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"login.jpg"]];
    [self.view addSubview:bkImage];
    
    
    [self setUpUI];
    
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    UIImageView *image = [[UIImageView alloc] init];
    [creatControls image:image Name:@"logo.png" Frame:CGRectMake(KSCREENWIDTH * 0.35,  KSCREENHEIGHT* 0.2, KSCREENWIDTH * 0.3, KSCREENWIDTH * 0.3)];
    [self.view addSubview:image];
    
    _phone = [[UITextField alloc] init];
    [creatControls text:_phone Title:@"请输入手机号" Frame:CGRectMake(KSCREENWIDTH * 0.2,  KSCREENHEIGHT* 0.55, KSCREENWIDTH * 0.6, 40) Image:[UIImage imageNamed:@"phone"]];
    [self.view addSubview:_phone];
    _phone.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    [_phone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    _test = [[UITextField alloc] init];
    [creatControls text:_test Title:nil Frame:CGRectMake(KSCREENWIDTH * 0.2,  KSCREENHEIGHT* 0.55 + 65, KSCREENWIDTH * 0.6, 40) Image:[UIImage imageNamed:@"test"]];
    [self.view addSubview:_test];
    _test.keyboardType = UIKeyboardTypeNumberPad;
    _test.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];

    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH * 0.2,  KSCREENHEIGHT* 0.55 + 120, KSCREENWIDTH * 0.6, 50);
    [PUTBtn setTitle:@"开始" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PUTBtn setBackgroundImage:[UIImage imageNamed:@"kaishi"] forState:UIControlStateNormal];
    PUTBtn.layer.cornerRadius = 10;
    [self.view addSubview:PUTBtn];
    
    UIButton *testBtn = [[UIButton alloc] init];
    testBtn.frame = CGRectMake(KSCREENWIDTH * 0.8-80,  KSCREENHEIGHT* 0.55 + 57, 80, 55);
    [testBtn setTitle:@"获取验证" forState:UIControlStateNormal];
    testBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [testBtn addTarget:self action:@selector(testBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [testBtn setBackgroundImage:[UIImage imageNamed:@"kaishi"] forState:UIControlStateNormal];
    testBtn.layer.cornerRadius = 15;
    [self.view addSubview:testBtn];
    
    
    UIButton *tiaokuanBtn = [[UIButton alloc] init];
    tiaokuanBtn.frame = CGRectMake(KSCREENWIDTH * 0.1,  KSCREENHEIGHT* 0.55 + 160, KSCREENWIDTH * 0.8, 55);
    [tiaokuanBtn setTitle:@"点击开始，表示已阅读并同意《用车服务条款》" forState:UIControlStateNormal];
    tiaokuanBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    tiaokuanBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tiaokuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tiaokuanBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [tiaokuanBtn addTarget:self action:@selector(tiaokuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tiaokuanBtn];
    
}

- (void)tiaokuanBtnClick {
    NSLog(@"条款");
}

- (void)testBtnClick:(UIButton *)sender {
    NSLog(@"获取验证");
    
    isPhone = [Tools isMobileNumber:_phone.text];
    
    if (isPhone==YES)
    {
        NSString * urlStr = [NSString stringWithFormat:Verification_URL,_phone.text];
        NSString * url = [NSString stringWithFormat:Main_URL,urlStr];
        
        [Tools POST:url params:nil superviewOfMBHUD:self.view success:^(id responseObj) {
            NSLog(@"请求成功----->>>>%@",responseObj);
            
            [self showMessegeForResult:responseObj[@"msg"]];
            __block int timeout=60;//倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^
                                              {
                                                  if(timeout<=0)
                                                  { //倒计时结束，关闭
                                                      dispatch_source_cancel(_timer);
                                                      dispatch_async(dispatch_get_main_queue(), ^
                                                                     {
                                                                         //设置界面的按钮显示 根据自己需求设置
                                                                         [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                                                                         sender.userInteractionEnabled = YES;
                                                                         [sender setBackgroundColor:[UIColor clearColor]];
                                                                     });
                                                  }
                                                  else
                                                  {
                                                      int seconds = timeout % 130;
                                                      NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                                                      dispatch_async(dispatch_get_main_queue(), ^
                                                                     {
                                                                         //设置界面的按钮显示 根据自己需求设置
                                                                         //NSLog(@"____%@",strTime);
                                                                         [UIView beginAnimations:nil context:nil];
                                                                         [UIView setAnimationDuration:0.5];
                                                                         [sender setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                                                                         [sender setBackgroundColor:[UIColor clearColor]];
                                                                         [UIView commitAnimations];
                                                                         sender.userInteractionEnabled = NO;
                                                                     });
                                                      timeout--;
                                                  }
                                                  
                                              });
            dispatch_resume(_timer);
            
            
        } failure:^(NSError *error) {
            NSLog(@"请求失败------>>>%@",error);
        }];
    }
    else
    {
        [self showMessegeForResult:@"请输入正确手机号"];
    }
    
    
    
}

- (void)PUTBtnClick {
    NSLog(@"开始");
    
    NSDictionary * loginDic = @{@"phone":_phone.text,@"code":_test.text};
    NSString * url = [NSString stringWithFormat:Main_URL,Login_URL];
    NSLog(@"地址------>>>>%@",url);
    NSLog(@"参数是：%@",loginDic);
    [Tools POST:url params:loginDic superviewOfMBHUD:nil success:^(id responseObj)
     {
         NSLog(@"登录成功---->>>>%@",responseObj[@"data"]);
         if ([responseObj[@"msg"]isEqualToString:@"登录成功"]) {
        
             NSDictionary *dict = responseObj[@"data"];
             UserModel *userModel = [UserModel userWithDict:dict];
             [[DBManager sharedManager] insertUserModel:userModel];

             
             ViewController *VC = [[ViewController alloc] init];
             
             [self.navigationController pushViewController:VC animated:YES];
            
         } else {
             
             [self showMessegeForResult:@"您的验证码不正确"];
             
         }
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];
}

#pragma mark - 输入提示错误提示
- (void)showMessegeForResult:(NSString *)messege
{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>7.0)
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:messege preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^
         {
             [self performSelector:@selector(dismissAlertViewEvent:) withObject:alert afterDelay:1];
         }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:messege delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
    }
}
- (void)dismissAlertViewEvent:(id)alert
{
    if([alert isKindOfClass:[UIAlertController class]])
    {
        [alert dismissViewControllerAnimated:YES completion:^
         {
         }];
    }
    else
    {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


//点击Return键，键盘下调
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return nil;
    
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
