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

- (void)text:(UITextField *)text Title:(NSString *)title Frame:(CGRect)frame Image:(UIImage *)image {
    text.frame = frame;
    text.backgroundColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Arial" size:15.0f];
    text.placeholder = title;
    text.textColor = [UIColor whiteColor];
    text.textAlignment = NSTextAlignmentLeft;
    text.borderStyle = UITextBorderStyleRoundedRect;
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    UIImageView *passView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    [passView setImage:image];
    [View addSubview:passView];
    text.leftView = View;
    [text setLeftViewMode:UITextFieldViewModeAlways];
    text.borderStyle = UITextBorderStyleNone;
    text.layer.cornerRadius = 10;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [[UIColor clearColor] CGColor];
    text.layer.borderWidth = 1.0;

}

- (void)button:(UIButton *)button Title:(NSString *)title Frame:(CGRect)frame TitleColor:(UIColor *)color Selector:(SEL)selector BackgroundColor:(UIColor *)color2 Image:(UIImage *)image {
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.backgroundColor = [color2 colorWithAlphaComponent:0.6];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 1;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [label setText:[NSString stringWithFormat:@"%@",name]];
}


- (void)historyLab:(UILabel *)label andNumber:(NSInteger)number {
    label.font = [UIFont systemFontOfSize:number];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];


}

@end
