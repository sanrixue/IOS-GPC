//
//  PersonalViewController.m
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonInfoViewController.h"
#import "MoneyViewController.h"
#import "TravleViewController.h"
#import "FriendViewController.h"
#import "GuideViewController.h"
#import "SetViewController.h"
#import "MessageViewController.h"
#import "AddYajinViewController.h"
#import "XingyongViewController.h"
#import "RealNameViewController.h"
#import "TravleNoneController.h"
#import "UserModel.h"

@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *_titles;
    
    NSArray *_images;
    
    NSArray *_detitles;
    
    NSMutableArray *_array;
    
    //头试图
    UIView *_headerView;
    
    //头像
    UIImageView *_imageview;
    
    //名字和信用积分
    UILabel *_label1;
    UILabel *_label2;
    
    //线
    UILabel *_lineLab;
    
    //手机绑定，押金充值，实名认证，开始用车
    UIButton *_btn;
    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
    
    //背景底图片
    UIImageView *_headimageView;
    
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    
    
    self.view.backgroundColor = [UIColor colorWithRed:231.0 / 255.0 green:232.0 / 255.0 blue:233.0 / 255.0 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    _titles = @[@[@"我的钱包"], @[ @"我的行程"], @[@"邀请好友"], @[@"用户指南"], @[@"设置中心"], @[@"我的消息"]];
    
    
    _images = @[@[@"1"], @[ @"2"], @[@"3"], @[@"4"], @[ @"5"], @[@"6"]];
    
    
    _detitles = @[@[@"剩余100元"], @[ @"已骑行26分钟"], @[@"好友10人"], @[@"便捷用车"], @[@"便捷用车"], @[@"有2条未读消息"]];
    
   

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self createTableView];
    
    [self.tableView reloadData];

}


//创建表示图
-(void)createTableView{
    
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT) style:UITableViewStyleGrouped];
    }
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //    _tableView.scrollEnabled = NO;
    
    
    [self.view addSubview:_tableView];
    
}

//显示多少数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_titles[section] count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 * KSCREENWIDTH / 375.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = _titles[indexPath.section][indexPath.row];
    
    cell.textLabel.textColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
    
  
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.section][indexPath.row]];
    
    return cell;
}

