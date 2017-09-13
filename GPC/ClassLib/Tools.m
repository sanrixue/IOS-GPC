//
//  Tools.m
//  iCarCenter
//
//  Created by Storm on 15-2-4.
//  Copyright (c) 2014年 董立峥. All rights reserved.
//

#import "Tools.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>

@implementation Tools


// 从字符串中获取字数个数为N的字符串，单字节字符占半个字数，双字节占一个字数
+ (NSString *)getSubString:(NSString *)strSource WithCharCounts:(NSInteger)number
{
    // 一个字符以内，不处理
	if (strSource == nil || [strSource length] <= 1) {
		return strSource;
	}
	char *pchSource = (char *)[strSource cStringUsingEncoding:NSUTF8StringEncoding];
	NSInteger sourcelen = strlen(pchSource);
	int nCharIndex = 0;		// 字符串中字符个数,取值范围[0, [strSource length]]
	int nCurNum = 0;		// 当前已经统计的字数
	for (int n = 0; n < sourcelen; ) {
		if( *pchSource & 0x80 ) {
			if ((nCurNum + 2) > number * 2) {
				break;
			}
			pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
			n += 3;
			nCurNum += 2;
		}
		else {
			if ((nCurNum + 1) > number * 2) {
				break;
			}
			pchSource++;
			n += 1;
			nCurNum += 1;
		}
		nCharIndex++;
	}
	assert(nCharIndex > 0);
	return [strSource substringToIndex:nCharIndex];
}

+(NSString *) getStringFromArray:(NSArray *)srcArray byCharacter:(NSString *)character
{
	NSMutableString *mutabString = [[NSMutableString alloc] init];
	int i = 0;
	if (srcArray.count > 0)
	{
		for (i = 0; i < srcArray.count-1; i++)
		{
			[mutabString appendFormat:@"%@%@",[srcArray objectAtIndex:i],character];
		}
		[mutabString appendString:[srcArray objectAtIndex:i]];
	}
	return mutabString;
}


+(NSString*)timestamp:(NSString*)dateTimeStr lastDateTimeStr:(NSString *)lastDateTime
{
    //将传入时间转化成需要的格式
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate = [format dateFromString:dateTimeStr];
    NSDate *lfromdate = [format dateFromString:lastDateTime];
    
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSInteger lfrominterval = [fromzone secondsFromGMTForDate:lfromdate];
    
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSDate *localeDate = [lfromdate  dateByAddingTimeInterval: lfrominterval];
    
    double intervalTime = [localeDate timeIntervalSinceReferenceDate] - [fromDate timeIntervalSinceReferenceDate];
    
    long lTime = (long)intervalTime;
    NSInteger iSeconds = lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours = (lTime / 3600);
    NSInteger iDays = lTime/60/60/24;
    NSInteger iMonth = lTime/60/60/24/12;
    NSInteger iYears = lTime/60/60/24/384;
    
    // NSLog(@"相差%d年%d月 %d日%d时%d分%d秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    
    if(iYears>0){
        
        return [NSString stringWithFormat:@"%ld年前",(long)iYears];
        
    }else if(iMonth>0){
        return [NSString stringWithFormat:@"%ld个月前",(long)iMonth];
    }else if(iDays>=7){
        if (iDays ==7) {
            return @"1周前";
        }
        return [NSString  stringWithFormat:@"%ld周前",(long)iDays/7];
    }else if(iDays>0){
        return [NSString  stringWithFormat:@"%ld天前",(long)iDays];
    }else if(iHours>0){
        return [NSString  stringWithFormat:@"%ld小时前",(long)iHours];
    }else if(iMinutes>0){
        return [NSString  stringWithFormat:@"%ld分钟前",(long)iMinutes];
    }else if(iSeconds > 0){
        return [NSString  stringWithFormat:@"%ld秒前",(long)iSeconds];
    }else {
        return @"刚刚";
    }
    
    return nil;
}
+(NSString*)getDaysFromDates:(NSString*)dateTimeStr lastDateTimeStr:(NSString *)lastDateTime{
    //将传入时间转化成需要的格式
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromdate = [format dateFromString:dateTimeStr];
    NSDate *lfromdate = [format dateFromString:lastDateTime];
    
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSInteger lfrominterval = [fromzone secondsFromGMTForDate:lfromdate];
    
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSDate *localeDate = [lfromdate  dateByAddingTimeInterval: lfrominterval];
    
    double intervalTime = [localeDate timeIntervalSinceReferenceDate] - [fromDate timeIntervalSinceReferenceDate];
    
    long lTime = (long)intervalTime;
    NSInteger iDays = lTime/60/60/24;
    
    // NSLog(@"相差%d年%d月 %d日%d时%d分%d秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    if(iDays>0){
        return [NSString  stringWithFormat:@"%ld",(long)(long)iDays];
    }
    return nil;

}
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

