//
//  TravleCell.h
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TravleModel;

static NSString *travleIndentifier = @"travleCell";

@interface TravleCell : UITableViewCell

@property (nonatomic, strong) TravleModel *travleModel;

@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *begin;
@property (nonatomic, strong) UILabel *end;
@property (nonatomic, strong) UILabel *pay;

@end
