//
//  ViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/4.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "ViewController.h"
#import "GuideViewController.h"
#import "CarTroubleViewController.h"
#import "PersonalViewController.h"
#import "SearchViewController.h"
#import "BMKClusterManager.h"
#import "MFpScanQCodeViewController.h"

/*
 *点聚合Annotation
 */
@interface ClusterAnnotation : BMKPointAnnotation

@property (nonatomic,assign) NSInteger size;

@end

@implementation ClusterAnnotation

@synthesize size = _size;

@end
/*
 *点聚合Annotation的载体View
 */

@interface ClusterAnnotationView : BMKPinAnnotationView{
   
}
@property (nonatomic,assign)NSInteger size;
@property (nonatomic,strong)UILabel * label;

@end

@implementation ClusterAnnotationView

@synthesize size = _size;
@synthesize label = _label;
//初始化ClusterAnnotationView的类
-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBounds:CGRectMake(0.f, 0.f, 30.f, 30.f)];
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 3.f, 30.f, 15.f)];
        _label.textColor = [UIColor redColor];
        [_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//计算一下聚合点的标注的多少
- (void)setSize:(NSInteger)size
{
    _size = size;
    if (_size == 1)   //如果只有一个标注点
    {
        self.label.hidden = YES;    //让显示聚合点标注数量的按钮匿藏
    }
    else
    {
        self.label.hidden = NO;
        _label.text = [NSString stringWithFormat:@"%lu",(long)size];
    }
}

@end



//本类
@interface ViewController ()<UIWebViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    BMKClusterManager *_clusterManager; //点聚合管理类
    NSInteger _clusterZoom;  //聚合级别     也就是一个聚合点内有几个标注
    NSMutableArray * _clusterCaches;  //点聚合缓存标注
    NSInteger _mapLevel;  //地图精确级别
    
}

@property (nonatomic ,strong) UIView *headView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayModel;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UILabel *lab6;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIButton *yuyueBtn;


@end

@implementation ViewController

- (UIButton *)yuyueBtn {
    if (_yuyueBtn == nil) {
        _yuyueBtn = [[UIButton alloc] init];
    }
    return _yuyueBtn;
}

