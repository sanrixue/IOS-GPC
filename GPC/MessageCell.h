//
//  MessageCell.h
//  GPC
//
//  Created by 尤超 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

@interface MessageCell : UITableViewCell

@property (nonatomic, strong) MessageModel *messageModel;

@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *text;
@property (nonatomic, strong) UIImageView *image;

+ (instancetype)messageCellWith:(UITableView *)tableView;

@end
