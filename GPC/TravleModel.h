//
//  TravleModel.h
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravleModel : NSObject

@property (nonatomic, copy) NSString *time;  //起点时间
@property (nonatomic, copy) NSString *endtime;  //终点时间
@property (nonatomic, copy) NSString *begin; //起点
@property (nonatomic, copy) NSString *end;   //终点
@property (nonatomic, copy) NSString *pay;   //花费
@property (nonatomic, copy) NSString *orderid;   //订单ID
@property (nonatomic, copy) NSString *distance;   //距离
@property (nonatomic, copy) NSString *userID; //用户ID
@property (nonatomic, copy) NSString *travelID;   //行程ID
@property (nonatomic, copy) NSString *creattime;   //创建时间
@property (nonatomic, copy) NSString *type;   //类型
@property (nonatomic, copy) NSString *yue;   //余额

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)travleWithDict:(NSDictionary *)dic;

@end