- (UIImageView *)iconImage {
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)addressLab {
    if (_addressLab == nil) {
        _addressLab = [[UILabel alloc] init];
    }
    return _addressLab;
}
- (UILabel *)lineLab {
    if (_lineLab == nil) {
        _lineLab = [[UILabel alloc] init];
    }
    return _lineLab;
}
- (UILabel *)lab1 {
    if (_lab1 == nil) {
        _lab1 = [[UILabel alloc] init];
    }
    return _lab1;
}
- (UILabel *)lab2 {
    if (_lab2 == nil) {
        _lab2 = [[UILabel alloc] init];
    }
    return _lab2;
}
- (UILabel *)lab3 {
    if (_lab3 == nil) {
        _lab3 = [[UILabel alloc] init];
    }
    return _lab3;
}
- (UILabel *)lab4 {
    if (_lab4 == nil) {
        _lab4 = [[UILabel alloc] init];
    }
    return _lab4;
}
- (UILabel *)lab5 {
    if (_lab5 == nil) {
        _lab5 = [[UILabel alloc] init];
    }
    return _lab5;
}
- (UILabel *)lab6 {
    if (_lab6 == nil) {
        _lab6 = [[UILabel alloc] init];
    }
    return _lab6;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    //自带方法
    [_mapView viewWillAppear];
    
    [self mapView];    //基础地图
    [self locService]; //定位
    [self poisearch];  //POI
    _mapView.delegate = self;
    _locService.delegate = self;
    
    
    [self NewView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;   //定位指向空
    _poisearch.delegate = nil;
    
    [self.blackView removeFromSuperview];
    [self.tableView removeFromSuperview];
    [self.headView removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"GPC"];
    

     _isSearch =YES;
    
    //左侧侧滑按钮
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(0, 0, 30, 30);
    [leftbtn addTarget:self action:@selector(ClickLeftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setImage:[UIImage imageNamed:@"LeftItem.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    //右侧侧滑按钮
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 30, 30);
    [rightbtn addTarget:self action:@selector(ClickrightItem) forControlEvents:UIControlEventTouchUpInside];
    [rightbtn setImage:[UIImage imageNamed:@"rightItem.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.arrayModel = @[@"用车故障",@"用户指南"];
    
}

- (void)NewView {
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT * 0.8, KSCREENWIDTH, KSCREENHEIGHT * 0.1)];
    newView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:newView];

    UIButton * saoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saoBtn.frame = CGRectMake(KSCREENWIDTH * 0.5 - 45, 0, 90, 90);
 
    saoBtn.backgroundColor = [UIColor clearColor];
    [saoBtn setImage:[UIImage imageNamed:@"sao"] forState:UIControlStateNormal];
    [saoBtn addTarget:self action:@selector(saoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [newView addSubview:saoBtn];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 30, 55, 30);
    
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn setImage:[UIImage imageNamed:@"leftBtn"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [newView addSubview:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(KSCREENWIDTH - 55, 30, 55, 30);
    
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"rightBtn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(ClickrightBtn) forControlEvents:UIControlEventTouchUpInside];
    [newView addSubview:rightBtn];
    
}

- (void)saoBtnClick {
    MFpScanQCodeViewController *vc=[[MFpScanQCodeViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 点击左侧Item按钮
- (void)ClickLeftItem
{
    PersonalViewController *personalVC = [[PersonalViewController alloc] init];
    
    [self.navigationController pushViewController:personalVC animated:YES];
    
}
#pragma mark - 点击右侧Item按钮

- (void)ClickrightItem
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
    [searchVC returnText:^(NSString *searchText) {
        self.searchText = searchText;
        
        [self searchEND];
    }];
    
}

- (void)searchEND  {
    //初始化检索对象
    BMKGeoCodeSearch * _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= _city;
    geoCodeSearchOption.address = self.searchText;
    BOOL flag2 = [_searcher geoCode:geoCodeSearchOption];
    if(flag2)
    {
        NSLog(@"geo检索发送成功");
        _isSearch =NO;
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }

}

#pragma mark - 点击左侧Btn按钮
- (void)ClickLeftBtn
{
    NSLog(@"点击了左侧定位按钮");
    
    [_mapView removeAnnotations:_mapView.annotations];
    _mapView.centerCoordinate = _oldCLLocation.coordinate;
    
    _lat = [NSString stringWithFormat:@"%f",_oldCLLocation.coordinate.latitude];
    
    _lng = [NSString stringWithFormat:@"%f",_oldCLLocation.coordinate.longitude];
    
    [self createCluster];

}

#pragma mark - 点击右侧Btn按钮
- (void)ClickrightBtn
{
//    UIView *blackView = [[UIView alloc] init];
//    blackView.backgroundColor = [UIColor blackColor];
//    blackView.alpha = 0.5;
//    blackView.frame = self.view.frame;
//    [self.view addSubview:blackView];
//    self.blackView = blackView;
//    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSCREENHEIGHT * 0.82, KSCREENWIDTH, KSCREENHEIGHT * 0.18) style:UITableViewStylePlain];
//    
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    
//    self.tableView.delegate = self;
//    
//    self.tableView.dataSource = self;
//    
//    self.tableView.scrollEnabled = NO;
//    
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    
//    [self.view addSubview:self.tableView];
    
    [self startChoose];
}

//开始创建actionSheet
- (void)startChoose {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"用车故障", @"用户指南", nil];
    
    [choiceSheet showInView:self.view];
}

// actionSheet的代理方法，用来设置每个按钮点击的触发事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        CarTroubleViewController *troubleVC = [[CarTroubleViewController alloc] init];
        
        [self.navigationController pushViewController:troubleVC animated:YES];
     
    } else if(buttonIndex == 1){
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        
        [self.navigationController pushViewController:guideVC animated:YES];
    }
    else{
        [actionSheet setHidden:YES];
    }
    
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.arrayModel.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *tableSampleIndentifier = @"tableSampleIndentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableSampleIndentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIndentifier];
//    } else {
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView *)[cell.contentView.subviews lastObject]removeFromSuperview];
//        }
//    }
//    
//    cell.textLabel.text = self.arrayModel[indexPath.row];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    
//    return cell;
//    
//}
//
////设置单元格高度
//-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 55;
//    
//}
//
////选中单元格所产生事件
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        CarTroubleViewController *troubleVC = [[CarTroubleViewController alloc] init];
//        
//        [self.navigationController pushViewController:troubleVC animated:YES];
//    
//    } else if (indexPath.row == 1) {
//        GuideViewController *guideVC = [[GuideViewController alloc] init];
//        
//        [self.navigationController pushViewController:guideVC animated:YES];
//    }
//
//    [self.blackView removeFromSuperview];
//    [self.tableView removeFromSuperview];
//}
//


#pragma mark - BMK_MAP ------------基础地图
- (BMKMapView *)mapView
{
    if (!_mapView)
    {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0,KSCREENWIDTH , KSCREENHEIGHT)];
        [_mapView setZoomLevel:15];  //设置地图比例
        //切换为普通地图
        [_mapView setMapType:BMKMapTypeStandard];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}
#pragma mark - BMK_Location----------基础定位
- (BMKLocationService *)locService
{
    if (_locService == nil){
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        
        //设定定位精度
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
        
        //开启定位服务
        [_locService startUserLocationService];
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态  (普通模式)
        _mapView.showsUserLocation = YES;//显示定位图层
        
    }
    return _locService;
}
#pragma mark - ---------------------------------基础定位代理方法------------------------------
#pragma mark - -----------方向更新后调用的方法
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //刷新我在地图上面的位置
    [_mapView updateLocationData:userLocation];
}


#pragma mark - 聚合点定位
//点聚合View
- (void)createCluster{
    
    //点聚合管理类
    _clusterManager = [[BMKClusterManager alloc] init];
    
    NSString *byUrl = [NSString stringWithFormat:Bycicle_URL,[_lat doubleValue],[_lng doubleValue]];
    
    NSString * url =[NSString stringWithFormat:Main_URL,byUrl];
    
    NSLog(@"！！！！！！！！！！！！！%@",url);
    
    [Tools POST:url params:nil superviewOfMBHUD:nil success:^(id responseObj)
     {
         //         NSLog(@"请求成功---->>>>%@",responseObj[@"data"]);
         if (responseObj[@"data"] != nil) {
             
             NSArray *array = responseObj[@"data"];
             
             //用来缓存已经加载的点聚合View
             _clusterCaches = [[NSMutableArray alloc]init];
             for (NSInteger i=3; i<21; i++)
             {
                 [_clusterCaches addObject:[NSMutableArray array]];
             }
             //向点聚合管理类中添加标注
             for (NSInteger i = 0; i < array.count; i++)
             {
                 double lat = [array[i][@"lat"] doubleValue] ;
                 double lon = [array[i][@"lng"] doubleValue] ;
                 BMKClusterItem *clusterItem = [[BMKClusterItem alloc] init];
                 clusterItem.coor = CLLocationCoordinate2DMake(lat,lon);
                 [_clusterManager addClusterItem:clusterItem];
             }
             [self updateClusters];
             
         } else {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"附近没有自行车" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             
             [alert show];
         }
         
     } failure:^(NSError *error) {
         
         NSLog(@"请求出错--->>>%@",error);
     }];
}

#pragma mark - 更新点聚合方法
//更新聚合状态
- (void)updateClusters {


    _clusterZoom = (NSInteger)_mapView.zoomLevel;
    
   
    
    @synchronized(_clusterCaches) {
        if (_clusterZoom > 20) {
            _mapLevel = 17;
        } else {
            _mapLevel = _clusterZoom - 3;
        }
        
        
        __block NSMutableArray *clusters = [_clusterCaches objectAtIndex:_mapLevel];
    
        
        if (clusters.count > 0) {
            [_mapView removeAnnotations:_mapView.annotations];
            [_mapView addAnnotations:clusters];
        } else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                ///获取聚合后的标注
                __block NSArray *array = [_clusterManager getClusters:_clusterZoom];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (BMKCluster *item in array) {
                        ClusterAnnotation *annotation = [[ClusterAnnotation alloc] init];
                        annotation.coordinate = item.coordinate;
                        annotation.size = item.size;
                        annotation.title = [NSString stringWithFormat:@"%lu辆自行车", (unsigned long)item.size];
                        [clusters addObject:annotation];
                    }
                    [_mapView removeAnnotations:_mapView.annotations];
                    [_mapView addAnnotations:clusters];
                });
            });
        }
    }
}

