//
//  OrderidModel.h
//  GPC
//
//  Created by 尤超 on 16/9/5.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderidModel : NSObject

@property (nonatomic, strong) NSDictionary *dict;    

+ (OrderidModel *)shareModel;

@end
