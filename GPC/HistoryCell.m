//
//  HistoryCell.m
//  GPC
//
//  Created by 董立峥 on 16/8/22.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "HistoryCell.h"
#import "HistoryModel.h"

//间距
#define  marginW ([UIScreen mainScreen].bounds.size.width/3 - 90)

@implementation HistoryCell

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
    self.historyTime = [[UILabel alloc] init];
    [creatControls historyLab:self.historyTime andNumber:14];
    [self.contentView addSubview:self.historyTime];
    self.historyTime.textColor = [UIColor grayColor];
    self.historyTime.textAlignment = NSTextAlignmentLeft;
    
    self.historyThing = [[UILabel alloc] init];
    [creatControls historyLab:self.historyThing andNumber:16];
    [self.contentView addSubview:self.historyThing];
    self.historyThing.textColor = [UIColor darkGrayColor];
    self.historyThing.textAlignment = NSTextAlignmentLeft;
    
    self.historyResult = [[UILabel alloc] init];
    [creatControls historyLab:self.historyResult andNumber:16];
    [self.contentView addSubview:self.historyResult];
    self.historyResult.textColor = [UIColor blueColor];
    self.historyResult.textAlignment = NSTextAlignmentRight;
    
    //约束
    __weak __typeof(&*self)weakSelf = self;
    
    [self.historyTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(marginW);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [self.historyThing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.historyTime.mas_bottom).offset(5);
        make.left.equalTo(self.historyTime.mas_left);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        
        
    }];
    
    [self.historyResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-marginW);
        make.size.mas_equalTo(CGSizeMake(120, 25));
    }];
    
}

//传递数据模型
- (void)setHistoryModel:(HistoryModel *)historyModel {
    _historyModel = historyModel;
    
    NSString *time = [[NSString stringWithFormat:@"%@", _historyModel.history_time] substringWithRange:NSMakeRange(0, 16)];
    
    self.historyTime.text = time;
    
    self.historyThing.text = [NSString stringWithFormat:@"%@", _historyModel.history_thing];;
    
    self.historyResult.text = [NSString stringWithFormat:@"%@信用积分", _historyModel.history_result];
}


@end