#pragma mark - MAPStart_Locating
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"开始定位");
    
}
#pragma mark - MAPDidLoad
//地图加载完成之后调用
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    //    [self updateClusters];
}
#pragma mark - 每次地图缩放后调用的方法
/**
 *地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
 *@param mapview 地图View
 *@param status 此时地图的状态
 */
- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status {
    if (_clusterZoom != 0 && _clusterZoom != (NSInteger)mapView.zoomLevel)
    {
        [self updateClusters];
    }
}



#pragma mark - 位置更新之后调用方法
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //刷新我在地图上的位置
    [_mapView updateLocationData:userLocation];
    
    _oldCLLocation = userLocation.location;
    
    if (_isNewEnter==NO)  //判断是否是第一次进入地图，如果是就反地理编译一下
    {
        
        //反地理编码出地理位置
        CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
        pt=(CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BMKGeoCodeSearch *_geocodesearch = [[BMKGeoCodeSearch alloc]init];
        _geocodesearch.delegate = self;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
        _isNewEnter = YES;   //让BOOL变成否，关闭自动反地理编译
        
    }
}

#pragma mark - 正地理编码代理方法   输入位置返回坐标
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    [_mapView removeAnnotations:_mapView.annotations];
    // 添加一个PointAnnotation   标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = result.location;

    annotation.title = self.searchText;
    
    [_mapView addAnnotation:annotation];
    //让地图的位置处于搜索处的位置
    _mapView.centerCoordinate = result.location;
    
    _lat = [NSString stringWithFormat:@"%f",result.location.latitude];
    
    _lng = [NSString stringWithFormat:@"%f",result.location.longitude];

    //点聚合
     [self createCluster];
}
#pragma mark - 反地理编码代理方法  输入坐标 返回地点名称
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"result.address = %@",result.address);  //定位所在地址
    NSLog(@"result.detail.address.city = %@",result.addressDetail.city);   //定位所在城市
    NSLog(@"result.businessCircle = %@",result.businessCircle);  //用户所在商圈(发布动态)
    NSLog(@"result.addressDetail.district = %@",result.addressDetail.district);  //用户所在区
    NSLog(@"result   %f   %f",result.location.latitude,result.location.longitude);  //经纬度
    _city = result.addressDetail.city;   //字符串接受现在所在的城市
    
    
    self.address = result.address;

    _mapView.centerCoordinate = result.location;
    
    _lat = [NSString stringWithFormat:@"%f",result.location.latitude];
    
    _lng = [NSString stringWithFormat:@"%f",result.location.longitude];
    
    [self createCluster];  //点聚合
}



