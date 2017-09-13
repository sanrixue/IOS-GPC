//
//  DashesLineView.m
//  GPC
//
//  Created by 董立峥 on 16/8/31.
//  Copyright © 2016年 董立峥. All rights reserved.
//

#import "DashesLineView.h"

#define kInterval 10                                // 全局间距

@implementation DashesLineView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self) {
        _lineColor = [UIColor whiteColor];
        _startPoint = CGPointMake(0, 1);
        _endPoint = CGPointMake(KSCREENWIDTH , 1);
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context,0.5);//线宽度
    
    CGContextSetStrokeColorWithColor(context,self.lineColor.CGColor);
    
    CGFloat lengths[] = {4,2};//先画4个点再画2个点
    
    CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(context,self.startPoint.x,self.startPoint.y);
    
    CGContextAddLineToPoint(context,self.endPoint.x,self.endPoint.y);
    
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
    
}

@end
