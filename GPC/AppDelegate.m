//
//  AppDelegate.m
//  GPC
//
//  Created by 董立峥 on 16/8/4.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"      //首页
#import "NewViewController.h"   //重写导航栏
#import "LoginViewController.h" //登录
#import "KeyboardManager.h"     //键盘管理
#import <AlipaySDK/AlipaySDK.h>

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"  //微信


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    //UM  Appkey
    [UMSocialData setAppKey:@"5770824de0f55a9943002998"];
    
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"5770824de0f55a9943002998" url:@"http://www.umeng.com/social"];
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BaiDu_API_Key  generalDelegate:nil];
    if (!ret)
    {
        NSLog(@"开启定位失败!");
    }
    

    [self setupLoginViewController];
    
    
    //调用键盘
    [self keyboard];

    return YES;
    
}

//设置首页登录
- (void)setupLoginViewController {
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];

  
    if (model == nil) {
    
        LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    
        NewViewController * nag = [[NewViewController alloc]initWithRootViewController:loginVC];
    
//        [nag.navigationBar lt_setBackgroundColor:COLOR(0, 0, 0, 0.7)];
//        [nag.navigationBar lt_setTranslationY:0];
//    
//        [nag.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
        nag.navigationBar.tintColor = [UIColor whiteColor];
        nag.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        nag.navigationBar.barTintColor = COLOR(0, 0, 0, 0.7);
//        nag.navigationBar.translucent = NO;
        
        
    
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
        self.window.rootViewController = nag;
        [self.window makeKeyAndVisible];
    
        [nag setNavigationBarHidden:YES];

    } else {
        
        ViewController * mainVc = [[ViewController alloc]init];
        
        NewViewController * nag = [[NewViewController alloc]initWithRootViewController:mainVc];
        
//        [nag.navigationBar lt_setBackgroundColor:COLOR(0, 0, 0, 0.7)];
//        [nag.navigationBar lt_setTranslationY:0];
//        
//        [nag.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        nag.navigationBar.tintColor = [UIColor whiteColor];
        nag.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        nag.navigationBar.barTintColor = COLOR(0, 0, 0, 0.7);
//        nag.navigationBar.translucent = NO;
        
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
        self.window.rootViewController = nag;
        
        [self.window makeKeyAndVisible];
    }

}


//键盘管理
-(void)keyboard
{
    // 键盘管理库设置，《在这里写，整个项目都能用，不用再担心输入框被键盘遮盖，点击背景自动下键盘等。。。》
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES; //控制点击背景是否收起键盘。
    manager.shouldToolbarUsesTextFieldTintColor = YES; //控制键盘上的工具条文字颜色是否用户自定义。
    manager.enableAutoToolbar = YES;//控制是否显示键盘上的工具条。
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma 配置系统回调
//在APPdelegate.m中增加下面的系统回调配置，注意如果同时使用微信支付、支付宝等其他需要改写回调代理的SDK，请在if分支下做区分，否则会影响 分享、登录的回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
            if ([url.host isEqualToString:@"safepay"]) {
                // 支付跳转支付宝钱包进行支付，处理支付结果
                [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@",resultDic);
                }];
        
                // 授权跳转支付宝钱包进行支付，处理支付结果
                [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@",resultDic);
                    // 解析 auth code
                    NSString *result = resultDic[@"result"];
                    NSString *authCode = nil;
                    if (result.length>0) {
                        NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                        for (NSString *subResult in resultArr) {
                            if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                authCode = [subResult substringFromIndex:10];
                                break;
                            }
                        }
                    }
                    NSLog(@"授权结果 authCode = %@", authCode?:@"");
                }];
            }
    }
    return result;
}


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}


@end
