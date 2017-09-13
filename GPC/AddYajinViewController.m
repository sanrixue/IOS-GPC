//
//  AddYajinViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/19.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "AddYajinViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AddYajinViewController ()<UIAlertViewDelegate> {
    UIButton *_weixinBtn;
    UIButton *_zhifubaoBtn;
    
    UIButton *_weixinBtn1;
    UIButton *_zhifubaoBtn1;
}

@end

@implementation AddYajinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"押金充值";
    
    
//    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"qianbaoback"]];
//    [ self.view setBackgroundColor:bgColor];
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"qianbaoback"]];
    [self.view addSubview:bkImage];
    
    [self setUpUI];
}

- (void)setUpUI {
    UIView *_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 180)];
    _headerView.backgroundColor = COLOR(180, 235, 240, 1);
    
    [self.view addSubview:_headerView];
    
    
    //添加线
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    [self.view addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerView.mas_centerX);
        make.top.mas_equalTo(_headerView.mas_top).offset(120);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH * 0.8, 1));
    }];

    //添加button
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 110, 70, 20)];
    btn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    [btn setTitle:@"手机绑定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 10;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:btn];
    
    UIButton *_btn1 = [[UIButton alloc] init];
    _btn1.userInteractionEnabled = NO;
    _btn1.backgroundColor = [UIColor clearColor];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"实"] forState:UIControlStateNormal];
    [_btn1 setTitle:@"押金充值" forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0]forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    _btn1.layer.cornerRadius = 10;
    _btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_btn1];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineLab.mas_centerY);
        make.left.mas_equalTo(btn.mas_right).offset((KSCREENWIDTH - 320)/3);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
   
    
    UIButton *_btn2 = [[UIButton alloc] init];
    _btn2.backgroundColor = [UIColor clearColor];
    _btn2.userInteractionEnabled = NO;
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"虚"] forState:UIControlStateNormal];
    [_btn2 setTitle:@"实名认证" forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0]forState:UIControlStateNormal];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    _btn2.layer.cornerRadius = 10;
    _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_btn2];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineLab.mas_centerY);
        make.left.mas_equalTo(_btn1.mas_right).offset((KSCREENWIDTH - 320)/3);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
  
    
    UIButton *_btn3 = [[UIButton alloc] init];
    _btn3.backgroundColor = [UIColor clearColor];
    _btn3.userInteractionEnabled = NO;
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"虚"] forState:UIControlStateNormal];
    [_btn3 setTitle:@"开始用车" forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0]forState:UIControlStateNormal];
    _btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    _btn3.layer.cornerRadius = 10;
    _btn3.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_btn3];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineLab.mas_centerY);
        make.left.mas_equalTo(_btn2.mas_right).offset((KSCREENWIDTH - 320)/3);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];

    
    [self addLableText:@"充值金额￥299" Frame:CGRectMake(KSCREENWIDTH *0.1, 250, KSCREENWIDTH *0.8, 30) Font:20];


    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"押金(可退)";
    lab.frame = CGRectMake(KSCREENWIDTH *0.1, 270, KSCREENWIDTH *0.8, 20);
    lab.font = [UIFont systemFontOfSize:14];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lab];
    
    [self addLableText:@"* 押金可原路退还" Frame:CGRectMake(KSCREENWIDTH *0.1, 430, KSCREENWIDTH *0.8, 30) Font:14];

    [self addLableText:@"* 首次缴纳押金可获1元车费" Frame:CGRectMake(KSCREENWIDTH *0.1, 470, KSCREENWIDTH *0.8, 30) Font:14];

    
    
    //微信button
    _weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _weixinBtn.backgroundColor = [UIColor clearColor];
    _weixinBtn.frame = CGRectMake(KSCREENWIDTH*0.1, 300, KSCREENWIDTH*0.8, 40);
    [_weixinBtn setTitle:@"               微信" forState:UIControlStateNormal];
    [_weixinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_weixinBtn addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weixinBtn];
    _weixinBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _weixinBtn.backgroundColor = [UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0];
    _weixinBtn.tag = 3000;
    
    
    //支付宝button
    _zhifubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _zhifubaoBtn.backgroundColor = [UIColor clearColor];
    _zhifubaoBtn.frame=CGRectMake(KSCREENWIDTH*0.1, 360, KSCREENWIDTH*0.8, 40);
    _zhifubaoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_zhifubaoBtn setTitle:@"              支付宝" forState:UIControlStateNormal];
    [_zhifubaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_zhifubaoBtn addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zhifubaoBtn];
    _zhifubaoBtn.backgroundColor = [UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0];
    _zhifubaoBtn.tag = 4000;
    
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.15, 305, 30, 30)];
    image1.image = [UIImage imageNamed:@"微信"];
    [self.view addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.15, 365, 30, 30)];
    image2.image = [UIImage imageNamed:@"支付宝"];
    [self.view addSubview:image2];
    
    
    _weixinBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.75, 310, 20, 20)];
    _weixinBtn1.backgroundColor = [UIColor clearColor];
    _weixinBtn1.tag = 3001;
    [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateHighlighted];
    [_weixinBtn1 addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weixinBtn1];
    
    _zhifubaoBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.75, 370, 20, 20)];
    _zhifubaoBtn1.backgroundColor = [UIColor clearColor];
    _zhifubaoBtn1.tag = 4001;
    [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateHighlighted];
    [_zhifubaoBtn1 addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zhifubaoBtn1];
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, 520, KSCREENWIDTH * 0.7, 35);
    [PUTBtn setTitle:@"充值" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];
}

