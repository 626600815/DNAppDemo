//
//  DNActionSheetView.m
//  distribution
//
//  Created by mainone on 15/12/14.
//  Copyright © 2015年 mainone. All rights reserved.
//

#import "DNActionSheetView.h"

@implementation DNActionSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        CGFloat allHeight = frame.size.height;
        CGFloat allWidth = frame.size.width;
        NSArray *arr = @[@"返回首页", @"刷新本页", @"取消"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            actionBtn.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
            actionBtn.frame = CGRectMake(0, allHeight/3 * idx , allWidth, allHeight/3);
            actionBtn.tag = 100 + idx;
            [actionBtn setTitle:obj forState:UIControlStateNormal];
            [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [actionBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:actionBtn];
            [actionBtn addEffectWithBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.2] borderWidth:.5];
        }];
    }
    return self;
}

- (void)btnClick:(UIButton *)button {
    NSInteger index = button.tag - 100;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonType:)]) {
        [self.delegate clickButtonType:index];
    }
}

@end