//点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;
    if ([title isEqualToString:@"我的钱包"]) {
        MoneyViewController *moneyVC = [[MoneyViewController alloc] init];
        
        [self.navigationController pushViewController:moneyVC animated:YES];
        
    }else if ([title isEqualToString:@"我的行程"]){
        
        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
        
        _array = [[NSMutableArray alloc] init];
        
        //如果是下拉刷新，将原有的所有元素全部移除
        NSString * url = [NSString stringWithFormat:Main_URL,Record_URL];
        
        NSDictionary *dic = @{@"uid":userModel.user_id,
                              @"currentPage":@"1"};
        
        [Tools POST:url params:dic superviewOfMBHUD:nil  success:^(id responseObj)
         {
             
             
             _array = [responseObj[@"data"][@"result"] mutableCopy];
             
             NSLog(@"~~~~~~~~~~~~~~~~~~~~~~%@",_array);
             if (_array.count > 0) {
                 TravleViewController *travleVC = [[TravleViewController alloc] init];
                 
                 [self.navigationController pushViewController:travleVC animated:YES];
             } else {
                 
                 TravleNoneController *travleVC = [[TravleNoneController alloc] init];
                 
                 [self.navigationController pushViewController:travleVC animated:YES];
             }

   
         } failure:^(NSError *error)
         {
             NSLog(@"请求失败: %@",error);
 
         }];

  
        
    }else if ([title isEqualToString:@"邀请好友"]){
        
        FriendViewController *friendVC = [[FriendViewController alloc] init];
        
        [self.navigationController pushViewController:friendVC animated:YES];
        
        
    }else if ([title isEqualToString:@"用户指南"]){
        
       GuideViewController  *guideVC = [[GuideViewController alloc] init];
        
        [self.navigationController pushViewController:guideVC animated:YES];
        
    }else if ([title isEqualToString:@"设置中心"]){
        
        SetViewController *setVC = [[SetViewController alloc] init];
        
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else if ([title isEqualToString:@"我的消息"]){
        
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        
        [self.navigationController pushViewController:messageVC animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return (182+64) * KSCREENWIDTH/375.0;
    } else{
        
        return 1 * KSCREENWIDTH/375.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        //头像视图
        if (_headerView == nil) {
            
            _headerView  = [[UIView alloc] init];
            
            
            _headimageView = [[UIImageView alloc]init];
            
            [_headerView addSubview:_headimageView];
            [_headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.equalTo(_headerView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                
            }];
            
            
            
            _imageview = [[UIImageView alloc]init];
            
            [_headerView addSubview:_imageview];
            
            
            _imageview.layer.cornerRadius = 100*0.5*KSCREENWIDTH/375.0;
            _imageview.layer.masksToBounds = YES;
            _imageview.layer.borderWidth = 4*KSCREENWIDTH/375.0;
            _imageview.layer.borderColor = [UIColor whiteColor].CGColor;
            
            
            
            [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.mas_equalTo(_headerView.mas_centerX).offset(-80*KSCREENWIDTH/375.0);
                make.centerY.mas_equalTo(_headerView.mas_centerY).offset(10*KSCREENWIDTH/375.0);
                make.size.mas_equalTo(CGSizeMake(100*KSCREENWIDTH/375.0, 100*KSCREENWIDTH/375.0));
            }];
            
            _imageview.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
    
            //添加给label
            [_imageview addGestureRecognizer:tgr];
            
            
            
            
            _label1 = [[UILabel alloc]init];
            [_headerView addSubview:_label1];
            
            
            _label1.numberOfLines = 0;
            _label1.textColor = [UIColor blackColor];
            _label1.textAlignment = NSTextAlignmentCenter;
            [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(_imageview.mas_centerY);
                make.left.mas_equalTo(_imageview.mas_right).offset(20);
                make.size.mas_equalTo(CGSizeMake(120, 25));
            }];
            
            
            _label2 = [[UILabel alloc]init];
            [_headerView addSubview:_label2];
            
            
            _label2.numberOfLines = 0;
            _label2.textColor = [UIColor colorWithRed:13.0/255 green:50.0/255 blue:38.0/255 alpha:1.0];
            _label2.layer.cornerRadius = 10;
            _label2.layer.borderColor = [UIColor colorWithRed:13.0/255 green:50.0/255 blue:38.0/255 alpha:1.0].CGColor;
            _label2.layer.borderWidth = 1;
            _label2.textAlignment = NSTextAlignmentCenter;
            [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(_imageview.mas_right).offset(20);
                make.top.mas_equalTo(_label1.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(120, 25));
            }];
            
            UIButton *xinyongBtn = [[UIButton alloc] init];
            [xinyongBtn addTarget:self action:@selector(xinyongBtnClick) forControlEvents:UIControlEventTouchUpInside];
            xinyongBtn.backgroundColor = [UIColor clearColor];
            [_headerView addSubview:xinyongBtn];
            [xinyongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(_label2.mas_centerX);
                make.centerY.mas_equalTo(_label2.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(120, 25));
            }];
        
        //底背景图片
        _headimageView.image = [UIImage imageNamed:@"back"];
        
        
        //添加线
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
        [_headerView addSubview:_lineLab];
        [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_headerView.mas_centerX);
            make.top.mas_equalTo(_label2.mas_bottom).offset(30);
            make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH * 0.8, 1));
        }];
        
        //添加button
        _btn = [[UIButton alloc] init];
        _btn.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
        [_btn setTitle:@"手机绑定" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn.layer.cornerRadius = 10;
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_lineLab.mas_centerY);
            make.left.mas_equalTo(_headerView.mas_left).offset(20);
            make.size.mas_equalTo(CGSizeMake(70, 20));
        }];
        
        _btn1 = [[UIButton alloc] init];
        _btn1.backgroundColor = [UIColor whiteColor];
        [_btn1 setTitle:@"押金充值" forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0]forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn1.layer.cornerRadius = 10;
        _btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn1 setBackgroundImage:[UIImage imageNamed:@"personshi"] forState:UIControlStateNormal];
        [_headerView addSubview:_btn1];
        [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_lineLab.mas_centerY);
            make.left.mas_equalTo(_btn.mas_right).offset((KSCREENWIDTH - 320)/3);
            make.size.mas_equalTo(CGSizeMake(70, 20));
        }];
        [_btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];

        _btn2 = [[UIButton alloc] init];
        _btn2.backgroundColor = [UIColor whiteColor];
        [_btn2 setTitle:@"实名认证" forState:UIControlStateNormal];
        [_btn2 setBackgroundImage:[UIImage imageNamed:@"personxu"] forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0]forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn2.layer.cornerRadius = 10;
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:_btn2];
        [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_lineLab.mas_centerY);
            make.left.mas_equalTo(_btn1.mas_right).offset((KSCREENWIDTH - 320)/3);
            make.size.mas_equalTo(CGSizeMake(70, 20));
        }];
        [_btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
        
        _btn3 = [[UIButton alloc] init];
        _btn3.backgroundColor = [UIColor whiteColor];
        [_btn3 setTitle:@"开始用车" forState:UIControlStateNormal];
        [_btn3 setBackgroundImage:[UIImage imageNamed:@"personxu"] forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0]forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn3.layer.cornerRadius = 10;
        _btn3.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:_btn3];
        [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_lineLab.mas_centerY);
            make.left.mas_equalTo(_btn2.mas_right).offset((KSCREENWIDTH - 320)/3);
            make.size.mas_equalTo(CGSizeMake(70, 20));
        }];
        [_btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
        
    }
        

        DBManager *model = [[DBManager sharedManager] selectOneModel];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray addObject:model];
        UserModel *userModel = mutArray[0];
        
        //读取图片
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_user",userModel.user_id]];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
        if (image) {
            _imageview.image = image;
            
        } else if ([[NSString stringWithFormat:@"%@",userModel.user_logo] isEqualToString:@"(null)"]) {
            _imageview.image = [UIImage imageNamed:@"default.jpg"];
            
        } else {
            [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,userModel.user_logo]]];
        }
        
        
        
        _label1.text = userModel.user_name;
       
        NSString * url3 = [NSString stringWithFormat:Main_URL,[NSString stringWithFormat:ScoreSum_URL,userModel.user_id]];
        NSLog(@"地址------>>>>%@",url3);
        
        [Tools POST:url3 params:nil superviewOfMBHUD:nil success:^(id responseObj)
         {
             NSLog(@"登录成功---->>>>%@",responseObj);
            
                 
            _label2.text = [NSString stringWithFormat:@"信用积分%@", responseObj[@"sum"] ];

          
             
         } failure:^(NSError *error) {
             
             NSLog(@"请求出错--->>>%@",error);
         }];
    
        
        if ([userModel.user_status isEqualToString:@"1"]) {
            _btn2.userInteractionEnabled = NO;
            _btn3.userInteractionEnabled = NO;
            
        } else if ([userModel.user_status isEqualToString:@"2"]) {
            _btn1.userInteractionEnabled = NO;
            _btn3.userInteractionEnabled = NO;
            _btn1.backgroundColor = [UIColor colorWithRed:46.0/255 green:189.0/255 blue:154.0/255 alpha:1.0];
            [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_btn1 setBackgroundImage:nil forState:UIControlStateNormal];
            [_btn2 setBackgroundImage:[UIImage imageNamed:@"personshi"] forState:UIControlStateNormal];
            
        } else if ([userModel.user_status isEqualToString:@"3"]) {
            [_lineLab removeFromSuperview];
            [_btn removeFromSuperview];
            [_btn1 removeFromSuperview];
            [_btn2 removeFromSuperview];
            [_btn3 removeFromSuperview];
        }
        
 
        return _headerView;
        
    }else{
        
        return nil;
    }
 
}

