//
//  MessageModel.m
//  GPC
//
//  Created by 尤超 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    if (self = [super init]) {
        self.time = [dic valueForKey:@"create_time"];
        self.title = [dic valueForKey:@"title"];
        self.text = [dic valueForKey:@"content"];
        self.image = [dic valueForKey:@"img"];
        self.uid = [dic valueForKey:@"uid"];
        self.messageId = [dic valueForKey:@"id"];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end
