//
//  FourPictureView.m
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "FourPictureView.h"

@implementation FourPictureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView {
    UIImageView *imagev1    = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH*2/5, SCREEM_WIDTH*3/5)];
    imagev1.backgroundColor = [UIColor whiteColor];
    imagev1.tag             = 1400;
    [self addSubview:imagev1];
    
    UIImageView *imagev2    = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEM_WIDTH*2/5, 0, SCREEM_WIDTH*3/5, SCREEM_WIDTH*1.5/5)];
    imagev2.backgroundColor = [UIColor whiteColor];
    imagev2.tag             = 1401;
    [self addSubview:imagev2];
    
    UIImageView *imagev3    = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEM_WIDTH*2/5, SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5)];
    imagev3.backgroundColor = [UIColor whiteColor];
    imagev3.tag             = 1402;
    [self addSubview:imagev3];
    
    UIImageView *imagev4    = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEM_WIDTH*3.5/5, SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5)];
    imagev4.backgroundColor = [UIColor whiteColor];
    imagev4.tag             = 1403;
    [self addSubview:imagev4];
}

- (void)setPicArray:(NSMutableArray *)picArray {
    _picArray = picArray;
    //设置四个奇怪的按钮
    for (NSInteger i = 0; i < _picArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:1400+i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_picArray[i][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        imageView.userInteractionEnabled = YES;
        [imageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {            
            NSString *pictureID = _picArray[i][@"id"];
            if (self.block) {
                self.block(pictureID);
            }
        }];
    }
}

@end
