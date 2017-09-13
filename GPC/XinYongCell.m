//
//  XinYongCell.m
//  GPC
//
//  Created by 董立峥 on 16/8/22.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "XinYongCell.h"
#import "XinYongModel.h"
//间距
#define  marginW ([UIScreen mainScreen].bounds.size.width/3 - 235/3)

@implementation XinYongCell

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
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"xin"];
    [self.contentView addSubview:icon];
    
    
    //添加label
    self.historyTime = [[UILabel alloc] init];
    [creatControls historyLab:self.historyTime andNumber:12];
    [self.contentView addSubview:self.historyTime];
    self.historyTime.textColor = [UIColor whiteColor];
    self.historyTime.textAlignment = NSTextAlignmentLeft;
    
    self.historyThing = [[UILabel alloc] init];
    [creatControls historyLab:self.historyThing andNumber:13];
    [self.contentView addSubview:self.historyThing];
    self.historyThing.textColor = [UIColor whiteColor];
    self.historyThing.textAlignment = NSTextAlignmentLeft;
    
    self.historyResult = [[UILabel alloc] init];
    [creatControls historyLab:self.historyResult andNumber:14];
    [self.contentView addSubview:self.historyResult];
    self.historyResult.textColor = [UIColor blueColor];
    self.historyResult.textAlignment = NSTextAlignmentRight;
    
    //约束
    __weak __typeof(&*self)weakSelf = self;
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left).offset(marginW);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.historyTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(icon.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self.historyThing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.historyTime.mas_bottom);
        make.left.equalTo(self.historyTime.mas_left);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
        
    }];
    
    [self.historyResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-marginW);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
}

//传递数据模型
- (void)setXinyongModel:(XinYongModel *)xinyongModel {
    _xinyongModel = xinyongModel;
    
  
    NSString *time = [[NSString stringWithFormat:@"%@", _xinyongModel.history_time] substringWithRange:NSMakeRange(0, 16)];
    
    self.historyTime.text = time;
    
    self.historyThing.text = [NSString stringWithFormat:@"%@", _xinyongModel.history_thing];;
    
    self.historyResult.text = [NSString stringWithFormat:@"%@信用积分", _xinyongModel.history_result];
}


@end