//计算 中英文混合 字符数；
+(int)convertToInt:(NSString*)strtemp {
	
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
	
}


//图片压缩
+(NSData *) scaleImage:(UIImage *) image
{
	NSData *dataImage = UIImageJPEGRepresentation(image, 1.0);
	NSLog(@"imagesize:%ld",(long)dataImage.length/1024);
    NSUInteger sizeOrigin = [dataImage length];
    NSUInteger sizesizeOriginKB = sizeOrigin / 1024;
	
	
	float q = 1.0;
	if (sizesizeOriginKB > 1024*10) //10M
	{
		q = 0.5;
	}else if(sizesizeOriginKB > 1024*7) //7M
	{
		q = 0.7;
	}
	else if(sizesizeOriginKB > 1024*5) //5M
	{
		q = 0.8;
	}else if(sizesizeOriginKB > 1024*4){
        q = 0.9;
    }
	else if(sizesizeOriginKB > 1024*3)//3M
	{
		q = 0.92;
	}
    // 图片压缩
    if (q !=1.0)
	{
		NSLog(@"q:%f",q);
        CGSize sizeImage = [image size];
        NSLog(@"before !!!!,%@,%f,%f",image,sizeImage.width,sizeImage.height);
        CGFloat iwidthSmall = sizeImage.width * q;
		CGFloat iheightSmall = sizeImage.height * q;
		
		//为了保证在主页的显示，宽度不低于320
		if (iwidthSmall < 320)
		{
			iheightSmall = iheightSmall * (320/iwidthSmall);
			iwidthSmall = 320;
		}
        CGSize itemSizeSmall = CGSizeMake(iwidthSmall, iheightSmall);
        UIGraphicsBeginImageContext(itemSizeSmall);
        
        CGRect imageRectSmall = CGRectMake(0.0f, 0.0f, itemSizeSmall.width+2, itemSizeSmall.height+2);  //长和宽都增加2个像素，防止有些图片绘制旁边出现白线
		NSLog(@"before drawInRect!!,%f,%f",imageRectSmall.size.width,imageRectSmall.size.height);
        [image drawInRect:imageRectSmall];
		//NSLog(@"after drawInRect!!!!");
        UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
		dataImage = UIImageJPEGRepresentation(scaleImage,0.38);
        
        //UIImagePNGRepresentation(scaleImage);// UIImageJPEGRepresentation(scaleImage,0.9);
		
    }else{
        dataImage = UIImageJPEGRepresentation(image,0.38);
    }
	NSLog(@"压缩bit 后：%ld",(long)[dataImage length]/1024);
	return dataImage;
	
}

