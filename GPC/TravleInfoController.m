
//
//  TravleInfoController.m
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "TravleInfoController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "OrderidModel.h"
#import "UMSocial.h"

@interface TravleInfoController ()<MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate,UMSocialUIDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) MKPolyline *routeLine;

@property (nonatomic, strong) NSMutableArray *mutArray;

@property (nonatomic, strong) NSDictionary *dic;

@property(nonatomic,strong)UIView * Share_View;            //分享视图
@property(nonatomic,assign)BOOL isBOOL;                    //判断分享页面是否调出

@end

@implementation TravleInfoController

- (NSMutableArray *)mutArray {
    if (_mutArray == nil) {
        _mutArray = [NSMutableArray array];
    }
    return _mutArray;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"行程详情";
    
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 40, 40);
    [rightbtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(TouchRightItem) forControlEvents:UIControlEventTouchUpInside];
       UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    
    UIImageView *bkImage = [[UIImageView alloc] init];
    bkImage.frame = self.view.frame;
    [bkImage setImage:[UIImage imageNamed:@"xiangqing"]];
    [self.view addSubview:bkImage];
    
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, KSCREENWIDTH, KSCREENWIDTH * 0.5)];
    
    [self.view addSubview:self.mapView];
    
    self.mapView.delegate = self;
    
    OrderidModel *orderid = [OrderidModel shareModel];
    NSString *str = orderid.dict[@"orderid"];
    
    self.dic = orderid.dict;
    
    if ([[NSString stringWithFormat:@"%@",str] isEqualToString:@"(null)"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请检查您的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }  else {

    NSString * url = [NSString stringWithFormat:Main_URL,Details_URL];
    
    NSDictionary *dic = @{@"orderid":str};
    
    [Tools POST:url params:dic superviewOfMBHUD:nil success:^(id responseObj) {
        
        NSArray *array = responseObj[@"data"];
        
        NSMutableArray *mutArray = [NSMutableArray array];
        
        for (int i = 0; i < array.count; i++) {
            NSString *latitude = array[i][@"lat"];
            
            NSString *longitude = array[i][@"lng"];
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
            
            [mutArray addObject:location];
            
        }
        _mutArray = mutArray;
        
        [self drawLine];

        
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败: %@",error);
    }];
}
    
    [self setUpUI];
    
}

- (void)setUpUI {
    
    NSString *str = [NSString stringWithFormat:@"%@",self.dic[@"distance"]];
    CGFloat dis = [str floatValue];
    CGFloat distance = dis / 1000;
    NSString *disStr = [NSString stringWithFormat:@"%0.1f",distance];
    
    [self addlableWithText:disStr Frame:CGRectMake(KSCREENWIDTH*0.1, KSCREENHEIGHT *0.52, KSCREENWIDTH *0.8, 90) Font:60];
    
    [self addlableWithText:@"骑行距离(公里)" Frame:CGRectMake(KSCREENWIDTH*0.1, KSCREENHEIGHT *0.52+90, KSCREENWIDTH *0.8, 40) Font:25.0];
    
    
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 截止时间字符串格式
    NSString *expireDateStr = [NSString stringWithFormat:@"%@",self.dic[@"end_time"]];
    // 当前时间字符串格式
    NSString *nowDateStr = [NSString stringWithFormat:@"%@",self.dic[@"start_time"]];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    // 当前时间data格式
    NSDate *nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];

    NSLog(@"6666666666    %@",[NSString stringWithFormat:@"%ld",dateCom.minute+dateCom.hour*60]);
    

    
    [self addlableWithText:[NSString stringWithFormat:@"骑行时间%@分钟",[NSString stringWithFormat:@"%ld",dateCom.minute+dateCom.hour*60]] Frame:CGRectMake(KSCREENWIDTH*0.1, KSCREENHEIGHT *0.8+20, KSCREENWIDTH *0.8, 30) Font:16.0];
    
    [self addlableWithText:[NSString stringWithFormat:@"使用金额%@元",[NSString stringWithFormat:@"%@",self.dic[@"price"]]] Frame:CGRectMake(KSCREENWIDTH*0.1, KSCREENHEIGHT *0.8+45, KSCREENWIDTH *0.8, 30) Font:16.0];
    
   
