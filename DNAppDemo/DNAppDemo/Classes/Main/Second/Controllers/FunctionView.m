//
//  FunctionView.m
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "FunctionView.h"

@interface FunctionView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation FunctionView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createFunctionView];
    }
    return self;
}

- (void)createFunctionView {
    for (NSInteger i = 0; i < 10; i++) {
        
        UIImageView *imageView           = [[UIImageView alloc] initWithFrame:CGRectMake(i%5*(SCREEM_WIDTH/5)+13, 0+i/5*(SCREEM_WIDTH/5 + 13), SCREEM_WIDTH/5-26, SCREEM_WIDTH/5-26)];
        imageView.tag                    = 100+i;
        imageView.userInteractionEnabled = YES;
        imageView.image = [[UIImage imageNamed:@"placeholder"] getCircleImage];
        [self addSubview:imageView];
        
        UILabel *functionLabel           = [[UILabel alloc] initWithFrame:CGRectMake(imageView.x, imageView.y + imageView.height, imageView.width, 20)];
        functionLabel.tag                = 1000+i;
        functionLabel.font               = [UIFont systemFontOfSize:12];
        functionLabel.textColor          = [UIColor grayColor];
        functionLabel.textAlignment      = NSTextAlignmentCenter;
        functionLabel.text = @"女装";
        [self addSubview:functionLabel];
    }
}

- (void)setFunctionArray:(NSMutableArray *)functionArray {
    _functionArray = functionArray;
    //设置功能区
    for (NSInteger i = 0; i < 10; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:100+i];
        UILabel *label = (UILabel *)[self viewWithTag:1000+i];
        label.text = _functionArray[i][@"name"];
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_functionArray[i][@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
             [imageView addCornerWithRadius:imageView.width/2];
        }];
        [imageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            DNLog(@"功能区点击的按钮是:%@",_functionArray[i][@"id"]);
            NSString *functionID = _functionArray[i][@"id"];
            if (self.block) {
                self.block(functionID);
            }
        }];
    }
}

@end
