//
//  GoodShopView.m
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "GoodShopView.h"

@implementation GoodShopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView {
    
    UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 30)];
    backView.tag             = 15222;
    backView.hidden          = YES;
    [self addSubview:backView];

    UILabel *label           = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEM_WIDTH, 30)];
    label.text               = @"发现好店";
    label.textColor          = [UIColor grayColor];
    label.font               = [UIFont systemFontOfSize:14];
    [backView addSubview:label];
    
    UIScrollView *scrollV    = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, SCREEM_WIDTH, SCREEM_WIDTH*2/7+40)];
    scrollV.tag              = 15000;
    [self addSubview:scrollV];

}


- (void)setShopArray:(NSMutableArray *)shopArray {
    
    _shopArray = shopArray;
    //能滚动的
    UIScrollView *scrollV = (UIScrollView *)[self viewWithTag:15000];
    scrollV.backgroundColor = [UIColor grayColor];
    
    UIView *FYView = (UIView *)[self viewWithTag:15222];
    FYView.hidden = NO;
    
    scrollV.contentSize = CGSizeMake((SCREEM_WIDTH*3/7+10)*_shopArray.count+10, scrollV.height);
    //处理一下重复创建而导致的内存上升
    for(int i = 0;i<[scrollV.subviews count];i++){
        [scrollV.subviews[i] removeFromSuperview];
    }
    
    //这里除以三
    for (NSInteger i = 0; i < _shopArray.count; i++) {
        CGFloat imageHeight = SCREEM_WIDTH/7;
        UIView *threeBackView = [[UIView alloc] initWithFrame:CGRectMake(i*(imageHeight+5)*3, 10, imageHeight*3, imageHeight*2)];
        [scrollV addSubview:threeBackView];
        
        for (NSInteger i = 0; i <_shopArray.count; i++) {
            if (i%3 == 0) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageHeight*2, imageHeight*2)];
                imageView.backgroundColor = [UIColor redColor];
                [threeBackView addSubview:imageView];
            }else if (i%3 == 1) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageHeight*2, 0, imageHeight, imageHeight)];
                imageView.backgroundColor = [UIColor greenColor];
                [threeBackView addSubview:imageView];
            }else {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageHeight*2, imageHeight, imageHeight, imageHeight)];
                imageView.backgroundColor = [UIColor yellowColor];
                [threeBackView addSubview:imageView];
            }
            
        }
      
    }
    
}




@end