#pragma mark - 在基础地图添加标注的时候调用的方法   添加标注的代理方法  类似于tableviewCell初始化
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    

    if ([annotation.title isEqualToString:self.searchText])   //如果是搜索出来的标注  进行下面的配置
    
    {
        // 生成重用标示identifier
        NSString * AnnotationViewID = @"xidanMark";
        // 检查是否有重用的缓存
        BMKAnnotationView*  annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
        if (annotationView == nil)
        {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            //设置大头针颜色
            ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorGreen;
            // 设置重天上掉下的效果(annotation)
            ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        }
        // 设置位置
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
        annotationView.annotation = annotation;
        // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
        annotationView.canShowCallout = YES;
        // 设置是否可以拖拽
        annotationView.draggable = NO;
        return annotationView;
    }
    else     //如果不是  那么就添加点聚合
    {
        //普通annotation
        NSString *AnnotationViewID = @"ClusterMark";
        ClusterAnnotation *cluster = (ClusterAnnotation*)annotation;
        ClusterAnnotationView *annotationView = [[ClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        annotationView.size = cluster.size;
        annotationView.draggable = YES;
        annotationView.annotation = cluster;
        annotationView.image=[UIImage imageNamed:@"zixinche"];
     
        return annotationView;
       

    }
}

#pragma mark - 点击标注调用的方法
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
    
    if ([view isKindOfClass:[ClusterAnnotationView class]])
    {
        ClusterAnnotation *clusterAnnotation = (ClusterAnnotation*)view.annotation;
        if (clusterAnnotation.size > 1)
        {
            [mapView setCenterCoordinate:view.annotation.coordinate];
            [mapView zoomIn];
            NSLog(@"自行车数量大于1");
        }
    }
    
    NSLog(@"点击了小标注");
    
}

//添加标注
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
//     [mapView removeAnnotations:views];
//    NSLog(@"添加小标注");
}


#pragma mark - 添加标注的回调函数   是否成功
//实现POISearchDeleage处理回调结果
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    //  NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    //  [_mapView removeAnnotations:array];
    NSLog(@"标注的回调方法，检测是否调用------");
    if (error == BMK_SEARCH_NO_ERROR)
    {
        NSLog(@"标注返回成功");
        NSLog(@"输出POI总数--->>>%d",result.totalPoiNum);///本次POI搜索的总结果数
        NSLog(@"输出POI列表--->>>%@",result.poiInfoList);
        NSLog(@"输出城市列表---->>>>%@",result.cityList);
        
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation * item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if(error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR)
    {
        
    } else
    {
        // 各种情况的判断。。。
        NSLog(@"添加标注失败");
    }
    
    
}

