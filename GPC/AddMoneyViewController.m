//
//  AddMoneyViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/19.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "AddMoneyViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AddMoneyViewController ()<UIAlertViewDelegate> {
    UIButton *_weixinBtn;
    UIButton *_zhifubaoBtn;
    
    UIButton *_weixinBtn1;
    UIButton *_zhifubaoBtn1;
    
    NSString *_money;
    
    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
    UIButton *_btn4;
    UIButton *_btn5;
    UIButton *_btn6;
    
    UITextField *_moneyText;
}

@end

@implementation AddMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"钱包充值";
    
//    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"qianbaoback"]];
//    [ self.view setBackgroundColor:bgColor];
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"qianbaoback"]];
    [self.view addSubview:bkImage];
    
    _money = [[NSString alloc] init];
    _money = @"10.00";
    
    [self setUpUI];
}

- (void)setUpUI {
    
    _btn1 = [[UIButton alloc] init];
    [self addBtn:_btn1 Title:@"10元" Frame:CGRectMake(KSCREENWIDTH *0.25-45, 100, 60, 35)];
    _btn1.tag = 21;
    [_btn1.layer setBorderColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0].CGColor];
    [_btn1 setTitleColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:_btn1];
    
    _btn2 = [[UIButton alloc] init];
    [self addBtn:_btn2 Title:@"20元" Frame:CGRectMake(KSCREENWIDTH *0.5-30, 100, 60, 35)];
    _btn2.tag = 41;
    [self.view addSubview:_btn2];
    
    _btn3 = [[UIButton alloc] init];
    [self addBtn:_btn3 Title:@"50元" Frame:CGRectMake(KSCREENWIDTH *0.75-15, 100, 60, 35)];
    _btn3.tag = 101;
    [self.view addSubview:_btn3];
    
    _btn4 = [[UIButton alloc] init];
    [self addBtn:_btn4 Title:@"100元" Frame:CGRectMake(KSCREENWIDTH *0.25-45, 150, 60, 35)];
    _btn4.tag = 201;
    [self.view addSubview:_btn4];
    
    _btn5 = [[UIButton alloc] init];
    [self addBtn:_btn5 Title:@"150元" Frame:CGRectMake(KSCREENWIDTH *0.5-30, 150, 60, 35)];
    _btn5.tag = 301;
    [self.view addSubview:_btn5];
    
    _btn6 = [[UIButton alloc] init];
    [self addBtn:_btn6 Title:@"200元" Frame:CGRectMake(KSCREENWIDTH *0.75-15, 150, 60, 35)];
    _btn6.tag = 401;
    [self.view addSubview:_btn6];
    
    
    _moneyText = [[UITextField alloc] initWithFrame:CGRectMake(KSCREENWIDTH *0.25-45, 200, KSCREENWIDTH*0.5+90, 35)];
    _moneyText.layer.borderColor = [UIColor whiteColor].CGColor;
    _moneyText.layer.borderWidth = 1.2;
    _moneyText.placeholder = @"输入其他金额";
    [_moneyText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _moneyText.textAlignment = NSTextAlignmentCenter;
    _moneyText.keyboardType = UIKeyboardTypeNumberPad;
    _moneyText.textColor = [UIColor whiteColor];
    [self.view addSubview:_moneyText];
    
    
    
    
    
    [self addLableText:@"点击充值，表示已阅读并同意《充值协议》" Frame:CGRectMake(KSCREENWIDTH *0.1, 420, KSCREENWIDTH *0.8, 30) Font:14];
    
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
    _weixinBtn.tag = 5000;
    
    
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
    _zhifubaoBtn.tag = 6000;
    
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.15, 305, 30, 30)];
    image1.image = [UIImage imageNamed:@"微信"];
    [self.view addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.15, 365, 30, 30)];
    image2.image = [UIImage imageNamed:@"支付宝"];
    [self.view addSubview:image2];
    
    
    _weixinBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.75, 310, 20, 20)];
    _weixinBtn1.backgroundColor = [UIColor clearColor];
    _weixinBtn1.tag = 5001;
    [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateHighlighted];
    [_weixinBtn1 addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weixinBtn1];
    
    _zhifubaoBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH*0.75, 370, 20, 20)];
    _zhifubaoBtn1.backgroundColor = [UIColor clearColor];
    _zhifubaoBtn1.tag = 6001;
    [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateHighlighted];
    [_zhifubaoBtn1 addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zhifubaoBtn1];
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, 460, KSCREENWIDTH * 0.7, 35);
    [PUTBtn setTitle:@"充值" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];
}


- (void)addBtn:(UIButton *)btn Title:(NSString *)title Frame:(CGRect) frame {
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setBorderColor:[UIColor whiteColor].CGColor];
    btn.layer.borderWidth = 1.2;
    
}

- (void)chooseBtnClick:(UIButton *) button {
   
    if (button.tag == 21) {
      
        [_btn1.layer setBorderColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0].CGColor];
        [_btn1 setTitleColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn4.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn5.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn6.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if (button.tag == 41) {
        [_btn2.layer setBorderColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0].CGColor];
        [_btn2 setTitleColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0] forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn4.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn5.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn6.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if (button.tag == 101) {
        [_btn3.layer setBorderColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0].CGColor];
        [_btn3 setTitleColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn4.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn5.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn6.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if (button.tag == 201) {
        [_btn4.layer setBorderColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0].CGColor];
        [_btn4 setTitleColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn5.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn6.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if (button.tag == 301) {
        [_btn5.layer setBorderColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0].CGColor];
        [_btn5 setTitleColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn4.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn6.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if (button.tag == 401) {
        [_btn6.layer setBorderColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0].CGColor];
        [_btn6 setTitleColor:[UIColor colorWithRed:11.0/255 green:173.0/255 blue:165.0/255 alpha:1.0] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn4.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn5.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    _money = [NSString stringWithFormat:@"%0.2f",button.tag/2.0 - 0.5];
    
}



- (void)turnBtnEvent:(UIButton *)button
{
    if (button.tag == 5000) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    } else if (button.tag == 6000) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    } else if (button.tag == 5001) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    } else if (button.tag == 6001) {
        [_weixinBtn1 setBackgroundImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        [_zhifubaoBtn1 setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    }
    
}

- (void)PUTBtnClick {
    if (_moneyText.text.length >0) {
        _money = _moneyText.text;
    }
    
    NSData *data1 = UIImageJPEGRepresentation(_weixinBtn1.currentBackgroundImage, 1);
    NSData *data2 = UIImageJPEGRepresentation([UIImage imageNamed:@"对勾"], 1);
    
    if ([data1 isEqual:data2]) {
        NSLog(@"微信充值");
        
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
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
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
