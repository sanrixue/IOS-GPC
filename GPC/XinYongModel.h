//
//  XinYongModel.h
//  GPC
//
//  Created by 董立峥 on 16/8/22.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XinYongModel : NSObject

@property (nonatomic, copy) NSString *icon;                //图标
@property (nonatomic, copy) NSString *history_time;        //时间
@property (nonatomic, copy) NSString *history_thing;       //事件
@property (nonatomic, copy) NSString *history_result;      //结果


- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)xinyongWithDict:(NSDictionary *)dic;

@end