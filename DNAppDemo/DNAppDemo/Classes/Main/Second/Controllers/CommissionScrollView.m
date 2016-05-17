//
//  CommissionScrollView.m
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "CommissionScrollView.h"

@implementation CommissionScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView {
    UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 30)];
    backView.backgroundColor = [UIColor redColor];
    backView.tag             = 12222;
    backView.hidden          = YES;
    [self addSubview:backView];
    
    UILabel *label           = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEM_WIDTH, 30)];
    label.text               = @"最高返佣";
    label.textColor          = [UIColor whiteColor];
    label.font               = [UIFont systemFontOfSize:14];
    [backView addSubview:label];
    
    UIButton * button        = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"查看更多" forState:UIControlStateNormal];
    button.titleLabel.font   = [UIFont systemFontOfSize:14];
    button.frame             = CGRectMake(SCREEM_WIDTH- 90, 0, 90, 30);
    [backView addSubview:button];
    [button addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DNLog(@"查看更多");
    }];
    
    UIScrollView *scrollV    = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, SCREEM_WIDTH, 150)];
    scrollV.tag              = 12000;
    [self addSubview:scrollV];

}

- (void)setScrollArray:(NSMutableArray *)scrollArray {
    _scrollArray = scrollArray;
    //能滚动的
    UIScrollView *scrollV = (UIScrollView *)[self viewWithTag:12000];
    scrollV.backgroundColor = [UIColor redColor];
    
    UIView *FYView = (UIView *)[self viewWithTag:12222];
    FYView.hidden = NO;
    
    scrollV.contentSize = CGSizeMake((scrollV.height - 50 + 10)*_scrollArray.count-10, scrollV.height);
    //处理一下重复创建而导致的内存上升
    for(int i = 0;i<[scrollV.subviews count];i++){
        [scrollV.subviews[i] removeFromSuperview];
    }
    for (NSInteger i = 0; i < _scrollArray.count; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*(scrollV.height-50 +10), 0, scrollV.height- 50, scrollV.height-50)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:_scrollArray[i][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [scrollV addSubview:imageV];
        
        imageV.userInteractionEnabled = YES;
        [imageV addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            NSString *scrollID = _scrollArray[i][@"id"];
            if (self.block) {
                self.block(scrollID);
            }
        }];
        
        UILabel *commissionLabel      = [[UILabel alloc] initWithFrame:CGRectMake(imageV.x, imageV.height+5, imageV.width, 20)];
        commissionLabel.text          = [NSString stringWithFormat:@"佣金：¥%@",_scrollArray[i][@"commission"]];
        commissionLabel.font          = [UIFont systemFontOfSize:14];
        commissionLabel.textColor     = [UIColor whiteColor];
        commissionLabel.textAlignment = NSTextAlignmentCenter;
        [scrollV addSubview:commissionLabel];
        
        UILabel *priceLabel           = [[UILabel alloc] initWithFrame:CGRectMake(imageV.x, imageV.height+25, imageV.width, 20)];
        priceLabel.text               = [NSString stringWithFormat:@"¥%@",_scrollArray[i][@"price"]];
        priceLabel.font               = [UIFont systemFontOfSize:14];
        priceLabel.textColor          = [UIColor whiteColor];
        priceLabel.textAlignment      = NSTextAlignmentCenter;
        [scrollV addSubview:priceLabel];
    }
    
}

@end
