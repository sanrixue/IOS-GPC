//
//  DBManager.m
//  BaMaiYL
//
//  Created by Super on 16/5/6.
//  Copyright © 2016年 季晓侠. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
{
    //数据库对象
    FMDatabase *_database;
}

//非标准单例
+ (DBManager *)sharedManager {
    static DBManager *manager = nil;
    @synchronized(self) {//同步 执行 防止多线程操作
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    }
    return manager;
}

- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件app.db的路径
        NSString *filePath = [self getFileFullPathWithFileName:@"app.db"];
        
        //2.创建database
        _database = [[FMDatabase alloc] initWithPath:filePath];
        
        //3.open
        //第一次 数据库文件如果不存在那么 会创建并且打开
        //如果存在 那么直接打开
        if ([_database open]) {
            NSLog(@"数据库打开成功");
            //创建表 不存在 则创建
            [self creatTable];
            
            [self creatTable2];
            
        }else {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}

#pragma mark - 创建表
- (void)creatTable {

    NSString *sql = @"create table if not exists model(user_id integer primary key AUTOINCREMENT,user_name text,user_icon text,user_telephone text,user_age text,user_birthday text,token text,user_sex text)";
    
    //创建表 如果不存在则创建新的表
    BOOL isSuccees = [_database executeUpdate:sql];
    if (!isSuccees) {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
}

- (void)creatTable2 {
    
    NSString *sql = @"create table if not exists device(device_num integer primary key AUTOINCREMENT,name text,title text,portrait text,sim_code text)";
    
    //创建表 如果不存在则创建新的表
    BOOL isSuccees = [_database executeUpdate:sql];
    if (!isSuccees) {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
}

#pragma mark - 获取文件的全路径

//获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath]) {
        
        NSLog(@"%@",[docPath stringByAppendingFormat:@"/%@",fileName]);
        //文件的全路径
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    }else {
        //如果不存在可以创建一个新的
        NSLog(@"Documents不存在");
        return nil;
    }
}

- (void)insertUserModel:(BMUserModel *)userModel {
    NSString *sql = @"insert into model(user_id,user_name,user_icon,user_telephone,user_age,user_birthday,token,user_sex) values (?,?,?,?,?,?,?,?)";
    if ([self userisExistModelId:userModel.user_id]) {
        NSLog(@"数据已经存在");
        return;
    }
    BOOL isSuccess= [_database executeUpdate:sql,userModel.user_id,userModel.user_name,userModel.user_icon,userModel.user_telephone,userModel.user_age,userModel.user_birthday,userModel.token,userModel.user_sex];
    if (isSuccess) {
        NSLog(@"数据库收藏成功");
    }
}

- (void)insertDeviceModel:(BMDeviceModel *)deviceModel {
    NSString *sql = @"insert into device(device_num,name,title,portrait,sim_code) values (?,?,?,?,?)";
    if ([self deviceisExistModelId:deviceModel.device_num]) {
        NSLog(@"数据已经存在");
        return;
    }
    BOOL isSuccess= [_database executeUpdate:sql,deviceModel.device_num,deviceModel.name,deviceModel.title,deviceModel.portrait,deviceModel.sim_code];
    if (isSuccess) {
        NSLog(@"数据库收藏成功");
    }

}

//查找是否存在
- (BOOL)userisExistModelId:(NSString *)modelId {
    NSString *sql = @"select * from model where user_id = ?";
    FMResultSet *rs = [_database executeQuery:sql,modelId];
    if ([rs next]) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)deviceisExistModelId:(NSString *)modelId {
    NSString *sql = @"select * from device where device_num = ?";
    FMResultSet *rs = [_database executeQuery:sql,modelId];
    if ([rs next]) {
        return YES;
    }else{
        return NO;
    }
}

//删除
- (void)deleteUserModel
{
    NSString *sql = @"delete from model";
    BOOL isSuccess= [_database executeUpdate:sql];
    if (!isSuccess) {
        NSLog(@"删除失败: %@",_database.lastErrorMessage);
    } else {
        NSLog(@"数据库删除收藏成功");
    }
}

//删除device
- (void)deleteDeviceallModel
{
    NSString *sql = @"delete from device";
    BOOL isSuccess= [_database executeUpdate:sql];
    if (!isSuccess) {
        NSLog(@"删除失败: %@",_database.lastErrorMessage);
    } else {
        NSLog(@"数据库删除收藏成功");
    }
}