#warning  卡路里假数据
    
    [self addlableWithText:[NSString stringWithFormat:@"节约碳排量%@B",@"2000"] Frame:CGRectMake(0, KSCREENHEIGHT *0.9+28, KSCREENWIDTH *0.5, 30) Font:15];
    
    
    [self addlableWithText:[NSString stringWithFormat:@"消耗卡路里%@Kcal",@"460"] Frame:CGRectMake(KSCREENWIDTH *0.5, KSCREENHEIGHT *0.9+28, KSCREENWIDTH *0.5, 30) Font:15];
    
    
    _isBOOL = NO;
    //分享背景视图
    _Share_View = [[UIView alloc]initWithFrame:CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, KSCREENWIDTH*0.2+25)];
    _Share_View.backgroundColor = [UIColor whiteColor];
    _Share_View.alpha = 1.0;
    [self.view addSubview:_Share_View];
    
//    float Button_Width = KSCREENWIDTH/5;
//    for (int i=0; i<5; i++)
//    {
//        UIButton * Share_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        Share_Btn.center = CGPointMake(Button_Width/2+(i*Button_Width), Button_Width/2);
//        Share_Btn.bounds = CGRectMake(0, 0, Button_Width-20, Button_Width-20);
//        Share_Btn.backgroundColor = [UIColor whiteColor];
//        [Share_Btn setBackgroundImage:[UIImage imageNamed:@[@"空间",@"QQ",@"微博",@"微信分享",@"朋友圈"][i]] forState:UIControlStateNormal];
//        Share_Btn.layer.cornerRadius = (Button_Width-20)/2;
//        Share_Btn.layer.masksToBounds = YES;
//        Share_Btn.tag = i+1;
//        [Share_Btn addTarget:self action:@selector(TouchShareButton:) forControlEvents:UIControlEventTouchUpInside];
//        [_Share_View addSubview:Share_Btn];
//        
//        UILabel * name_label = [[UILabel alloc]init];
//        name_label.frame = CGRectMake(i*Button_Width, CGRectGetMaxY(Share_Btn.frame)+5, Button_Width, 20);
//        
//        name_label.text = @[@"空间",@"QQ",@"微博",@"微信",@"朋友圈"][i];
//        name_label.textAlignment = NSTextAlignmentCenter;
//        if([[[UIDevice currentDevice] systemVersion] floatValue]>7.0)
//        {
//            name_label.font = [UIFont systemFontOfSize:14];
//        }
//        else
//        {
//            name_label.font = [UIFont systemFontOfSize:12];
//        }
//        name_label.textColor = COLOR(82, 81, 94, 1.0);
//        [_Share_View addSubview:name_label];
//    }

    float Button_Width = 60*KSCREENWIDTH/375;
    for (int i=0; i<3; i++)
    {
        UIButton * Share_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        Share_Btn.frame = CGRectMake(i*Button_Width + (i+1)*(KSCREENWIDTH/4-0.75*Button_Width), 10, Button_Width, Button_Width);
        Share_Btn.backgroundColor = [UIColor whiteColor];
        [Share_Btn setBackgroundImage:[UIImage imageNamed:@[@"QQ",@"微博",@"微信分享"][i]] forState:UIControlStateNormal];
        Share_Btn.layer.cornerRadius = Button_Width/2;
        Share_Btn.layer.masksToBounds = YES;
        Share_Btn.tag = i+1;
        [Share_Btn addTarget:self action:@selector(TouchShareButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_Share_View addSubview:Share_Btn];
        
        UILabel * name_label = [[UILabel alloc]init];
        name_label.frame = CGRectMake(i*Button_Width + (i+1)*(KSCREENWIDTH/4-0.75*Button_Width), CGRectGetMaxY(Share_Btn.frame)+5, Button_Width, 20);
        
        name_label.text = @[@"QQ",@"微博",@"微信"][i];
        name_label.textAlignment = NSTextAlignmentCenter;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>7.0)
        {
            name_label.font = [UIFont systemFontOfSize:14];
        }
        else
        {
            name_label.font = [UIFont systemFontOfSize:12];
        }
        name_label.textColor = COLOR(82, 81, 94, 1.0);
        [_Share_View addSubview:name_label];
    }

    
    
}

