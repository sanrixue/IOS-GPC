//
//  CarTroubleViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/17.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "CarTroubleViewController.h"
#import "MFpScanQCodeViewController.h"

@interface CarTroubleViewController ()<UITextViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *addLable;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@property (nonatomic, strong) UIButton *btn5;
@property (nonatomic, strong) UIButton *btn6;
@property (nonatomic, strong) NSString *str1;
@property (nonatomic, strong) NSString *str2;
@property (nonatomic, strong) NSString *str3;
@property (nonatomic, strong) NSString *str4;
@property (nonatomic, strong) NSString *str5;
@property (nonatomic, strong) NSString *str6;


@property (nonatomic, strong) UIButton *paiBtn;

@property (nonatomic, strong) NSData *paiData;

@end

@implementation CarTroubleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"用车故障";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpUI];
}

- (void)setUpUI {
     CreatControls *creatControls = [[CreatControls alloc] init];
    
    UILabel *lab1 = [[UILabel alloc] init];
    [creatControls label:lab1 Name:@"发现并上报问题车辆" andFrame:CGRectMake(0, 70, KSCREENWIDTH, 30)];
    [self.view addSubview:lab1];
    
    UIButton *btn1 = [[UIButton alloc] init];
    [creatControls button:btn1 Title:@"  举报违规" Frame:CGRectMake(20, 120, KSCREENWIDTH * 0.5 - 40, KSCREENWIDTH * 0.125 - 10) TitleColor:[UIColor grayColor] Selector:@selector(btn1Click) BackgroundColor:nil Image:[UIImage imageNamed:@"n"]];
    [self.view addSubview:btn1];
    self.btn1 = btn1;
    self.btn1.tag = 1;
    
    UIButton *btn2 = [[UIButton alloc] init];
    [creatControls button:btn2 Title:@"  开不了锁" Frame:CGRectMake(20, KSCREENWIDTH * 0.125 +120, KSCREENWIDTH * 0.5 - 40, KSCREENWIDTH * 0.125 - 10) TitleColor:[UIColor grayColor] Selector:@selector(btn2Click) BackgroundColor:nil Image:[UIImage imageNamed:@"n"]];
    [self.view addSubview:btn2];
    self.btn2 = btn2;
    self.btn2.tag = 3;
    
    UIButton *btn3 = [[UIButton alloc] init];
    [creatControls button:btn3 Title:@"  关不了锁" Frame:CGRectMake(20, KSCREENWIDTH * 0.25 + 120, KSCREENWIDTH * 0.5 - 40, KSCREENWIDTH * 0.125 - 10) TitleColor:[UIColor grayColor] Selector:@selector(btn3Click) BackgroundColor:nil Image:[UIImage imageNamed:@"n"]];
    [self.view addSubview:btn3];
    self.btn3 = btn3;
    self.btn3.tag = 5;
    
    UIButton *btn4 = [[UIButton alloc] init];
    [creatControls button:btn4 Title:@"  二维码脱落" Frame:CGRectMake(20, KSCREENWIDTH * 0.375 +120, KSCREENWIDTH * 0.5 - 40, KSCREENWIDTH * 0.125 - 10) TitleColor:[UIColor grayColor] Selector:@selector(btn4Click) BackgroundColor:nil Image:[UIImage imageNamed:@"n"]];
    [self.view addSubview:btn4];
    self.btn4 = btn4;
    self.btn4.tag = 7;
    
    UIButton *btn5 = [[UIButton alloc] init];
    [creatControls button:btn5 Title:@"  刹车失灵" Frame:CGRectMake(20, KSCREENWIDTH * 0.5 +120, KSCREENWIDTH * 0.5 - 40, KSCREENWIDTH * 0.125 - 10) TitleColor:[UIColor grayColor] Selector:@selector(btn5Click) BackgroundColor:nil Image:[UIImage imageNamed:@"n"]];
    [self.view addSubview:btn5];
    self.btn5 = btn5;
    self.btn5.tag = 9;
    
    UIButton *btn6 = [[UIButton alloc] init];
    [creatControls button:btn6 Title:@"  其他" Frame:CGRectMake(20, KSCREENWIDTH * 0.625 +120, KSCREENWIDTH * 0.5 - 40, KSCREENWIDTH * 0.125 - 10) TitleColor:[UIColor grayColor] Selector:@selector(btn6Click) BackgroundColor:nil Image:[UIImage imageNamed:@"n"]];
    [self.view addSubview:btn6];
    self.btn6 = btn6;
    self.btn6.tag = 11;
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(KSCREENWIDTH * 0.11, KSCREENWIDTH * 0.75 +150, KSCREENWIDTH * 0.78, KSCREENWIDTH * 0.2)];
    textView.font = [UIFont systemFontOfSize:16];
    textView.textColor = [UIColor blackColor];
    textView.backgroundColor = [UIColor clearColor];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.delegate = self;
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 1;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:textView];
    self.textView = textView;
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH * 0.78, KSCREENWIDTH * 0.2)];
    lab2.enabled = NO;
    lab2.text = @"问题补充描述";
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.backgroundColor = [UIColor clearColor];
    lab2.font =  [UIFont systemFontOfSize:16];
    lab2.textColor = [UIColor lightGrayColor];
    [self.textView addSubview:lab2];
    self.addLable = lab2;
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, KSCREENWIDTH * 0.95 +170, KSCREENWIDTH * 0.7, KSCREENWIDTH * 0.125 -10);
    [PUTBtn setTitle:@"提交" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];
    
    
    UIButton *saoBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH *0.5 + 30, 120, KSCREENWIDTH * 0.5 - 60, KSCREENWIDTH * 0.5 - 60)];
    [saoBtn setBackgroundImage:[UIImage imageNamed:@"saomiao"] forState:UIControlStateNormal];
    [saoBtn addTarget:self action:@selector(saoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saoBtn];
    
    
    self.paiBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREENWIDTH *0.5 + 30, KSCREENWIDTH * 0.25 + 180, KSCREENWIDTH * 0.5 - 60, KSCREENWIDTH * 0.5 - 60)];
    [self.paiBtn setBackgroundImage:[UIImage imageNamed:@"paizhao"] forState:UIControlStateNormal];
    [self.paiBtn setBackgroundImage:[UIImage imageNamed:@"paizhao"] forState:UIControlStateHighlighted];
    [self.paiBtn addTarget:self action:@selector(paiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.paiBtn];
    
    
    
}

