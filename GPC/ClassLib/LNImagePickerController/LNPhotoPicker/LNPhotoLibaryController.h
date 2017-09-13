//
//  LNPhotoLibaryController.h
//  LNImagePickerDemo
//
//  Created by 林洁 on 16/1/15.
//  Copyright © 2016年 onlylin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNPhotoLibaryController : UIViewController
/**
 *  获取所有选择的照片
 */
@property (nonatomic, readonly, copy) NSMutableArray *selectedPhotos;

/**
 *  设置最多选择照片数量
 */
@property (nonatomic, assign) NSInteger maxSelectedCount;
 
@end
