//
//  DBManager.h
//  BaMaiYL
//
//  Created by Super on 16/5/6.
//  Copyright © 2016年 季晓侠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FMDatabase.h>
#import "BMUserModel.h"
#import "BMDeviceModel.h"

@interface DBManager : NSObject

//非标准单例
+ (DBManager *)sharedManager;


//存储类型
- (void)insertUserModel:(BMUserModel *)userModel;

- (void)insertDeviceModel:(BMDeviceModel *)deviceModel;

//删除用户
- (void)deleteUserModel;
//删除用户Device
- (void)deleteDeviceallModel;

- (void)deleteDeviceallModel:(NSString *)modelId;


//查找是否已经存在
- (BOOL)userisExistModelId:(NSString *)modelId;

- (BOOL)deviceisExistModelId:(NSString *)modelId;

//查找所有的收藏
- (NSArray *)selectAllModel;

- (NSArray *)selectAllDevice;

//根据modelId查找一个model
- (instancetype)selectOneModel;

- (instancetype)selectOneDevice:(NSString *)deviceNum;

//修改
- (void)upadteUserModelModelName:(NSString *)modelName ModelSex:(NSString *)modelSex ModelBirthday:(NSString *)modelBirthday ModelIcon:(NSString *)modelIcon ForModelId:(NSString *)modelId;
@end
