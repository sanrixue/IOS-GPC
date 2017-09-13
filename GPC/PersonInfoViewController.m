//
//  PersonInfoViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "Masonry.h"
#import "CreatControls.h"
#import "RealNameViewController.h"
#import "RSKImageCropper.h"
#import "UIImageView+WebCache.h"
#import "DBManager.h"
#import "AddYajinViewController.h"

@interface PersonInfoViewController ()<UIActionSheetDelegate,RSKImageCropViewControllerDelegate,UIAlertViewDelegate>{
    UIImageView *_headImage;
    //头像
    UIImageView *_iconImage;
    
    UITextField *_nameText;
    UITextField *_phoneText;
    
    //认证btn
    UIButton *_renBtn;
}

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人信息";
    
    
 
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self setUpUI];
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    NSLog(@"%@",userModel.user_status);
    
    if ([userModel.user_status isEqualToString:@"3"]) {
        [_renBtn setTitle:@"已认证" forState:UIControlStateNormal];
        _renBtn.userInteractionEnabled = NO;
    }
    
    
}


- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 259 * KSCREENWIDTH / 375)];
    _headImage.image = [UIImage imageNamed:@"back"];
    [self.view addSubview:_headImage];
    
    _iconImage = [[UIImageView alloc] init];
    [_headImage addSubview:_iconImage];
    
    _iconImage.layer.cornerRadius = 120*0.5*KSCREENWIDTH/375.0;
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.borderWidth = 4*KSCREENWIDTH/375.0;
    _iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(_headImage.mas_centerX);
        make.centerY.mas_equalTo(_headImage.mas_centerY).offset(30*KSCREENWIDTH/375.0);
        make.size.mas_equalTo(CGSizeMake(120*KSCREENWIDTH/375.0, 120*KSCREENWIDTH/375.0));
    }];
    
    //头像添加透明的Btn
    UIButton *iconBtn = [[UIButton alloc] init];
    [iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
    iconBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:iconBtn];
    
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_iconImage.mas_centerX);
        make.centerY.mas_equalTo(_iconImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120*KSCREENWIDTH/375.0, 120*KSCREENWIDTH/375.0));
    }];
    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    NSLog(@"%@",userModel.user_logo);
    
    //读取图片
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",userModel.user_id]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    if (image) {
        _iconImage.image = image;
        
    } else if ([[NSString stringWithFormat:@"%@",userModel.user_logo] isEqualToString:@"(null)"]) {
        _iconImage.image = [UIImage imageNamed:@"default.jpg"];
        
    } else {
        [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,userModel.user_logo]]];
    }
    
    
    
    
    UILabel *lineLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0, 0.9*KSCREENWIDTH, 1)];
    lineLab1.backgroundColor = [UIColor lightGrayColor];
    lineLab1.alpha = 0.3;
    [self.view addSubview:lineLab1];
    
    UILabel *lineLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+41, 0.9*KSCREENWIDTH, 1)];
    lineLab2.backgroundColor = [UIColor lightGrayColor];
    lineLab2.alpha = 0.3;
    [self.view addSubview:lineLab2];
    
    UILabel *lineLab3 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+82, 0.9*KSCREENWIDTH, 1)];
    lineLab3.backgroundColor = [UIColor lightGrayColor];
    lineLab3.alpha = 0.3;
    [self.view addSubview:lineLab3];
    
    UILabel *lineLab4 = [[UILabel alloc] initWithFrame:CGRectMake(0.05*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+123, 0.9*KSCREENWIDTH, 1)];
    lineLab4.backgroundColor = [UIColor lightGrayColor];
    lineLab4.alpha = 0.3;
    [self.view addSubview:lineLab4];
    
    
    _nameText = [[UITextField alloc] init];
    [creatControls text:_nameText Title:nil Frame:CGRectMake(0.15*KSCREENWIDTH,260*KSCREENWIDTH/375.0+1, 0.7*KSCREENWIDTH, 40) Image:nil];
    _nameText.textAlignment = NSTextAlignmentRight;
    [self.view addSubview: _nameText];
    _nameText.textColor = [UIColor grayColor];
    _nameText.text = userModel.user_name;
    
    _phoneText = [[UITextField alloc] init];
    [creatControls text:_phoneText Title:nil Frame:CGRectMake(0.15*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+42, 0.7*KSCREENWIDTH, 40) Image:nil];
    _phoneText.textAlignment = NSTextAlignmentRight;
    [self.view addSubview: _phoneText];
    _phoneText.userInteractionEnabled = NO;
    _phoneText.textColor = [UIColor grayColor];
    _phoneText.text = userModel.user_phone;
    
    
    
    
    _renBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.85*KSCREENWIDTH-60, 260*KSCREENWIDTH/375.0+83, 60, 40)];
    [_renBtn setTitle:@"未认证" forState:UIControlStateNormal];
    _renBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    _renBtn.backgroundColor = [UIColor  whiteColor];
    [_renBtn setTitleColor:[UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0] forState:UIControlStateNormal];
    [_renBtn addTarget:self action:@selector(renBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_renBtn];
    
    UILabel *lab1 = [[UILabel alloc] init];
    [creatControls label:lab1 Name:@"昵      称:" andFrame:CGRectMake(0.15*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+1, 80, 40)];
    [self.view addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] init];
    [creatControls label:lab2 Name:@"手 机 号:" andFrame:CGRectMake(0.15*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+42, 80, 40)];
    [self.view addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc] init];
    [creatControls label:lab3 Name:@"实名认证" andFrame:CGRectMake(0.15*KSCREENWIDTH, 260*KSCREENWIDTH/375.0+83, 80, 40)];
    [self.view addSubview:lab3];
    
    
    
    UIButton *PUTBtn = [[UIButton alloc] init];
    PUTBtn.frame = CGRectMake(KSCREENWIDTH *0.15, 260*KSCREENWIDTH/375.0+140, KSCREENWIDTH * 0.7, KSCREENWIDTH * 0.125 -10);
    [PUTBtn setTitle:@"保存" forState:UIControlStateNormal];
    PUTBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [PUTBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [PUTBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [PUTBtn addTarget:self action:@selector(PUTBtnClick) forControlEvents:UIControlEventTouchUpInside];
    PUTBtn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    PUTBtn.layer.cornerRadius = 5;
    [self.view addSubview:PUTBtn];

}


- (void)returnBlock:(MyBlock)block {
    self.myBlock = block;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    if (self.myBlock != nil) {
        self.myBlock(_nameText.text,_iconImage.image);
    }
}



- (void)PUTBtnClick {
    NSLog(@"保存");
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];

    //URL接口
    NSString * url = [NSString stringWithFormat:Main_URL,Upadta_URL];
    
    NSData * UP_data = [Tools scaleImage:_iconImage.image];
    
    UIImage *image = [UIImage imageWithData:UP_data];
    
    NSLog(@"%@",_iconImage.image);
    
    NSString * ID_Str = userModel.user_id;
    //上传的参数
    NSDictionary * dic = @{@"name":_nameText.text,
                           @"id":ID_Str};
    NSLog(@"打印出上传的参数--->>>%@",dic);
    NSLog(@"打印出URL--->>>%@",url);
    AFHTTPSessionManager * man = [AFHTTPSessionManager manager];
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    [man POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         [formData appendPartWithFileData:UP_data name:@"imgPath" fileName:[NSString stringWithFormat:@"titleimage%@.png",ID_Str] mimeType:@"image/png"];
         
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        NSLog(@"上传头像成功--->>>%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
         
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
         
        NSString *uniquePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",ID_Str]];
         
        BOOL result = [UIImagePNGRepresentation(image)writeToFile: uniquePath atomically:YES];
        if (result) {
            NSLog(@"success");
         
        }
         
         [[DBManager sharedManager]upadteUserModelModelName:_nameText.text FromModelId:ID_Str];
         
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         
         alert.tag = 200;
         
         [alert show];
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败---->>>>%@",error);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         
         [alert show];
     }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 200) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (void)iconBtnClick {
    
    [self startChoosePhoto];
}

- (void)renBtnClick {
    NSLog(@"认证");
    
    
    DBManager *model = [[DBManager sharedManager] selectOneModel];
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObject:model];
    UserModel *userModel = mutArray[0];
    
    NSLog(@"%@",userModel.user_status);
    
    if ([userModel.user_status isEqualToString:@"2"]) {
        RealNameViewController *realVC = [[RealNameViewController alloc] init];
        
        [self.navigationController pushViewController:realVC animated:YES];
    } else if ([userModel.user_status isEqualToString:@"1"]) {
    
        AddYajinViewController *addYajin = [[AddYajinViewController alloc] init];
        
        [self.navigationController pushViewController:addYajin animated:YES];
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

    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCircle];

    imageCropVC.delegate = self;

    [self.navigationController pushViewController:imageCropVC animated:YES];

    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RSKImageCropViewControllerDelegate
//取消
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

//确认
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{

    [self.navigationController popViewControllerAnimated:YES];
    
    _iconImage.image = croppedImage;



    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_nameText resignFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
