//
//  RealNameViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/22.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "RealNameViewController.h"
#import "CreatControls.h"
#import "DBManager.h"


@interface RealNameViewController ()<UIActionSheetDelegate>{
    UITextField *_name;
    UITextField *_number;
    UITextField *_country;
    
    UIImageView *_handImage;
    UIImageView *_image;
    
    NSMutableArray *_iconArray;
    
    UIButton *_button1;
    
    UIButton *_button2;
    
    NSInteger _tag;
}

@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"实名认证";
    
    _iconArray = [[NSMutableArray alloc] init];
    
    [self setUpUI];
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];

    UILabel *lab1 = [[UILabel alloc] init];
    [creatControls label:lab1 Name:@"真实姓名" andFrame:CGRectMake(0.05*KSCREENWIDTH, 70*KSCREENWIDTH/375.0, 100, 40)];
    [self.view addSubview:lab1];
    lab1.textColor = [UIColor blackColor];
    
    UILabel *lab2 = [[UILabel alloc] init];
    [creatControls label:lab2 Name:@"证  件  号" andFrame:CGRectMake(0.05*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+50, 100, 40)];
    [self.view addSubview:lab2];
    lab2.textColor = [UIColor blackColor];
    
    UILabel *lab3 = [[UILabel alloc] init];
    [creatControls label:lab3 Name:@"国      籍" andFrame:CGRectMake(0.05*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+100, 100, 40)];
    [self.view addSubview:lab3];
    lab3.textColor = [UIColor blackColor];
    
    UILabel *lab4 = [[UILabel alloc] init];
    [creatControls label:lab4 Name:@"证件照片" andFrame:CGRectMake(0.05*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+150, 100, 40)];
    [self.view addSubview:lab4];
    lab4.textColor = [UIColor blackColor];
    
    
    UILabel *lineLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120*KSCREENWIDTH/375.0-5, KSCREENWIDTH, 1)];
    lineLab1.backgroundColor = [UIColor grayColor];
    lineLab1.alpha = 0.3;
    [self.view addSubview:lineLab1];
    
    UILabel *lineLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120*KSCREENWIDTH/375.0+46, KSCREENWIDTH, 1)];
    lineLab2.backgroundColor = [UIColor grayColor];
    lineLab2.alpha = 0.3;
    [self.view addSubview:lineLab2];
    
    UILabel *lineLab3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120*KSCREENWIDTH/375.0+97, KSCREENWIDTH, 1)];
    lineLab3.backgroundColor = [UIColor grayColor];
    lineLab3.alpha = 0.3;
    [self.view addSubview:lineLab3];
    
    
    _name = [[UITextField alloc] init];
    [creatControls text:_name Title:nil Frame:CGRectMake(0.05*KSCREENWIDTH+100, 70*KSCREENWIDTH/375.0, 0.9*KSCREENWIDTH-100, 40) Image:nil];
    _name.textAlignment = NSTextAlignmentLeft;
    _name.textColor = [UIColor blackColor];
    [self.view addSubview: _name];
    _name.placeholder = @"请如实填写";
    _name.backgroundColor = [UIColor clearColor];
    
    _number = [[UITextField alloc] init];
    [creatControls text:_number Title:nil Frame:CGRectMake(0.05*KSCREENWIDTH+100, 70*KSCREENWIDTH/375.0+50, 0.9*KSCREENWIDTH-100, 40) Image:nil];
    _number.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview: _number];
    _number.textColor = [UIColor blackColor];
    _number.placeholder = @"请输入证件号";
    _number.backgroundColor = [UIColor clearColor];
    
    _country = [[UITextField alloc] init];
    [creatControls text:_country Title:nil Frame:CGRectMake(0.05*KSCREENWIDTH+100, 70*KSCREENWIDTH/375.0+100, 0.9*KSCREENWIDTH-100, 40) Image:nil];
    _country.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview: _country];
     _country.textColor = [UIColor blackColor];
    _country.placeholder = @"请输入您的国籍";
    _country.backgroundColor = [UIColor clearColor];
    
    
    _handImage = [[UIImageView alloc] init];
    [creatControls image:_handImage Name:@"hand" Frame:CGRectMake(0.3*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+190, 0.4*KSCREENWIDTH, 0.4*KSCREENWIDTH*375/667)];
    [self.view addSubview:_handImage];
    
    //头像添加透明的Btn
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0.3*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+190, 0.4*KSCREENWIDTH, 0.4*KSCREENWIDTH*375/667)];
    [_button1 addTarget:self action:@selector(_button1Click) forControlEvents:UIControlEventTouchUpInside];
    _button1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_button1];
    _button1.tag = 1000;
    
    
    _image = [[UIImageView alloc] init];
    [creatControls image:_image Name:@"zhengmian" Frame:CGRectMake(0.3*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+210+0.2*KSCREENWIDTH, 0.4*KSCREENWIDTH, 0.4*KSCREENWIDTH*375/667)];
    [self.view addSubview:_image];
    
    _button2 = [[UIButton alloc] initWithFrame:CGRectMake(0.3*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+210+0.2*KSCREENWIDTH, 0.4*KSCREENWIDTH, 0.4*KSCREENWIDTH*375/667)];
    [_button2 addTarget:self action:@selector(_button2Click) forControlEvents:UIControlEventTouchUpInside];
    _button2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_button2];
    _button2.tag = 2000;
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 70*KSCREENWIDTH/375.0+220+0.4*KSCREENWIDTH, 0.9*KSCREENWIDTH, 100)];
    message.numberOfLines = 0;//多行显示
    message.text = @"       请提供两张照片，一张为手持身份证正面合影，另一张为身份证原件照，请确保五官，证件内容均清晰可见。（限中华人民共和国身份证，护照，台胞证。）";
    message.textColor = [UIColor lightGrayColor];
    [message setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:message];
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, 70*KSCREENWIDTH/375.0+330+0.4*KSCREENWIDTH, KSCREENWIDTH * 0.7, KSCREENWIDTH * 0.125 -10);
    [PUTBtn setTitle:@"提交" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];
    
}


