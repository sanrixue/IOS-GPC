//
//  DetailModle.h
//  GPC
//
//  Created by 尤超 on 16/9/9.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModle : NSObject

@property (nonatomic, copy) NSString *detail_time;        //时间
@property (nonatomic, copy) NSString *detail_thing;       //事件
@property (nonatomic, copy) NSString *detail_result;      //结果


- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)detailWithDict:(NSDictionary *)dic;

@end
