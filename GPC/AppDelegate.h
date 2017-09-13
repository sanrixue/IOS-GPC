//
//  AppDelegate.h
//  GPC
//
//  Created by 董立峥 on 16/8/4.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMKMapManager * mapManager;


- (void)setupLoginViewController;

@end

