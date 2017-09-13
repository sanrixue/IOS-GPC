//
//  QRCodeReaderView.m
//  MfpQRCode
//
//  Created by 浙江梦之想 on 16/3/30.
//  Copyright © 2016年 浙江梦之想. All rights reserved.
//


#import "QRCodeReaderView.h"
#import <AVFoundation/AVFoundation.h>

#define KSCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)
#define KSCREENWIDTH ([UIScreen mainScreen].bounds.size.width)
#define widthRate KSCREENWIDTH/320
#define kGSize [[UIScreen mainScreen] bounds].size
#define contentTitleColorStr @"666666"

@interface QRCodeReaderView ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession * session;
    
    NSTimer * countTime;
    
}
@property (nonatomic, strong) CAShapeLayer *overlay;
@end

@implementation QRCodeReaderView


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        [self instanceDevice];
    }
    
    return self;
}

- (void)instanceDevice
{
    //扫描区域
    // 蓝线
    
    UIImageView *line = [[UIImageView alloc] initWithFrame: CGRectMake(KSCREENWIDTH/2-65, (KSCREENHEIGHT-300*widthRate)/2, 130, 3)];
    
    line.image = [UIImage imageNamed:@"ipad_user_code_Scanningline"];
    line.backgroundColor = [UIColor redColor];
    
    [self addSubview:line ];
    
    /* 添加动画 */
    
    [UIView animateWithDuration:2.5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
        
        line.frame = CGRectMake(KSCREENWIDTH/2-65, (KSCREENHEIGHT-300*widthRate)/2+200*widthRate, 130, 3);
        
    } completion:nil];
    
    UIImageView * scanZomeBack=[[UIImageView alloc] init];
    scanZomeBack.backgroundColor = [UIColor clearColor];
    //添加一个背景图片
    CGRect mImagerect = CGRectMake(60*widthRate, (KSCREENHEIGHT-300*widthRate)/2, 200*widthRate, 200*widthRate);
    [scanZomeBack setFrame:mImagerect];
    CGRect scanCrop=[self getScanCrop:mImagerect readerViewBounds:self.frame];
    [self addSubview:scanZomeBack];
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.rectOfInterest = scanCrop;
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [session addInput:input];
    }
    if (output) {
        [session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    
    [self setOverlayPickerView:self];
    
    //开始捕获
    [session startRunning];
    
    
}

-(void)loopDrawLine
{
    _is_AnmotionFinished = NO;
    CGRect rect = CGRectMake(65*widthRate, (KSCREENHEIGHT-300*widthRate)/2, 190*widthRate, 2);
    if (_readLineView) {
        _readLineView.alpha = 1;
        _readLineView.frame = rect;
    }
    else{
        _readLineView = [[UIImageView alloc] initWithFrame:rect];
        [_readLineView setImage:[UIImage imageNamed:@"scan_line"]];
        [self addSubview:_readLineView];
    }
    
    [UIView animateWithDuration:1.5 animations:^{
        //修改fream的代码写在这里
        _readLineView.frame =CGRectMake(65*widthRate, (KSCREENHEIGHT-300*widthRate)/2+200*widthRate, 190*widthRate, 2);
    } completion:^(BOOL finished) {
        if (!_is_Anmotion) {
            [self loopDrawLine];
        }
        _is_AnmotionFinished = YES;
    }];
}

- (void)setOverlayPickerView:(QRCodeReaderView *)reader
{
    
    CGFloat wid = 60*widthRate;
    CGFloat heih = (KSCREENHEIGHT-300*widthRate)/2;
    
    //最上部view
    CGFloat alpha = 0.6;
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, (KSCREENHEIGHT-300*widthRate)/2)];
    upView.alpha = alpha;
    upView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader addSubview:upView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, KSCREENWIDTH, 30)];
    lab.text = @"扫描二维码解锁车子";
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [reader addSubview:lab];
    
    //左侧的view
    UIView * cLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, heih, wid, 200*widthRate)];
    cLeftView.alpha = alpha;
    cLeftView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader addSubview:cLeftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(KSCREENWIDTH-wid, heih, wid, 200*widthRate)];
    rightView.alpha = alpha;
    rightView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader addSubview:rightView];
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, (KSCREENHEIGHT-300*widthRate)/2+200*widthRate, KSCREENWIDTH, KSCREENHEIGHT - heih-200*widthRate)];
    downView.alpha = alpha;
    downView.backgroundColor = [self colorFromHexRGB:contentTitleColorStr];
    [reader addSubview:downView];
    
    
    UIButton * putBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    putBtn.backgroundColor = [UIColor clearColor];
    putBtn.frame=CGRectMake(KSCREENWIDTH *0.25,KSCREENHEIGHT * 0.8 - 60,KSCREENWIDTH*0.5,40);
    [putBtn setTitle:@"手动输入编号" forState:UIControlStateNormal];
    [putBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [putBtn addTarget:self action:@selector(putBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [reader addSubview:putBtn];
    putBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    putBtn.layer.borderWidth = 1;
    
    //开关灯button
    UIButton * turnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    turnBtn.backgroundColor = [UIColor clearColor];
    turnBtn.frame=CGRectMake(KSCREENWIDTH * 0.25,KSCREENHEIGHT * 0.8,KSCREENWIDTH*0.5,40);
    [turnBtn setTitle:@"打开手电筒" forState:UIControlStateNormal];
    [turnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [turnBtn addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [reader addSubview:turnBtn];
    turnBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    turnBtn.layer.borderWidth = 1;
    
    
    UIButton * shuomingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shuomingBtn.backgroundColor = [UIColor clearColor];
    shuomingBtn.frame=CGRectMake(KSCREENWIDTH *0.25,KSCREENHEIGHT * 0.8 + 60,KSCREENWIDTH*0.5,40);
    [shuomingBtn setTitle:@"使用说明" forState:UIControlStateNormal];
    [shuomingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shuomingBtn addTarget:self action:@selector(shuomingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [reader addSubview:shuomingBtn];
    shuomingBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    shuomingBtn.layer.borderWidth = 1;
}

- (void)putBtnClick {
    NSLog(@"put~~~~~~~~~~");
}

- (void)shuomingBtnClick {
    NSLog(@"shuoming~~~~~~~~~~~~~");
}

- (void)turnBtnEvent:(UIButton *)button_
{
    button_.selected = !button_.selected;
    if (button_.selected)
    {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
    
}

- (void)turnTorchOn:(bool)on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    
    x = (rect.origin.y)/CGRectGetHeight(readerViewBounds);
    y = rect.origin.x/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}

- (void)start
{
    [session startRunning];
}

- (void)stop
{
    [session stopRunning];
}

#pragma mark - 扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects && metadataObjects.count>0) {
        //        [session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        if (_delegate && [_delegate respondsToSelector:@selector(readerScanResult:)]) {
            [_delegate readerScanResult:metadataObject.stringValue];
        }
    }
}

#pragma mark - 颜色
//获取颜色
- (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
