//
//  DetailCell.h
//  GPC
//
//  Created by 尤超 on 16/9/9.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailModel;

static NSString *detailIndentifier = @"detailCell";

@interface DetailCell : UITableViewCell

@property (nonatomic, strong) DetailModel *detailModel;

@property (nonatomic, strong) UILabel *detailTime;
@property (nonatomic, strong) UILabel *detailThing;
@property (nonatomic, strong) UILabel *detailResult;

@end
