//
//  UserModel.h
//  GPC
//
//  Created by 董立峥 on 16/8/26.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *user_id;         //用户ID
@property (nonatomic, copy) NSString *user_name;       //用户名字
@property (nonatomic, copy) NSString *user_logo;       //用户头像
@property (nonatomic, copy) NSString *user_phone;      //用户手机号
@property (nonatomic, copy) NSString *user_score;      //用户信用积分
@property (nonatomic, copy) NSString *user_wallet;     //用户钱包
@property (nonatomic, copy) NSString *user_type;       //用户类型
@property (nonatomic, copy) NSString *user_idCard;     //用户身份证
@property (nonatomic, copy) NSString *user_status;     //用户状态  1手机绑定成功，2押金充值成功，3实名认证成功
@property (nonatomic, copy) NSString *user_deposit;    //用户押金余额

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)userWithDict:(NSDictionary *)dic;

@end
