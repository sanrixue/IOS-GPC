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
            
            
        }else {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}

#pragma mark - 创建表
- (void)creatTable {

    NSString *sql = @"create table if not exists model(user_id integer primary key AUTOINCREMENT,user_name text,user_logo text,user_phone text,user_score text,user_wallet text,user_type text,user_idCard text,user_status text,user_deposit text)";
    
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

- (void)insertUserModel:(UserModel *)userModel {
    NSString *sql = @"insert into model(user_id,user_name,user_logo,user_phone,user_score,user_wallet,user_type,user_idCard,user_status,user_deposit) values (?,?,?,?,?,?,?,?,?,?)";
    if ([self userisExistModelId:userModel.user_id]) {
        NSLog(@"数据已经存在");
        return;
    }
    BOOL isSuccess= [_database executeUpdate:sql,userModel.user_id,userModel.user_name,userModel.user_logo,userModel.user_phone,userModel.user_score,userModel.user_wallet,userModel.user_type,userModel.user_idCard,userModel.user_status,userModel.user_deposit];
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


////修改
- (void)upadteUserModelModelName:(NSString *)modelName FromModelId:(NSString *)modelId {
    NSString *sql = @"update model set user_name = ? where user_id = ?";
    BOOL isSuccess= [_database executeUpdate:sql,modelName,modelId];
    if (!isSuccess) {
        NSLog(@"修改失败: %@",_database.lastErrorMessage);
    } else {
        NSLog(@"数据库修改成功");
    }
}

- (void)upadteUserModelModelStatus:(NSString *)modelStatus FromModelId:(NSString *)modelId {
    NSString *sql = @"update model set user_status = ? where user_id = ?";
    BOOL isSuccess= [_database executeUpdate:sql,modelStatus,modelId];
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
        
        UserModel *model=[[UserModel alloc]init];
        model.user_id = [rs stringForColumn:@"user_id"];
        model.user_name = [rs stringForColumn:@"user_name"];
        model.user_logo = [rs stringForColumn:@"user_logo"];
        model.user_phone = [rs stringForColumn:@"user_phone"];
        model.user_score = [rs stringForColumn:@"user_score"];
        model.user_wallet = [rs stringForColumn:@"user_wallet"];
        model.user_type = [rs stringForColumn:@"user_type"];
        model.user_idCard = [rs stringForColumn:@"user_idCard"];
        model.user_status = [rs stringForColumn:@"user_status"];
        model.user_deposit = [rs stringForColumn:@"user_deposit"];
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
    
        UserModel *model=[[UserModel alloc]init];
        model.user_id = [rs stringForColumn:@"user_id"];
        model.user_name = [rs stringForColumn:@"user_name"];
        model.user_logo = [rs stringForColumn:@"user_logo"];
        model.user_phone = [rs stringForColumn:@"user_phone"];
        model.user_score = [rs stringForColumn:@"user_score"];
        model.user_wallet = [rs stringForColumn:@"user_wallet"];
        model.user_type = [rs stringForColumn:@"user_type"];
        model.user_idCard = [rs stringForColumn:@"user_idCard"];
        model.user_status = [rs stringForColumn:@"user_status"];
        model.user_deposit = [rs stringForColumn:@"user_deposit"];
        [ary addObject:model];

    }
    return [ary firstObject];
}


@end
