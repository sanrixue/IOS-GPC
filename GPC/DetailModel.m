


//
//  DetailModle.m
//  GPC
//
//  Created by 尤超 on 16/9/9.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "DetailModle.h"

@implementation DetailModle

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.detail_time = [dic valueForKey:@"detail_time"];
        self.detail_thing = [dic valueForKey:@"detail_thing"];
        self.detail_result = [dic valueForKey:@"detail_result"];
    }
    return self;
}

+ (instancetype)detailWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}

@end
