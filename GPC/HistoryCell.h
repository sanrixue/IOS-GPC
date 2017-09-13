//
//  HistoryCell.h
//  GPC
//
//  Created by 董立峥 on 16/8/22.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryModel;

static NSString *historyIndentifier = @"historyCell";

@interface HistoryCell : UITableViewCell

@property (nonatomic, strong) HistoryModel *historyModel;

@property (nonatomic, strong) UILabel *historyTime;
@property (nonatomic, strong) UILabel *historyThing;
@property (nonatomic, strong) UILabel *historyResult;

@end