- (void)_button1Click {
    [self startChoosePhoto];
    
    _tag = _button1.tag;
    
    NSLog(@"tag~~~~~~~~~~~%ld",_tag);
}

- (void)_button2Click {
    [self startChoosePhoto];
    
    _tag = _button2.tag;
    
    NSLog(@"tag~~~~~~~~~~~%ld",_tag);
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
    
    NSData * UP_data = [Tools scaleImage:image];
    
    [_iconArray addObject:UP_data];
    
    if (_tag == 1000) {
        _handImage.image = image;
        _button1.userInteractionEnabled = NO;
    } else if (_tag == 2000) {
        _image.image = image;
        _button2.userInteractionEnabled = NO;
    }
    
    NSLog(@"%ld",_iconArray.count);
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)PUTBtnClick {
    NSLog(@"提交");
    
    if (_iconArray.count==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请上传身份证" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
    else
    {

    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    //URL接口
    NSString * url = [NSString stringWithFormat:Main_URL,Realname_URL];
    
    
    NSString * ID_Str = userModel.user_id;
    //上传的参数
    NSDictionary * dic = @{@"name":_name.text,
                           @"idCard":_number.text,
                           @"nationality":_country.text,
                           @"uid":ID_Str};
    NSLog(@"打印出上传的参数--->>>%@",dic);
    NSLog(@"打印出URL--->>>%@",url);
    AFHTTPSessionManager * man = [AFHTTPSessionManager manager];
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    [man POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         
         NSLog(@"打印出选择图片数量---->>>%lu",(unsigned long)_iconArray.count);
         
         [formData appendPartWithFileData:_iconArray[0] name:@"positive" fileName:[NSString stringWithFormat:@"%@positive.png",ID_Str] mimeType:@"image/png"];
            
        [formData appendPartWithFileData:_iconArray[1] name:@"inverse" fileName:[NSString stringWithFormat:@"%@inverse.png",ID_Str] mimeType:@"image/png"];

     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"上传头像成功--->>>%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
        [[DBManager sharedManager]upadteUserModelModelStatus:@"3" FromModelId:userModel.user_id];
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"认证成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         
         alert.tag = 300;
         
         [alert show];
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败---->>>>%@",error);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"认证失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         
         [alert show];
     }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 300) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
