//
//  DetailCell.m
//  GPC
//
//  Created by 尤超 on 16/9/9.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "DetailCell.h"
#import "DetailModel.h"

//间距
#define  marginW ([UIScreen mainScreen].bounds.size.width/3 - 90)

@implementation DetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //添加子控件
        [self setupUI];
        
    }
    return self;
}

#pragma mark 添加子控件
-(void)setupUI
{
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    
    //添加label
    self.detailTime = [[UILabel alloc] init];
    [creatControls historyLab:self.detailTime andNumber:14];
    [self.contentView addSubview:self.detailTime];
    self.detailTime.textColor = [UIColor grayColor];
    
    self.detailThing = [[UILabel alloc] init];
    [creatControls historyLab:self.detailThing andNumber:16];
    [self.contentView addSubview:self.detailThing];
    self.detailThing.textColor = [UIColor darkGrayColor];
    
    self.detailResult = [[UILabel alloc] init];
    [creatControls historyLab:self.detailResult andNumber:16];
    [self.contentView addSubview:self.detailResult];
    self.detailResult.textColor = [UIColor blueColor];
    self.detailResult.textAlignment = NSTextAlignmentRight;
    
    //约束
    __weak __typeof(&*self)weakSelf = self;
    
    [self.detailTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(marginW);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [self.detailThing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailTime.mas_bottom).offset(5);
        make.left.equalTo(self.detailTime.mas_left);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
        
    }];
    
    [self.detailResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-marginW);
        make.size.mas_equalTo(CGSizeMake(120, 25));
    }];
    
}

//传递数据模型
- (void)setDetailModel:(DetailModel *)detailModel {
    _detailModel = detailModel;
    

    
    NSString *time = [[NSString stringWithFormat:@"%@",_detailModel.creattime] substringWithRange:NSMakeRange(0, 16)];
    
    self.detailTime.text = time;
 
    self.detailResult.text = [NSString stringWithFormat:@"%@元",_detailModel.pay];
    
    if ([_detailModel.type intValue] == 1) {
           self.detailThing.text = @"支付成功";
    
    } else if ([_detailModel.type intValue] == 2) {
           self.detailThing.text = @"充值成功";
    
    }
    
}


@end