+(NSString*)getImageUrl:(NSString *)url witdh:(int)withd withtHeight:(int)height{
    
    NSString* phpAddress = @"http://www.dlb666.com/index.php/ImagesClass-setThumbs-url-";
    //php裁剪图片前缀   +url base64 编码  然后 -w-100-h-100 来设置图片尺寸
    
    //将图片URL地址 通过base64编码
    NSString* urlBase64 = [[url dataUsingEncoding:NSASCIIStringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    
    //按对应格式进行拼接
    NSString* imageUrl = [NSString stringWithFormat:@"%@%@-w-%d-h-%d",phpAddress,urlBase64,withd,height];
    return imageUrl;
    
}

//隐藏分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    //    [tableView setTableHeaderView:view];
    
    
}
+(UIBarButtonItem *)setTabBarbtn{
    UIButton *lefeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lefeButton.frame = CGRectMake(0, 0, 30, 30);
    [lefeButton setImage:[UIImage imageNamed:@"back"] forState:0];
    [lefeButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefeButton];
//    UINavigationController *navigationItem = [[UINavigationController alloc]init];
//    navigationItem.leftBarButtonItem = leftButtonItem;

    return leftButtonItem;
}
 
//判断网络是否存在
+(BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability * network = [Reachability reachabilityWithHostname:@"http://www.baidu.com"];
    switch ([network currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            break;
    }
    
    return isExistenceNetwork;
    
}
//提示框
+(void)showAlertWithString:(NSString*)message delegate:(id)dele
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:dele cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
    
   // UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Alert text goes here" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alertView show];
  
}

+ (UIWindow *)keyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

//拨打电话 方法1 有弹出框
+(void)contactPhone:(NSString *)phone view:(UIView*)view
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [view addSubview:callWebview];
}

//拨打电话 方法2 无弹出框，直接进入拨号界面
+(void)contactPhonenum:(NSString *)phonenum
{
    NSString *allString = [NSString stringWithFormat:@"tel:%@",phonenum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}




//获取设备xib
+ (id)loadNibName:(NSString *)name
{
#ifdef UNIVERSAL_DEVICES
    return [[[NSBundle mainBundle] loadNibNamed:[self deviceNibName:name] owner:NULL options:NULL] objectAtIndex:0];
#else
    return [[[NSBundle mainBundle] loadNibNamed:name owner:NULL options:NULL] objectAtIndex:0];
#endif
}

+ (id)loadStoryboardName:(NSString *)name ViewName:(NSString*)viewname
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
    return  [storyBoard instantiateViewControllerWithIdentifier:viewname];
}

+ (void)GET:(NSString *)url params:(NSDictionary *)params superviewOfMBHUD:(UIView *)view success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
{
    if (view != nil) {
		
		
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
      AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (view != nil) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (view != nil) {
                [view makeToast:@"您的网络不稳定，请稍后重试！"];
                [MBProgressHUD hideHUDForView:view animated:YES];
            }
            failure(error);
        }
    }];
    
}
+ (void)POST:(NSString *)url params:(NSDictionary *)params superviewOfMBHUD:(UIView *)view success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
{
	
		
    if (view != nil) {
		
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
   
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (view != nil)
        {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (view != nil) {
                [view makeToast:@"您的网络不稳定，请稍后重试！"];
                [MBProgressHUD hideHUDForView:view animated:YES];
                
            }
            failure(error);
        }

    }];
    
}
+(NSString*)getCurrentDateWithSystemLocalZone{
    
   
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];

    return dateString;
 
}


+(NSString*)getUuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString); return result;
}

+(BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    
    
    return [comp1 day]   == [comp2 day] &&
    
    [comp1 month] == [comp2 month] &&
    
    [comp1 year]  == [comp2 year];
    
}

