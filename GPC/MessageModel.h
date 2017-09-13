//
//  MessageModel.h
//  GPC
//
//  Created by 尤超 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *time;     //时间
@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, copy) NSString *text;     //内容
@property (nonatomic, copy) NSString *image;    // 图片
@property (nonatomic, copy) NSString *uid;      //用户id
@property (nonatomic, copy) NSString *messageId;//消息id

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