- (void)deleteDeviceallModel:(NSString *)modelId
{
    NSString *sql = @"delete from device where device_num = ?";
    BOOL isSuccess= [_database executeUpdate:sql,modelId];
    if (!isSuccess) {
        NSLog(@"删除失败: %@",_database.lastErrorMessage);
    } else {
        NSLog(@"数据库删除收藏成功");
    }
}

//修改
- (void)upadteUserModelModelName:(NSString *)modelName ModelSex:(NSString *)modelSex ModelBirthday:(NSString *)modelBirthday ModelIcon:(NSString *)modelIcon ForModelId:(NSString *)modelId {
    NSString *sql = @"update model set user_name = ?, user_sex = ?, user_birthday = ?, user_icon = ? where user_id = ?";
    BOOL isSuccess= [_database executeUpdate:sql,modelName,modelSex,modelBirthday,modelIcon,modelId];
    if (!isSuccess) {
        NSLog(@"修改失败: %@",_database.lastErrorMessage);
    } else {
        NSLog(@"数据库修改成功");
    }
}

//根据modelId查找所有的model
- (NSArray *)selectAllModel
{
    NSString *sql=@"select * from model";
    FMResultSet *rs=[_database executeQuery:sql];
    NSMutableArray *ary=[[NSMutableArray alloc]init];
    while ([rs next]) {
        
        BMUserModel *model=[[BMUserModel alloc]init];
        model.user_id = [rs stringForColumn:@"user_id"];
        model.user_name = [rs stringForColumn:@"user_name"];
        model.user_icon = [rs stringForColumn:@"user_icon"];
        model.user_telephone = [rs stringForColumn:@"user_telephone"];
        model.user_age = [rs stringForColumn:@"user_age"];
        model.user_birthday = [rs stringForColumn:@"user_birthday"];
        model.token = [rs stringForColumn:@"token"];
        model.user_sex = [rs stringForColumn:@"user_sex"];
        [ary addObject:model];
        
    }
    
    return ary;
}

- (NSArray *)selectAllDevice
{
    NSString *sql=@"select * from device";
    FMResultSet *rs=[_database executeQuery:sql];
    NSMutableArray *ary=[[NSMutableArray alloc]init];
    while ([rs next]) {
        
        BMDeviceModel *model=[[BMDeviceModel alloc]init];
        model.device_num = [rs stringForColumn:@"device_num"];
        model.name = [rs stringForColumn:@"name"];
        model.title = [rs stringForColumn:@"title"];
        model.portrait = [rs stringForColumn:@"portrait"];
        model.sim_code = [rs stringForColumn:@"sim_code"];
        
        [ary addObject:model];
        
    }
    
    return ary;
}

//根据modelId查找一个model
- (instancetype)selectOneModel
{
    NSString *sql = @"select * from model";
    FMResultSet *rs = [_database executeQuery:sql];
    NSMutableArray *ary=[[NSMutableArray alloc]init];
    while ([rs next]) {
    
        BMUserModel *model = [[BMUserModel alloc]init];
        model.user_id = [rs stringForColumn:@"user_id"];
        model.user_name = [rs stringForColumn:@"user_name"];
        model.user_icon = [rs stringForColumn:@"user_icon"];
        model.user_telephone = [rs stringForColumn:@"user_telephone"];
        model.user_age = [rs stringForColumn:@"user_age"];
        model.user_birthday = [rs stringForColumn:@"user_birthday"];
        model.token = [rs stringForColumn:@"token"];
        model.user_sex = [rs stringForColumn:@"user_sex"];
        [ary addObject:model];
    }
    return [ary firstObject];
}

- (instancetype)selectOneDevice:(NSString *)deviceNum
{
    
    
    NSString *sql = [NSString stringWithFormat:@"select * from device where device_num =%@",deviceNum];
    FMResultSet *rs = [_database executeQuery:sql];
    NSMutableArray *ary=[[NSMutableArray alloc]init];
    while ([rs next]) {
        
        BMDeviceModel *model = [[BMDeviceModel alloc]init];
        model.device_num = [rs stringForColumn:@"device_num"];
        model.name = [rs stringForColumn:@"name"];
        model.title = [rs stringForColumn:@"title"];
        model.portrait = [rs stringForColumn:@"portrait"];
        model.sim_code = [rs stringForColumn:@"sim_code"];
        [ary addObject:model];
    }
    return [ary firstObject];
}


@end
