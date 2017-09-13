//
//  ViewController.h
//  GPC
//
//  Created by 董立峥 on 16/8/4.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>



//基础地图            添加定位代理
@interface ViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)BMKMapView *mapView;//基础地图

@property(nonatomic,strong)BMKLocationService *locService;//定位

@property(nonatomic,strong)BMKPoiSearch *poisearch;  //POI

@property(strong,nonatomic)NSString *city;   //当前所在城市

@property(assign,nonatomic)BOOL isNewEnter;   //是否是第一次进入，进行定位

@property(nonatomic,readonly)CLLocation *oldCLLocation;   //用来记录自己的位置

@property(nonatomic,assign)BOOL isSearch;   //判断是否是搜索的标注

@property(nonatomic,strong)NSMutableArray *POST_MutAry;   //用来盛放后台请求的坐标的控制器

@property(strong,nonatomic)NSString *lat;   //当前所在经度

@property(strong,nonatomic)NSString *lng;   //当前所在纬度

@property(nonatomic,readonly)CLLocation *cheCLLocation;   //用来记录车的位置

@end

