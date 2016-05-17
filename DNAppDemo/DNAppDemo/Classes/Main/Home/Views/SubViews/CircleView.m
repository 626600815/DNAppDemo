//
//  CircleView.m
//  xiaoyushier
//
//  Created by mainone on 16/5/16.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    CGFloat viewW        = rect.size.width;
    CGFloat viewH        = rect.size.height;
    CGFloat radius       = viewW * 0.2;
    CGFloat offsetNum = 1.0;//初始进度偏移
    CGFloat endAngle     = self.progress * 2 * M_PI - M_PI_2 * offsetNum;
    
    CGContextRef context_back = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context_back,3.0);
    CGContextSetRGBStrokeColor(context_back, 0.6, 0.6, 0.6, 1.0);
    CGContextAddArc(context_back, viewW * 0.5, viewH * 0.5, radius, 0, 2*M_PI, 0);
    CGContextStrokePath(context_back);
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,3.0);
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1.0);
    CGContextAddArc(context, viewW * 0.5, viewH * 0.5, radius, - M_PI_2 * offsetNum, endAngle, 0);
    CGContextStrokePath(context);
    
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}


@end
