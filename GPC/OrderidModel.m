



//
//  OrderidModel.m
//  GPC
//
//  Created by 尤超 on 16/9/5.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "OrderidModel.h"

@implementation OrderidModel

static OrderidModel* dictModel = nil;  //为单例对象实现一个静态实例，并初始化，然后设置成nil，

+(OrderidModel *)shareModel
{
    if (dictModel == nil) {
        dictModel = [[OrderidModel alloc] init];//实现一个实例构造方法检查上面声明的静态实例是否为nil，如果是则新建并返回一个本类的实例
    }
    return dictModel;
}

-(id)init
{
    if (self = [super init]) {
        self.dict = [[NSDictionary alloc] init];
    }
    return self;
}

@end