- (void)turnBtnEvent:(UIButton *)button
{
    if (button.tag == 3000) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    } else if (button.tag == 4000) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    } else if (button.tag == 3001) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    } else if (button.tag == 4001) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    }
    
}

- (void)PUTBtnClick {
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    
    NSData *data1 = UIImageJPEGRepresentation(_weixinBtn1.currentBackgroundImage, 1);
    NSData *data2 = UIImageJPEGRepresentation([UIImage imageNamed:@"对勾"], 1);
    
    if ([data1 isEqual:data2]) {
         NSLog(@"微信充值");
        
        [[DBManager sharedManager]upadteUserModelModelStatus:@"2" FromModelId:userModel.user_id];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"充值成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    } else {
        NSLog(@"支付宝充值");
        
        [self doAlipayPay];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark   ==============点击订单支付==============
//
//选中商品调用支付宝极简支付
//
- (void)doAlipayPay
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2016080901725395";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALbQyABUSxUbSdJ/jHv3SskEoKd3UTDuL49bcdbmkrSKsmMPMnpuEC7c8wsn01ECxyyHQfg7+BGbQRIwLmbr9bnm1j2nI63oMr+eRksYt+4l9DjFeFJ8KlrwXTOzNWVPDpv7Akzo62NasA6fAkBx2w1k6bwmr+Hnu3QjxqFAMewvAgMBAAECgYAf2nLus8E9VTrgpX653tW1/strQnvwFaBNzzYfpp8rO/tnDS/TazgAoljqua61L9G6bXrOIMzRbIbC/4gmQLjYtvclOPY2rKhYAayZXUb46Rmx2UQxkejEFyLqOeqw1EMPHQywJyHz9Dn3JUjlsdEXM1SFUwAc/jlXgQzVEnBDeQJBAN7E4tbgH9+qLxrIIAzSI/cVjLCzK4ZeNzfKnCVS2h4VPKA5aZZ8l0xg7ymIMdBAzLkPU1v2n9HptzZ9sf+LExUCQQDSFiXs3EeYr47r5+qpmy0GnVKWFKcgQETQM69pXdpJKp48oss/jcckZLQt8AC3MldZg+ctYP7dvg92y0wJrGMzAkEAw0fAujBagI0FIesQ/WwxDuYbIMLPgsiQix3XZ3iLsBdZv/LUNpEdaF0JClVTpYVIcWmX32QAkdjZPLFPGf5mSQJANJxPSw2u8FGmnPUrEuZFVE65i9QINk9h7DHFT8GtFH2TuuOZuoSqxjZh2M8tnrMApO4fSoHr0WPzQ3CNzi5ZeQJBAJhTCoViJRSMH0ywMxT7p1B3Bi2IkKnoTWcPHjTNWZLkr/Sfsu6YjLGj3200kkkkQZScL2qBYLrg9DEU9Vi3gmw=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"钱包充值";
    order.biz_content.subject = [self generateTradeNO];
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"GPC";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}


//商家订单
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}



- (void)addLableText:(NSString *)text Frame:(CGRect)frame Font:(CGFloat) font {
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text;
    lab.frame = frame;
    lab.font = [UIFont systemFontOfSize:font];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lab];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
