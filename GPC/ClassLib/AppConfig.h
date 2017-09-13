//
//  AppConfig.h
//  MaiDeQi
//
//  Created by Peter on 15/2/4.
//  Copyright (c) 2015年 董立峥. All rights reserved.
//

#ifndef MaiDeQi_AppConfig_h
#define MaiDeQi_AppConfig_h


 
//XMPP 配置
#define  XMPP_PORT 5222
#define  XMPP_IP_ADDRESS @""
#define  ServerRouterName  @""

#define backBarButton [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]
 
//系统通用宏
#define BFLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"Gfeng"]

#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ScreenMiddle (DEVICE_HEIGHT-64-self.tabBarController.tabBar.frame.size.height)
#define ScreenSubViewHight (DEVICE_HEIGHT-64)
#define ScreenMiddle_iPhone5 455  //iphone5 除去navi 和 tabBar的高度
#define DeviceIsIphone5 ([UIScreen mainScreen].bounds.size.height == 568?YES:NO)
#define DeviceIsIOS7 ([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0? YES:NO)
#define SystemAppDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate
#define safeSet(d,k,v) if (v) d[k] = v;

#define Back_W  11
#define Back_H  30
/**
 *  Get App name
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**
 *  Get App build
 */
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/**
 *  Get App version
 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *  Get AppDelegate
 */
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//  主要单例
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]



//设置加载图片 颜色
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define loadImage(Name)  [UIImage   imageNamed:Name]

#define LineColor COLOR(223, 223, 223, 1)  //常用灰色线条的颜色
#define CommonBlueColor COLOR(0, 155, 200, 1) //整体蓝


//屏幕高度
#define   KNagHEIGHT  self.navigationController.navigationBar.bounds.size.height-20
#define   KSCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define   KSCREENHEIGHT  [UIScreen mainScreen].bounds.size.height



//颜色设置
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFormRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define backBarButton [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]
 

//友推AppKey
#define YOUTUIAPPKEY @""
#define YOUTUIAPPSECRET @""

//Mob  appkey
#define YOUMAPPKEY @""

#define MobAppKey @""

//新浪
#define SinaWBAppKey @"1286413555"
#define SinaWBAppSecret @"bdd6c291a56622a9ce2709a8057273ce"
#define SinaURI @"http://www.sharesdk.cn"

//微信
#define WXAppId @"wxad58e80778f06ffc"
#define WXAppSecret @"d4624c36b6795d1d99dcf0547af5443d"

//QQ
#define QQAppID @"1104839328"
#define QQAppKey @"JpaAHdKf9ZTsiBaa"

//腾讯
#define TencentWeiboAppKey @"801307650"
#define TencentWeiboAppSecret @"ae36f4ee3946e1cbb98d6965b0b2ff5c"
#define TencentWeiboURI @"http://www.sharesdk.cn"



#define UserInfo @"UserInfo"
#define UserImgUrl @"UserImgUrl"
#define UserId	@"id"
#define UserInfoTds @"UserInfoTds"







/****************************请求地址*******************************/

//根URL
#define Main_URL @"http://mcc.shlantian.cn:8081/gpc/%@"

//登录接口
#define Login_URL @"app_login"

//验证码接口
#define Verification_URL @"get_yzm?phone=%@"


//首页自行车搜索
#define Bycicle_URL @"to_LatLng?lat=%f&lng=%f"

//用户意见反馈
#define Fankui_URL @"contentInsert?uid=%@&content=%@"


//修改个人信息
#define Upadta_URL @"userUpdata"

//我的行程
#define Record_URL @"record"

//行程详情
#define Details_URL @"record_details"

//实名认证
#define Realname_URL @"authenticationAdd"


//查询（1、信用积分解读 2、用户指南 3、意见反馈 4、版本更新 5、联系我们 6、关于我们  7、扫码使用说明）uid只有意见反馈的有
#define Content_URL @"contentByType?type=%d"

//积分列表
#define ScoreAll_URL @"scoreAll"

//积分总和
#define ScoreSum_URL @"scoreSum?uid=%@"

//故障提交
#define Fault_URL @"faultAdd"

//钱包明细
#define Mingxi_URL @"moneyListByUid"

//我的消息
#define Message_URL @"messageSee"

#endif

