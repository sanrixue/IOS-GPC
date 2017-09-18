//
//  Tools.h
//  iCarCenter
//
//  Created by Peter on 15/2/4.
//  Copyright (c) 2015年 董立峥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"   //判断网络
#import "UIImageView+WebCache.h"  //下载image&上传image
#import "Reachability.h"
#import "Toast+UIView.h"
#import "AppConfig.h"


@protocol ToolsDelegate <NSObject>

@optional

-(void)commitBackButtonClick;

@end

@interface Tools : NSObject

@property (strong, nonatomic) id<ToolsDelegate> delegate;
@property (strong, nonatomic) UIViewController *viewControl;

@property (strong, nonatomic) UIView * noticeView ;  //透明阴影View

@property (strong, nonatomic) UILabel *commitRemindLabel;     //提交提示label
@property (strong, nonatomic) UITextField *commitTF;          //提交TextField内容

//从一段字符串中截取指定字数的字符串
+ (NSString *)getSubString:(NSString *)strSource WithCharCounts:(NSInteger)number;
//将数组转变成以指定字符隔开的字符串
+(NSString *) getStringFromArray:(NSArray *)srcArray byCharacter:(NSString *)character;

//传入时间查看时候间隔 如1天前，  58分钟前
+(NSString*)timestamp:(NSString*)dateTimeStr lastDateTimeStr:(NSString *)lastDateTime;

//检测两个时间段相差多少天
//从时间串中 根据时间差 在同一天的时候显示 小时分钟，超过一天就显示时间
//+(NSString*)getTimeFromTimeStr:(NSString*)timeStr;

+(NSString*)getDaysFromDates:(NSString*)dateTimeStr lastDateTimeStr:(NSString *)lastDateTime;

//获取当前系统时区的时间
+(NSString*)getCurrentDateWithSystemLocalZone;


+ (UIWindow *)keyWindow;
//隐藏分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView;
 
//判断网络是否存在
+(BOOL)isExistenceNetwork;
//提示框
+(void)showAlertWithString:(NSString*)message delegate:(id)dele;

////拨打电话 方法1 有弹出框
+(void)contactPhone:(NSString *)phone view:(UIView*)view;

//拨打电话 方法2 无弹出框，直接进入拨号界面
+(void)contactPhonenum:(NSString *)phonenum;

//获取设备xib
+ (id)loadNibName:(NSString *)name;

//获取UIStoryboard
+ (id)loadStoryboardName:(NSString *)name ViewName:(NSString*)viewname;
+ (NSString *)GetEncodedValue:(NSString *)encodedValue;
//判断是否是同一天
+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;
//字符串中是否含有emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
//计算中文混合字符个数
+(int)convertToInt:(NSString*)strtemp;

//图片压缩
+(NSData *) scaleImage:(UIImage *) image;

//获取值得 尺寸的 图片的URL
+(NSString*)getImageUrl:(NSString *)url witdh:(int)withd withtHeight:(int)height;

 
//GET 请求
+ (void)GET:(NSString *)url params:(NSDictionary *)params superviewOfMBHUD:(UIView *)view success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

//Post 请求
+ (void)POST:(NSString *)url params:(NSDictionary *)params superviewOfMBHUD:(UIView *)view success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

//获取当前设备号
+(NSString*)getUuid;

//判断是否为电话号码
+ (BOOL)isMobileNumber:(NSString *)telephoneNum;

+(BOOL)isMobileNumbers:(NSString *)mobileNum;


//判断是否为邮箱
+ (BOOL)isEmail:(NSString *)email;

//判断是否为身份证号
+ (BOOL) isIDcard: (NSString *)identityCard;

//创建一个Item
+(UIBarButtonItem *)setTabBarbtn;

//date日期转字符串
+ (NSString *)stringFromDate:(NSDate *)date;

//字符串转日期
+ (NSDate *)dateFromString:(NSString *)string;

#pragma mark ---- 透明阴影

//添加收藏透明层
- (UIView *)addCollectAlphaView:(id<ToolsDelegate>)mydelegate;

//添加提交透明层
- (UIView *)addCommitAlphaView:(id<ToolsDelegate>)mydelegate;


-(void)hideAlphaBlackShareView;



//保存个人信息
+(void)saveUserInfoWithDic:(NSDictionary *)userInfo;
//保存用户头像Url
+(void)saveUserImgUrlWithString:(NSString *)imgUrl;
//获取个人信息
+(NSDictionary *)getUserInfo;
//获取头像Url
+(NSString *)getUserImgUrl;
//获取userId
+(NSString *)getUserID;
//取值UserType
+(NSString *)getUserType;

//保存个人信息里面的tds数组
+(void)saveUserInfoTds:(NSArray *)tdsAry;
//获取个人信息里面的tds数组
+(NSArray *)getUserInfoTdsAry;

//ios根据视频地址获取某一帧的图像
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
#pragma mark - 检测字典内是否有<null>
//如果有<null>转换成""
+ (NSDictionary *)deleteNull:(NSDictionary *)NULLDict;
//将字典转化为字符串格式
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
//加载网络URLImage
+ (UIImage *) getImageFromURL:(NSString *)fileURL;
//检测字符串是否为空
+ (NSString *) isBlankString:(NSString *)string;
@end
