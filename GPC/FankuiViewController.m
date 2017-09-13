//
//  FankuiViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/23.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "FankuiViewController.h"
#import "DBManager.h"
#import "UserModel.h"

@interface FankuiViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *addLable;

@end

@implementation FankuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.11, 90, KSCREENWIDTH * 0.78, 140)];
    textView.font = [UIFont systemFontOfSize:16];
    textView.textColor = [UIColor blackColor];
    textView.backgroundColor = [UIColor clearColor];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.delegate = self;
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 1;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(KSCREENWIDTH * 0.2, 140, KSCREENWIDTH * 0.6, 40)];
    lab2.enabled = NO;
    lab2.text = @"请输入你的宝贵意见，我们会努力为你改正～";
    lab2.numberOfLines = 0;
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.backgroundColor = [UIColor clearColor];
    lab2.font =  [UIFont systemFontOfSize:16];
    lab2.textColor = [UIColor lightGrayColor];
    [self.view addSubview:lab2];
    self.addLable = lab2;
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, 250, KSCREENWIDTH * 0.7, KSCREENWIDTH * 0.125 -10);
    [PUTBtn setTitle:@"提交" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];

}


- (void) textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        [self.addLable setHidden:NO];
    }else{
        [self.addLable setHidden:YES];
    }
}

- (void)PUTBtnClick {
    NSLog(@"提交");
    
    if (_textView.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"意见不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    } else if (_textView.text.length > 0){
    
    
        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
    
        
        NSString *fankui = [NSString stringWithFormat:Fankui_URL,[NSString stringWithFormat:@"%@",userModel.user_id],_textView.text];
    
        NSString * url = [NSString stringWithFormat:Main_URL,fankui];
        NSLog(@"地址------>>>>%@",url);

        [Tools POST:url params:nil superviewOfMBHUD:nil success:^(id responseObj)
         {
             NSLog(@"请求成功---->>>>%@",responseObj);
             if ([responseObj[@"code"] isEqualToString:@"200"]) {
             
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"反馈成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                 alert.tag = 100;
             
                 [alert show];
             
             } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"反馈失败"     delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                 [alert show];
             }
         
         } failure:^(NSError *error) {
         
             NSLog(@"请求出错--->>>%@",error);
         }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100) {
        [self.navigationController popViewControllerAnimated:YES];
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
