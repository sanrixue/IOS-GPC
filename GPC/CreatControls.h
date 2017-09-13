//
//  CreatControls.h
//  BaMaiYL
//
//  Created by Super on 16/5/3.
//  Copyright © 2016年 季晓侠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatControls : NSObject

//添加imageView
- (void)image:(UIImageView *)imageView Name:(NSString *)name Frame:(CGRect)frame;

//添加textField
- (void)text:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame Image:(UIImage *)image;

//添加button
- (void)button:(UIButton *)button Title:(NSString *)title Frame:(CGRect)frame TitleColor:(UIColor *)color Selector:(SEL)selector BackgroundColor:(UIColor *)color2 Image:(UIImage *)image;

//添加透明Button
- (void)button:(UIButton *)button Frame:(CGRect)frame Selector:(SEL)selector;

//绑定页面textField
- (void)bindingText:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame Image:(UIImage *)image;

- (void)bindingText:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame;

//添加Label
- (void)label:(UILabel *)label Name:(NSString *)name andFrame:(CGRect)frame;

//家人页面TextFiled
- (void)faimlyText:(UITextField *)text;

//家人页面Label
- (void)faimlyLab:(UILabel *)label Text:(NSString *)text;

//家人列表Label
- (void)faimlyLab:(UILabel *)label Number:(NSInteger)number;

@end