#pragma mark - 点击分享按钮
-(void)TouchShareButton:(UIButton *)sender
{
    if (sender.tag==1)
    {
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:[UIImage imageNamed:@"loading58x58"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                [self didFinishGetUMSocialDataInViewController:response];
            }
        }];
    }
    if (sender.tag==2)
    {
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享文字内容" image:[UIImage imageNamed:@"loading58x58"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                [self didFinishGetUMSocialDataInViewController:response];
            }
        }];
    }
    if (sender.tag==3)
    {
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:
         [UIImage imageNamed:@"loading58x58"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse)
         {
             if (shareResponse.responseCode == UMSResponseCodeSuccess)
             {
                 [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina completion:^(UMSocialResponseEntity *response){ NSLog(@"SnsInformation is %@",response.data); }];
                 //  [self didFinishGetUMSocialDataInViewController:shareResponse];
             }
         }];
    }
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _Share_View.frame = CGRectMake(0, KSCREENHEIGHT-KSCREENWIDTH*0.2-25, KSCREENWIDTH, KSCREENWIDTH*0.2+25);
    } completion:^(BOOL finished) {
        _isBOOL=NO;
    }];
}

///回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"分享成功的平台名称----->>>> %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark - 点击导航条右侧按钮
-(void)TouchRightItem
{
    if (_isBOOL==NO)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _Share_View.frame = CGRectMake(0, KSCREENHEIGHT-KSCREENWIDTH*0.2-25, KSCREENWIDTH, KSCREENWIDTH*0.2+25);
        } completion:^(BOOL finished) {
            _isBOOL=YES;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _Share_View.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, KSCREENWIDTH*0.2+25);
        } completion:^(BOOL finished) {
            _isBOOL=NO;
        }];
    }
}


- (void)addlableWithText:(NSString *)text Frame:(CGRect)frame Font:(CGFloat) number {
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.textColor = [UIColor whiteColor];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:number];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
}

//地图定位
- (void)drawLine {
    CLLocation *location = self.mutArray[0];
    
    MKCoordinateRegion region;
    region.span = MKCoordinateSpanMake(0.01, 0.01);
    region.center = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude);
    [self.mapView setRegion:region animated:YES];
    
    [self drawLineWithLocationArray:self.mutArray];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapSample"];
    
    annotationView.canShowCallout = YES;
    
    return annotationView;
}

//地图画线
- (void)drawLineWithLocationArray:(NSMutableArray *)locationArray
{
    MKMapPoint* pointArray = malloc(sizeof(CLLocationCoordinate2D) * locationArray.count);
    
    for(int idx = 0; idx < locationArray.count; idx++)
    {
        CLLocation *location = [locationArray objectAtIndex:idx];
        
        CLLocationDegrees latitude  = location.coordinate.latitude;
        
        CLLocationDegrees longitude = location.coordinate.longitude;
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        pointArray[idx] = point;
    }
    
    if (_routeLine) {
        [_mapView removeOverlay:_routeLine];
    }
    
    _routeLine = [MKPolyline polylineWithPoints:pointArray count:locationArray.count];
    
    if (nil != _routeLine) {
        [_mapView addOverlay:_routeLine];
    }
    
    free(pointArray);
}

//减小内存
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.mapView removeFromSuperview];
    
    [self.view addSubview:mapView];
}

//地图线属性
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    renderer.strokeColor = [UIColor redColor];
    
    renderer.lineWidth = 3;
    
    return renderer;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
