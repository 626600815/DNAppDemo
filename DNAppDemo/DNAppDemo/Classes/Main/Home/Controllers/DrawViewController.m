//
//  DrawViewController.m
//  DN3DTouchDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DrawViewController.h"
#import "CircleView.h"

@interface DrawViewController () {
    CGPoint touchPoint;
    UIImageView *canDraw;
}
@property (weak, nonatomic) IBOutlet CircleView *circle;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用手指画画看";
    
    canDraw = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.circle.height+64, SCREEM_WIDTH, SCREEM_HEIGHT)];
    canDraw.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:canDraw];
    
    
    //下载进度
    [DNNetworking downloadFileWithURLString:@"https://s3.amazonaws.com/elasticbeanstalk-us-east-1-725151976758/audio/mclean_kjv/2/1.mp3" progress:^(NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.circle.progress = progress.fractionCompleted;
        });
        
    } result:^(NSURL *filePath, NSError *error) {
        NSLog(@"error------>%@",error);
    }];

    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 70, 100, 100)];
    backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:backView];
    __weak typeof(UIView *)weakView = backView;
    [backView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakView addMotionEffectWithMinRelative:2 maxRelative:3 EffectType:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis keyPath:@"transform"];
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:canDraw];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch       = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:canDraw];
    UIGraphicsBeginImageContext(canDraw.frame.size);
    [canDraw.image drawInRect:CGRectMake(0.0, 0.0, canDraw.frame.size.width, canDraw.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    float lineWidthc     = 10.0;
    if ([touch respondsToSelector:@selector(force)]) {
        DNLog(@"压力指数:%f", touch.force);
        lineWidthc       = lineWidthc * touch.force;
    }
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidthc);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    canDraw.image        = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    touchPoint           = currentPoint;
}

@end
