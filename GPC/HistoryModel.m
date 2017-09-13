//
//  HistoryModel.m
//  GPC
//
//  Created by 董立峥 on 16/8/22.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.history_time = [dic valueForKey:@"create_time"];
        self.history_thing = [dic valueForKey:@"content"];
        self.history_result = [dic valueForKey:@"score"];
        self.history_id = [dic valueForKey:@"id"];
        self.history_uid = [dic valueForKey:@"uid"];
        self.history_type = [dic valueForKey:@"type"];
    }
    return self;
}

+ (instancetype)historyWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}

@end
