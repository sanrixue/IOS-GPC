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
#define YOUMAPPKEY @"5660fff767e58ebb3b007811"

#define MobAppKey @"cfdc3f9725ac"

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

// ** 根URL
#define Main_URL @"http://121.43.108.95:8081/water/%@"

// ** 登录接口
#define Login_URL @"app_login"

// ** 验证码接口
#define Verification_URL @"hq_yzm?mobile=%@"

// ** 注册接口
#define Registered_URL @"app_reg"

// ** 忘记密码接口
#define Forget_URL @"app_zhaohui_pwd"

// ** 首页文章刷新
#define HOME_URL @"app_article_admin?page=%d&type=2"

// ** 首页搜索文章
#define Search_Url @"app_article_admin"



// ** 帮助与反馈
//帮助接口
#define help_URL @"app_help_feedback"
//反馈接口
#define feedback_URL @"app_feedback"




// ** 修改个人信息接口
#define Modify_URL @"app_update_userinfo"



// ** 系统通知
#define customer_url @"app_content_select?type=1"

// ** 布水圈子的文章，所有的文章接口     
#define All_circle_URL @"app_article_admin?page=%d&type=1"

// ** 我的收藏接口
#define Collection_URL @"my_shoucang"

// ** 我的发布接口
#define Releas_URL @"my_fabu"




// ** 发布圈子
#define AddArticle_URL @"app_addArticle"



// ** 文章详情页看的H5接口      传入文章的唯一ID  和自己的USER id
#define HTML_HOME_INFO @"http://121.43.108.95:8081/water/view/appH5/article.html?id=%@&uid=%@"

// ** 布水圈子详情页面的H5接口   传入文章的唯一ID  和自己的USER id
#define HTML5_INFO @"http://121.43.108.95:8081/water/view/appH5/home3.html?id=%@&uid=%@"


// ** 收藏文章接口
#define Collection_the_url @"app_addData"


// ** 系统通知
#define NOTICE @"app_tz_xitong"



// ** 文章评论列表接口
#define Collection_info_URL @"app_comment_page"

// ** 评论文章的接口
#define pinglun_URL @"addpinglun"








// ** 实时数据接口
#define now_data_URL @"app_queryshishi?uid=%@"



// ** 添加布水设备接口
#define AddNO_URL @"view_add"












#endif

