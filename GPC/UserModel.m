//
//  UserModel.m
//  GPC
//
//  Created by 董立峥 on 16/8/26.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        self.user_id = [dic valueForKey:@"id"];
        self.user_name = [dic valueForKey:@"name"];
        self.user_logo = [dic valueForKey:@"logo"];
        self.user_phone = [dic valueForKey:@"phone"];
        self.user_score = [dic valueForKey:@"score"];
        self.user_wallet = [dic valueForKey:@"wallet"];
        self.user_type = [dic valueForKey:@"type"];
        self.user_idCard = [dic valueForKey:@"idCard"];
        self.user_status = [dic valueForKey:@"status"];
        self.user_deposit = [dic valueForKey:@"deposit"];
        
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