//判断是否为电话号码
+ (BOOL)isMobileNumber:(NSString *)telephoneNum{
    //中国移动
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //中国联通
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //中国电信
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //大陆地区固话及小灵通
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    if (([regextestmobile evaluateWithObject:telephoneNum] == YES) || ([regextestcm evaluateWithObject:telephoneNum] == YES) || ([regextestcu evaluateWithObject:telephoneNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

//判断是否为邮箱
+ (BOOL)isEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//身份证号
+ (BOOL) isIDcard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}




//添加收藏透明层
- (UIView *)addCollectAlphaView:(id<ToolsDelegate>)mydelegate{
	
	self.delegate = mydelegate;

	//窗口
	UIWindow *noticeWindow = [UIApplication sharedApplication].keyWindow;
	
	//透明View
	_noticeView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
	_noticeView .backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
	[noticeWindow addSubview:_noticeView];
	
	UIView *addmyView = [[UIView alloc]initWithFrame:CGRectMake(30, 280, DEVICE_WIDTH - 60, 100)];
	addmyView.backgroundColor = [UIColor clearColor];
	addmyView.layer.borderWidth = 2;
	addmyView.layer.borderColor = [UIColor grayColor].CGColor;
	[_noticeView addSubview:addmyView];
	
	UILabel *mywindowLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, (addmyView.frame.size.width-10), 15)];
	mywindowLable.text = @"收藏成功，可以在我的收藏里查看哦！";
	mywindowLable.textAlignment = NSTextAlignmentCenter;
	mywindowLable.textColor = [UIColor redColor];
	[addmyView addSubview:mywindowLable];
	
	UIButton *mytijiaoBtn =[[UIButton alloc]initWithFrame:CGRectMake((DEVICE_WIDTH - 80)/2, addmyView.frame.origin.y+140, 80, 30)];
	mytijiaoBtn.backgroundColor = [UIColor orangeColor];
	[mytijiaoBtn setTitle:@"返回" forState:0];
	[mytijiaoBtn setTitleColor:[UIColor blackColor] forState:0];
	[mytijiaoBtn addTarget:self action:@selector(hideAlphaBlackShareView) forControlEvents:UIControlEventTouchUpInside];
	[_noticeView addSubview:mytijiaoBtn];
    
    UITapGestureRecognizer *tepVC = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAlphaBlackShareView)];
    [_noticeView addGestureRecognizer:tepVC];

	
	//返回透明View
	return _noticeView;
}

//提交透明层
- (UIView *)addCommitAlphaView:(id<ToolsDelegate>)mydelegate title:(NSString *)commitTitle{
    
     self.delegate = mydelegate;
   
    
    UIWindow * mywindow = [UIApplication sharedApplication].keyWindow;
    
    _noticeView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    _noticeView .backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [mywindow addSubview:_noticeView];
    
    
    UIView *addmyView = [[UIView alloc]initWithFrame:CGRectMake(30, 280, DEVICE_WIDTH - 60, 100)];
    addmyView.backgroundColor = [UIColor clearColor];
    addmyView.layer.borderWidth = 2;
    addmyView.layer.borderColor = [UIColor grayColor].CGColor;
    [_noticeView addSubview:addmyView];
    
    _commitRemindLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, (addmyView.frame.size.width-10), 15)];
    _commitRemindLabel.text = commitTitle;
    _commitRemindLabel.textAlignment = NSTextAlignmentCenter;
    _commitRemindLabel.textColor = [UIColor redColor];
    [addmyView addSubview:_commitRemindLabel];
    
    
    _commitTF = [[UITextField alloc]initWithFrame:CGRectMake(15, 35, (addmyView.frame.size.width - 30), 30)];
    _commitTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _commitTF.layer.borderWidth = 1;
    [_commitTF setTextColor:[UIColor whiteColor]];
    _commitTF.keyboardType = UIKeyboardTypeDefault;
//    _commitTF.delegate = textFieldDelegate;
    [addmyView addSubview:_commitTF];
    
    UIButton *sureBtn =[[UIButton alloc]initWithFrame:CGRectMake(130, addmyView.frame.origin.y+140, 60, 30)];
    sureBtn.backgroundColor = [UIColor orangeColor];
    sureBtn.layer.cornerRadius = 3;
    [sureBtn setTitle:@"提交" forState:0];
    [sureBtn setTitleColor:[UIColor blackColor] forState:0];
    [sureBtn addTarget:self action:@selector(hideAlphaBlackShareView) forControlEvents:UIControlEventTouchUpInside];
    [_noticeView addSubview:sureBtn];
    
    
    UITapGestureRecognizer *tepVC = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAlphaBlackShareView)];
    [_noticeView addGestureRecognizer:tepVC];
    
    
    //返回透明View
    return _noticeView;
    
}