- (void)saoBtnClick {
    MFpScanQCodeViewController *vc=[[MFpScanQCodeViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)paiBtnClick {
    [self startChoosePhoto];
}

- (void) textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        [self.addLable setHidden:NO];
    }else{
        [self.addLable setHidden:YES];
    }
}

- (void)btn1Click {
    
    if (self.btn1.tag == 1) {
        [self.btn1 setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
        self.btn1.tag = 2;
    } else if (self.btn1.tag == 2) {
        [self.btn1 setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        self.btn1.tag = 1;
    }
    
    
}

- (void)btn2Click {
    if (self.btn2.tag == 3) {
        [self.btn2 setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
        self.btn2.tag = 4;
    } else if (self.btn2.tag == 4) {
        [self.btn2 setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        self.btn2.tag = 3;
    }
}

- (void)btn3Click {
    if (self.btn3.tag == 5) {
        [self.btn3 setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
        self.btn3.tag = 6;
    } else if (self.btn3.tag == 6) {
        [self.btn3 setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        self.btn3.tag = 5;
    }
}

- (void)btn4Click {
    if (self.btn4.tag == 7) {
        [self.btn4 setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
        self.btn4.tag = 8;
    } else if (self.btn4.tag == 8) {
        [self.btn4 setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        self.btn4.tag = 7;
    }
}

- (void)btn5Click {
    if (self.btn5.tag == 9) {
        [self.btn5 setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
        self.btn5.tag = 10;
    } else if (self.btn5.tag == 10) {
        [self.btn5 setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        self.btn5.tag = 9;
    }
}

- (void)btn6Click {
    if (self.btn6.tag == 11) {
        [self.btn6 setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
        self.btn6.tag = 12;
    } else if (self.btn6.tag == 12) {
        [self.btn6 setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        self.btn6.tag = 11;
    }
}

//开始创建actionSheet
- (void)startChoosePhoto {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    
    [choiceSheet showInView:self.view];
}

// actionSheet的代理方法，用来设置每个按钮点击的触发事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //构建图像选择器
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    [pickerController setDelegate:(id)self];
    
    if (buttonIndex == 0) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [pickerController.view setTag:actionSheet.tag];
        [self presentViewController:pickerController animated:YES completion:nil];
    } else if(buttonIndex == 1){
        pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    else{
        [actionSheet setHidden:YES];
    }
    
}

// 图像选择器选取好后，将图片数据拿过来
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.paiData = [Tools scaleImage:image];
    
    [self.paiBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.paiBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)PUTBtnClick {
    NSLog(@"提交");
    
    self.str1 = [NSString string];
    self.str2 = [NSString string];
    self.str3 = [NSString string];
    self.str4 = [NSString string];
    self.str5 = [NSString string];
    self.str6 = [NSString string];
    
    if (self.btn1.tag == 2) {
       self.str1 = self.btn1.titleLabel.text;
        
    }
    if (self.btn2.tag == 4) {
        self.str2 = self.btn2.titleLabel.text;
        
    }
    if (self.btn3.tag == 6) {
        self.str3 = self.btn3.titleLabel.text;
        
    }
    if (self.btn4.tag == 8) {
        self.str4 = self.btn4.titleLabel.text;
        
    }
    if (self.btn5.tag == 10) {
        self.str5 = self.btn5.titleLabel.text;
        
    }
    if (self.btn6.tag == 12) {
        self.str6 = self.btn6.titleLabel.text;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.str1,self.str2,self.str3,self.str4,self.str5,self.str6];
    
    NSLog(@"%@",str);
    
    if (self.paiData ==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请拍照" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
    } else {
    
        
        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
        
        //URL接口
        NSString * url = [NSString stringWithFormat:Main_URL,Fault_URL];
        
        
        NSString * ID_Str = userModel.user_id;
        
#warning carId死的
        NSString *carID = @"11";
        
        //上传的参数
        NSDictionary * dic = @{@"carId":carID,
                               @"question":self.textView.text,
                               @"faults":str,
                               @"uid":ID_Str};
        NSLog(@"打印出上传的参数--->>>%@",dic);
        NSLog(@"打印出URL--->>>%@",url);
        AFHTTPSessionManager * man = [AFHTTPSessionManager manager];
        man.responseSerializer = [AFHTTPResponseSerializer serializer];
        [man POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             
             
             [formData appendPartWithFileData:self.paiData name:@"imgPath" fileName:[NSString stringWithFormat:@"%@%@imgPath.png",ID_Str,carID] mimeType:@"image/png"];
             
             
         } progress:^(NSProgress * _Nonnull uploadProgress)
         {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"上传头像成功--->>>%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             alert.tag = 400;
             
             [alert show];
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"请求失败---->>>>%@",error);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"提交失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             
             [alert show];
         }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }

    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 400) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
