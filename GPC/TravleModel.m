

//
//  TravleModel.m
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "TravleModel.h"

@implementation TravleModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.time = [dic valueForKey:@"start_time"];
        self.begin = [dic valueForKey:@"start_place"];
        self.end = [dic valueForKey:@"end_place"];
        self.pay = [dic valueForKey:@"price"];
        self.endtime = [dic valueForKey:@"end_time"];
        self.distance = [dic valueForKey:@"distance"];
        self.orderid = [dic valueForKey:@"orderid"];
        self.userID = [dic valueForKey:@"uid"];
        self.travelID = [dic valueForKey:@"id"];
        self.creattime = [dic valueForKey:@"create_time"];
        self.type = [dic valueForKey:@"type"];
        self.yue = [dic valueForKey:@"yue"];
    }
    return self;

}

+ (instancetype)travleWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}


@end
