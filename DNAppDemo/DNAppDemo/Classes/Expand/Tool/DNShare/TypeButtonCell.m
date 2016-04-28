//
//  TypeButtonCell.m
//  MobileApp
//
//  Created by mainone on 16/2/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "TypeButtonCell.h"

@interface TypeButtonCell ()


@end

@implementation TypeButtonCell

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = WHITECOLOR;
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.button.frame= rect;
   
    self.button.backgroundColor = [UIColor colorWithWholeRed:245 green:245 blue:245 alpha:1];
    __block typeof(self)bself = self;
    [self.button addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        if (bself.delegete && [bself.delegete respondsToSelector:@selector(clickButtonWithName:)]) {
            [bself.delegete clickButtonWithName:bself.titleName];
        }
        
    }];
    [self addSubview:self.button];
    
    [self.button setTitle:self.titleName forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"DNShare.bundle/%@", self.imageName]] forState:UIControlStateNormal];
    
   
    [self.button setTitleColor:[UIColor colorWithWholeRed:30 green:30 blue:30 alpha:1] forState:UIControlStateNormal];
    [self.button setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    if (iphone4x_3_5 || iphone5x_4_0) {
        self.button.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    [self.button middleAlignButtonWithSpacing:5];
    
}


@end
