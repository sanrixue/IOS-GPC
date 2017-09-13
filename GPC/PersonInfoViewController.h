//
//  PersonInfoViewController.h
//  GPC
//
//  Created by 董立峥 on 16/8/18.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *nameText,UIImage *iconImage);

@interface PersonInfoViewController : UIViewController

@property (nonatomic, copy) MyBlock myBlock;

- (void)returnBlock:(MyBlock)block;


@end
