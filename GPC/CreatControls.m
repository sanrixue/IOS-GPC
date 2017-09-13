//
//  CreatControls.m
//  BaMaiYL
//
//  Created by Super on 16/5/3.
//  Copyright © 2016年 季晓侠. All rights reserved.
//

#import "CreatControls.h"

@implementation CreatControls

- (void)image:(UIImageView *)imageView Name:(NSString *)name Frame:(CGRect)frame {
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:name];
}

- (void)faimlyText:(UITextField *)text {
    text.font = [UIFont systemFontOfSize:16];
    text.textColor = [UIColor blackColor];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.textAlignment = NSTextAlignmentRight;
    text.keyboardType = UIKeyboardTypePhonePad;
    text.backgroundColor = [UIColor clearColor];
    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    text.layer.borderWidth = 0.5;
}

- (void)faimlyLab:(UILabel *)label Number:(NSInteger)number {
    label.font = [UIFont systemFontOfSize:number];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
}

- (void)faimlyLab:(UILabel *)label Text:(NSString *)text {
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    [label setTextColor:[UIColor blackColor]];
    label.backgroundColor = [UIColor clearColor];
}

- (void)text:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame Image:(UIImage *)image {
    text.frame = frame;
    text.backgroundColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.placeholder = title;
    text.textColor = [UIColor blackColor];
    text.borderStyle = UITextBorderStyleRoundedRect;
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    UIImageView *passView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 20)];
    [passView setImage:image];
    [View addSubview:passView];
    text.leftView = View;
    [text setLeftViewMode:UITextFieldViewModeAlways];
    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [[UIColor colorWithRed:31.0/255.0 green:74/255.0 blue:109/255.0 alpha:0.7] CGColor];
    text.layer.borderWidth = 1.0;
    

}

- (void)bindingText:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame Image:(UIImage *)image {
    text.frame = frame;
    text.backgroundColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.placeholder = title;
    text.textColor = [UIColor blackColor];
    text.borderStyle = UITextBorderStyleRoundedRect;
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    UIImageView *passView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    [passView setImage:image];
    [View addSubview:passView];
    text.leftView = View;
    [text setLeftViewMode:UITextFieldViewModeAlways];
    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [[UIColor colorWithRed:31.0/255.0 green:74/255.0 blue:109/255.0 alpha:0.7] CGColor];
    text.layer.borderWidth = 1.0;
}

- (void)bindingText:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame {
    text.frame = frame;
    text.backgroundColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.placeholder = title;
    [text setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    text.textAlignment = NSTextAlignmentRight;
    text.borderStyle = UITextBorderStyleRoundedRect;

    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [[UIColor colorWithRed:31.0/255.0 green:74/255.0 blue:109/255.0 alpha:0.7] CGColor];
    text.layer.borderWidth = 1.0;
}

- (void)button:(UIButton *)button Title:(NSString *)title Frame:(CGRect)frame TitleColor:(UIColor *)color Selector:(SEL)selector BackgroundColor:(UIColor *)color2 Image:(UIImage *)image {
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.backgroundColor = [color2 colorWithAlphaComponent:0.6];
    button.layer.cornerRadius = 15;
}

- (void)button:(UIButton *)button Frame:(CGRect)frame Selector:(SEL)selector {
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)label:(UILabel *)label Name:(NSString *)name andFrame:(CGRect)frame {
    label.frame = frame;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAutocorrectionTypeDefault;
    label.font = [UIFont systemFontOfSize:15];
    [label setText:[NSString stringWithFormat:@"%@",name]];
 }

@end
