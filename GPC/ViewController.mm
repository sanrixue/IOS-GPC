//
//  ViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/4.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>


@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //自带方法
    [_mapView viewWillAppear];
    
    [self mapView];    //基础地图

    _mapView.delegate = self;

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_mapView viewWillDisappear];
    
    _mapView.delegate = nil;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    web.delegate = self;
//    NSString * urlStr = @"http://121.43.108.95:8081/water/view/bushui/land.html";
//    NSURL * url = [NSURL URLWithString:urlStr];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
//    [web loadRequest:request];
//    [self.view addSubview:web];

    
    
}
#pragma mark - BMK_MAP
- (BMKMapView *)mapView{
    if (!_mapView)
    {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 50,KSCREENWIDTH , KSCREENHEIGHT-KNagHEIGHT)];
        [_mapView setZoomLevel:15];  //设置地图比例
        //切换为普通地图
        [_mapView setMapType:BMKMapTypeStandard];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
