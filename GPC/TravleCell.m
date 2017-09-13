
//
//  TravleCell.m
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "TravleCell.h"
#import "TravleModel.h"

@implementation TravleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    //添加label
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:14];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor whiteColor];
    
    self.begin = [[UILabel alloc] init];
    [creatControls historyLab:self.begin andNumber:12];
    [self.contentView addSubview:self.begin];
    self.begin.textColor = [UIColor whiteColor];
    self.begin.textAlignment = NSTextAlignmentLeft;
    
    self.end = [[UILabel alloc] init];
    [creatControls historyLab:self.end andNumber:12];
    [self.contentView addSubview:self.end];
    self.end.textColor = [UIColor whiteColor];
    self.end.textAlignment = NSTextAlignmentLeft;
    
    self.pay = [[UILabel alloc] init];
    [creatControls historyLab:self.pay andNumber:12];
    [self.contentView addSubview:self.pay];
    self.pay.textColor = [UIColor blueColor];
    self.pay.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *line1 = [[UIImageView alloc] init];
    line1.image = [UIImage imageNamed:@"travle1"];
    [self.contentView addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc] init];
    line2.image = [UIImage imageNamed:@"travle2"];
    [self.contentView addSubview:line2];
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(8);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 20));
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(-1);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(10, 121));
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.mas_top).offset(35);
        make.centerX.equalTo(weakSelf.mas_centerX).offset(30);
        make.size.mas_equalTo(CGSizeMake(6, 30));
    }];

    [self.end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.mas_top).offset(28);
        make.left.equalTo(weakSelf.mas_centerX).offset(38);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.begin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.end.mas_top).offset(25);
        make.left.equalTo(weakSelf.mas_centerX).offset(38);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.begin.mas_top).offset(25);
        make.left.equalTo(weakSelf.mas_centerX).offset(38);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
}

- (void)setTravleModel:(TravleModel *)travleModel {
    _travleModel = travleModel;
    
    NSString *time = [[NSString stringWithFormat:@"%@",_travleModel.time] substringWithRange:NSMakeRange(0, 10)];
  
    NSString *starttime = [[NSString stringWithFormat:@"%@",_travleModel.time] substringWithRange:NSMakeRange(10, 6)];
   
    NSString *endtime = [[NSString stringWithFormat:@"%@",_travleModel.endtime] substringWithRange:NSMakeRange(10, 6)];
   
    
  
    self.time.text = [NSString stringWithFormat:@"%@         %@-%@",time,starttime,endtime];
    self.begin.text = [NSString stringWithFormat:@"%@",_travleModel.begin];
    self.end.text = [NSString stringWithFormat:@"%@",_travleModel.end];
    self.pay.text = [NSString stringWithFormat:@"花费%@元",_travleModel.pay];


}

@end
