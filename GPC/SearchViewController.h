//
//  SearchViewController.h
//  GPC
//
//  Created by 董立峥 on 16/8/23.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnTextBlock)(NSString *searchText);

@interface SearchViewController : UIViewController

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;

@end
