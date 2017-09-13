//
//  XinYongModel.m
//  GPC
//
//  Created by 董立峥 on 16/8/22.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "XinYongModel.h"

@implementation XinYongModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.icon = [dic valueForKey:@"icon"];
        self.history_time = [dic valueForKey:@"history_time"];
        self.history_thing = [dic valueForKey:@"history_thing"];
        self.history_result = [dic valueForKey:@"history_result"];
    }
    return self;
}

+ (instancetype)xinyongWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}

@end
