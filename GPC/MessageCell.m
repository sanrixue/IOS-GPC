
//
//  MessageCell.m
//  GPC
//
//  Created by 尤超 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
#import "SDWebImageManager.h"

@implementation MessageCell

+ (instancetype)messageCellWith:(UITableView *)tableView {
    static NSString *ID = @"cell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    CreatControls *creatControls = [[CreatControls alloc] init];
    
    //添加label
    self.time = [[UILabel alloc] init];
    [creatControls historyLab:self.time andNumber:16];
    [self.contentView addSubview:self.time];
    self.time.textColor = [UIColor darkGrayColor];
    
    self.title = [[UILabel alloc] init];
    [creatControls historyLab:self.title andNumber:16];
    [self.contentView addSubview:self.title];
    self.title.textColor = [UIColor grayColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    
    self.text = [[UILabel alloc] init];
    [creatControls historyLab:self.text andNumber:14];
    [self.contentView addSubview:self.text];
    self.text.textColor = [UIColor grayColor];
    self.text.textAlignment = NSTextAlignmentLeft;
    self.text.numberOfLines = 0;
 
    
    //添加图片
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:self.image];
    
    //添加线
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.3;
    [self.contentView addSubview:line];

    __weak __typeof(&*self)weakSelf = self;
    
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 20));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, 1));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.mas_left);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH * 0.5, 20));
    }];
    
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH * 0.5 - 20, 100));
    }];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH * 0.5 - 20, 120));
    }];
}

- (void)setMessageModel:(MessageModel *)messageModel {
    _messageModel = messageModel;
    
    
    NSString *time = [[NSString stringWithFormat:@"%@",_messageModel.time] substringWithRange:NSMakeRange(0, 16)];
    
    self.time.text = time;
    self.title.text = _messageModel.title;
    self.text.text = _messageModel.text;
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Main_URL,_messageModel.image]]];
    
}

@end