/*
 *点击按钮之后,清楚搜索的位置
 *让地图的中心设置为自己
 */
#pragma mark - 点击我的位置按钮
//- (void)TouchMy_Center{
//    
////    [_mapView removeAnnotations:_mapView.annotations];
////    _mapView.centerCoordinate = _oldCLLocation.coordinate;
////    [self createCluster];
//}




/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    NSLog(@"点击聚合点");
    if ([view isKindOfClass:[ClusterAnnotationView class]])
    {
        ClusterAnnotation *clusterAnnotation = (ClusterAnnotation*)view.annotation;
        if (clusterAnnotation.size > 1)
        {
            [mapView setCenterCoordinate:view.annotation.coordinate];
            [mapView zoomIn];
            
            
        }
        
        _cheCLLocation = [[CLLocation alloc] initWithLatitude: view.annotation.coordinate.latitude longitude: view.annotation.coordinate.longitude];
        
        [self creatNewView];
    }
    
}

- (UIView *)headView {
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
    }
    return _headView;
}

- (void)creatNewView {
    self.headView.frame = CGRectMake(0, 64, KSCREENWIDTH, 190);
    self.headView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95];
    
    [self.view addSubview:self.headView];
    
    
    self.iconImage.frame = CGRectMake(20, 12, 25, 25);
    self.iconImage.image = [UIImage imageNamed:@"ding"];
    [self.headView addSubview:self.iconImage];
    
    self.addressLab.frame = CGRectMake(50, 10, KSCREENWIDTH-90, 30);
    self.addressLab.text = self.address;
    self.addressLab.font = [UIFont systemFontOfSize:15];
    [self.headView addSubview:self.addressLab];

    
    self.lineLab.frame = CGRectMake(0, 50, KSCREENWIDTH, 1);
    self.lineLab.backgroundColor = [UIColor lightGrayColor];
    self.lineLab.alpha = 0.3;
    [self.headView addSubview:self.lineLab];
    
    self.lab1.frame = CGRectMake(KSCREENWIDTH/4 - 75, 60, 100, 40);
    self.lab1.text = @"1";
    self.lab1.textColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    self.lab1.font = [UIFont systemFontOfSize:16];
    self.lab1.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.lab1];
    
    
    CLLocationDistance distance = [_oldCLLocation distanceFromLocation:_cheCLLocation];
    NSInteger juli = (NSInteger)distance;
    
    self.lab2.frame = CGRectMake(KSCREENWIDTH/2 - 50, 60, 100, 40);
    self.lab2.text = [NSString stringWithFormat:@"%ldm",juli];
    self.lab2.textColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    self.lab2.font = [UIFont systemFontOfSize:16];
    self.lab2.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.lab2];
    
    NSInteger time = (NSInteger)distance/80;
    
    self.lab4.frame = CGRectMake(KSCREENWIDTH*0.75 - 25, 60, 100, 40);
    self.lab4.text = [NSString stringWithFormat:@"%ld分钟",time + 1];
    self.lab4.textColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    self.lab4.font = [UIFont systemFontOfSize:16];
    self.lab4.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.lab4];
    
    self.lab5.frame = CGRectMake(KSCREENWIDTH/4 - 75, 100, 100, 20);
    self.lab5.text = @"可用自行车";
    self.lab5.font = [UIFont systemFontOfSize:13];
    self.lab5.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.lab5];
    
    self.lab6.frame = CGRectMake(KSCREENWIDTH/2 - 50, 100, 100, 20);
    self.lab6.text = @"距离当前位置";
    self.lab6.font = [UIFont systemFontOfSize:13];
    self.lab6.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.lab6];
    
    self.lab3.frame = CGRectMake(KSCREENWIDTH*0.75 - 25, 100, 100, 20);
    self.lab3.text = @"步行可到达";
    self.lab3.font = [UIFont systemFontOfSize:13];
    self.lab3.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.lab3];
    
    
  
    self.yuyueBtn.frame = CGRectMake(KSCREENWIDTH *0.2, 140, KSCREENWIDTH * 0.6, 30);
    [self.yuyueBtn setTitle:@"预约用车" forState:UIControlStateNormal];
    self.yuyueBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.yuyueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yuyueBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.yuyueBtn addTarget:self action:@selector(yuyueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.yuyueBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    self.yuyueBtn.layer.cornerRadius = 5;
    [self.headView addSubview:self.yuyueBtn];
}



- (void)yuyueBtnClick {
    NSLog(@"预约用车");
    
    [self.headView removeFromSuperview];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"停止定位");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败----->>>>%@",error);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