//添加提交透明层
- (UIView *)addCommitAlphaView:(id<ToolsDelegate>)mydelegate{
	
	self.delegate = mydelegate;
	
	//窗口
	UIWindow *noticeWindow = [UIApplication sharedApplication].keyWindow;
	
	//透明View
	_noticeView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
	_noticeView .backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
	[noticeWindow addSubview:_noticeView];
	
	UIView *addmyView = [[UIView alloc]initWithFrame:CGRectMake(30, 280, DEVICE_WIDTH - 60, 100)];
	addmyView.backgroundColor = [UIColor clearColor];
	addmyView.layer.borderWidth = 2;
	addmyView.layer.borderColor = [UIColor grayColor].CGColor;
	[_noticeView addSubview:addmyView];
	
	UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, (addmyView.frame.size.width-10), 15)];
	titlelabel.text = @"提交成功，等待审核！";
	titlelabel.textAlignment = NSTextAlignmentCenter;
	titlelabel.textColor = [UIColor redColor];
	[addmyView addSubview:titlelabel];
	
	UIButton *mytijiaoBtn =[[UIButton alloc]initWithFrame:CGRectMake((DEVICE_WIDTH - 80)/2, addmyView.frame.origin.y+140, 80, 30)];
	mytijiaoBtn.backgroundColor = [UIColor orangeColor];
    mytijiaoBtn.layer.cornerRadius = 3;
	[mytijiaoBtn setTitle:@"返回" forState:0];
	[mytijiaoBtn setTitleColor:[UIColor blackColor] forState:0];
	[mytijiaoBtn addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[_noticeView addSubview:mytijiaoBtn];
	
	UITapGestureRecognizer *tepVC = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAlphaBlackShareView)];
	[_noticeView addGestureRecognizer:tepVC];
	
	
	//返回透明View
	return _noticeView;
}

//分享按钮的代理方法
-(void)ShareButtonsWays:(UIButton *)sender{
    
    if (_delegate){
        
           [self hideAlphaBlackShareView];
        
    }

}

//提交透明层代理
-(void)commitButtonClick:(UIButton *)sender{
    
	if (_delegate){
		
		[self hideAlphaBlackShareView];
		
		[_delegate commitBackButtonClick];
	}
}

//保存个人信息
+(void)saveUserInfoWithDic:(NSDictionary *)userInfo{
	
	NSMutableArray * values = [NSMutableArray arrayWithArray:[userInfo allValues]];
	
	for (int i = 0; i < values.count; i++){
		NSString *str= values[i];
		if ([str isEqual:[NSNull null]]){
			[values replaceObjectAtIndex:i withObject:@""];
		}
	}
	
	NSDictionary *newUserDic = [NSDictionary dictionaryWithObjects:values forKeys:[userInfo allKeys]];
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:newUserDic forKey:UserInfo];
	[userDefaults synchronize];
	

}

//保存个人信息里面的tds数组
+(void)saveUserInfoTds:(NSArray *)tdsAry{
	
	NSMutableArray *muary = [NSMutableArray array];
	
	for (int i = 0; i< tdsAry.count; i++) {
		NSDictionary *dic = [tdsAry objectAtIndex:i];
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
		
		[muary addObject:data];
	}
	
	NSArray * array = [NSArray arrayWithArray:muary];
	
	NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
	[user setObject:array forKey:@"UserInfoTds"];
	[user synchronize];

	
}