//押金充值
- (void)btn1Click {
    AddYajinViewController *yajinVC = [[AddYajinViewController alloc] init];
    [self.navigationController pushViewController:yajinVC animated:YES];
    
  
}

- (void)xinyongBtnClick {
    XingyongViewController *xingyongVC = [[XingyongViewController alloc] init];
    [self.navigationController pushViewController:xingyongVC animated:YES];
}

- (void)btn2Click {
    NSLog(@"实名认证");
    
    RealNameViewController *realVC = [[RealNameViewController alloc] init];
    
    [self.navigationController pushViewController:realVC animated:YES];
}

- (void)btn3Click {
    NSLog(@"开始用车");
}

- (void)tapGestureHandle:(UITapGestureRecognizer *)tgr{
    NSLog(@"点击头像");
    
    PersonInfoViewController *personInfoController = [[PersonInfoViewController alloc] init];
    
    CATransition *trasition = [CATransition animation];
    trasition.duration = 1;
    [trasition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    trasition.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:trasition forKey:@"animation"];
    
    [self.navigationController pushViewController:personInfoController animated:YES];
    
    [personInfoController returnBlock:^(NSString *nameText, UIImage *iconImage) {
        _imageview.image = iconImage;
        _label1.text = nameText;
    }];
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.view.frame.size.width; // 图片宽度
    
    CGFloat yOffset = scrollView.contentOffset.y; // 偏移的y值
    
    if (yOffset < 0) {
        
        CGFloat totalOffset = ((180*(KSCREENWIDTH/375.0)+64*(KSCREENWIDTH/375.0)) + ABS(yOffset));
        
        CGFloat f = (totalOffset / (180*(KSCREENWIDTH/375.0)+64*(KSCREENWIDTH/375.0)));
        
        _headimageView.frame =CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
