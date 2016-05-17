//
//  FourPictureViewTwo.m
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "FourPictureViewTwo.h"

@implementation FourPictureViewTwo

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView {
    float widthAndHeight    = SCREEM_WIDTH*1/3;
    UIImageView *imagev1    = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, widthAndHeight)];
    imagev1.backgroundColor = [UIColor whiteColor];
    imagev1.tag             = 1800;
    [self addSubview:imagev1];
    
    UIImageView *imagev2    = [[UIImageView alloc] initWithFrame:CGRectMake(0, widthAndHeight, widthAndHeight, widthAndHeight)];
    imagev2.backgroundColor = [UIColor whiteColor];
    imagev2.tag             = 1801;
    [self addSubview:imagev2];
    
    UIImageView *imagev3    = [[UIImageView alloc] initWithFrame:CGRectMake(widthAndHeight, widthAndHeight, widthAndHeight, widthAndHeight)];
    imagev3.backgroundColor = [UIColor whiteColor];
    imagev3.tag             = 1802;
    [self addSubview:imagev3];
    
    UIImageView *imagev4    = [[UIImageView alloc] initWithFrame:CGRectMake(widthAndHeight*2, widthAndHeight, widthAndHeight, widthAndHeight)];
    imagev4.backgroundColor = [UIColor whiteColor];
    imagev4.tag             = 1803;
    [self addSubview:imagev4];
}

- (void)setPicArray:(NSMutableArray *)picArray {
    _picArray = picArray;
    for (NSInteger i = 0; i < _picArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:1800+i];
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