//保存用户头像Url
+(void)saveUserImgUrlWithString:(NSString *)imgUrl{
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:imgUrl forKey:UserImgUrl];
	[userDefaults synchronize];
	
}
//获取个人信息
+(NSDictionary *)getUserInfo{
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSDictionary *userInfo = [userDefault dictionaryForKey:UserInfo];
	
	return userInfo;
}

//获取头像Url
+(NSString *)getUserImgUrl{
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	
	NSString * userImgUrl = [userDefault stringForKey:UserImgUrl];
	
	
	return userImgUrl;

}

//取值UserID
+(NSString *)getUserID{
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	
	NSDictionary *userinfo = [userDefault dictionaryForKey:UserInfo];
	
	NSString * userId = userinfo[UserId];
		
	return userId;


}

//取值UserType
+(NSString *)getUserType{
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	
	NSDictionary *userinfo = [userDefault dictionaryForKey:UserInfo];
	
	NSString * usertype = [NSString stringWithFormat:@"%@",userinfo[@"userType"]];
	
	return usertype;
	
	
}

//获取个人信息里面的tds数组
+(NSArray *)getUserInfoTdsAry{
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	NSArray *tdsAry = [userDefaults objectForKey:UserInfoTds];
	
	
	NSMutableArray * muary = [NSMutableArray array];
	for (int i = 0; i<tdsAry.count; i++) {
		NSData *data = [tdsAry objectAtIndex:i];
		NSDictionary *datadic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		[muary addObject:datadic];
		
	}
	
	return [NSArray arrayWithArray:muary];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark-----ios根据视频地址获取某一帧的图像
/*
 *videoURL:视频地址(本地/网络)
 *time      :第N帧
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
	
	AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
	NSParameterAssert(asset);
	AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
	assetImageGenerator.appliesPreferredTrackTransform = YES;
	assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
	
	CGImageRef thumbnailImageRef = NULL;
	CFTimeInterval thumbnailImageTime = time;
	NSError *thumbnailImageGenerationError = nil;
	thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
	
	if(!thumbnailImageRef)
		NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
	
	UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef]  : nil;
	
	return thumbnailImage;
}

+ (NSString *)GetEncodedValue:(NSString *)encodedValue{
    
    
    NSString *result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                            (CFStringRef)encodedValue, nil,
                                                                                            (CFStringRef)@"!*'();:@&=+$,/ %#[]", kCFStringEncodingUTF8));
    return result;
}

//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

//透明提示层隐藏
-(void)hideAlphaBlackShareView{
   
    _noticeView.hidden = YES;
}

#pragma mark - 检测字典内是否有<null> 
//如果有<null>转换成""
+ (NSDictionary *)deleteNull:(NSDictionary *)NULLDict
{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in NULLDict.allKeys)
    {
        
        if ([[NULLDict objectForKey:keyStr] isEqual:[NSNull null]]) {
            
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else
        {
            
            [mutableDic setObject:[NULLDict objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
#pragma mark - 将字典转换成字符串的形式
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



#pragma mark - 网络请求加在图片
+ (UIImage *) getImageFromURL:(NSString *)fileURL
{
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    
    
    return result;
    
}

#pragma mark - 判断字符串是否为空
+ (NSString *) isBlankString:(NSString *)string
{
    //为空的话会返回一个为YES的BOOL值 反之则返回NO
    if (string == nil || string == NULL)
    {
        return @"0.00";
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return @"0.00";
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"0.00";
    }
    return string;
}



/// 检查是否是新版本
//- (BOOL)isNewVersion
//{
//    // 如果是新版本存储偏好设置
//    if ([PZCurrentVersion compare:PZLocalVersion options:NSForcedOrderingSearch] == NSOrderedDescending) {
//        // 是新版本,存储版本号
//        [[NSUserDefaults standardUserDefaults] setObject:PZCurrentVersion forKey:PZVersionKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        return YES;
//    } else {
//        
//        return NO;
//    }
//}
















@end