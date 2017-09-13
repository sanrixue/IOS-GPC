//
//  DashesLineView.h
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashesLineView : UIView

@property(nonatomic)CGPoint startPoint;//虚线起点

@property(nonatomic)CGPoint endPoint;//虚线终点

@property(nonatomic,strong)UIColor* lineColor;//虚线颜色

@end
