//
//  DrawViewController.m
//  DN3DTouchDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController () {
    CGPoint touchPoint;
    UIImageView *canDraw;
}
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用手指画画看";
    
    canDraw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    canDraw.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:canDraw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:canDraw];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:canDraw];
    UIGraphicsBeginImageContext(canDraw.frame.size);
    [canDraw.image drawInRect:CGRectMake(0.0, 0.0, canDraw.frame.size.width, canDraw.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    float lineWidthc = 10.0;
    if ([touch respondsToSelector:@selector(force)]) {
        DNLog(@"压力指数:%f", touch.force);
        lineWidthc = lineWidthc * touch.force;
    }
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidthc);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    canDraw.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    touchPoint = currentPoint;
}

@end
