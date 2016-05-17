//
//  GoodsListHeaderView.m
//  DNAppDemo
//
//  Created by mainone on 16/5/11.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "GoodsListHeaderView.h"

@interface GoodsListHeaderView ()

@property (nonatomic, assign) BOOL salesLow;
@property (nonatomic, assign) BOOL priceLow;

@end

@implementation GoodsListHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (IBAction)SalesClick:(UIButton *)sender {
    NSLog(@"销量");
    self.salesLow = sender.selected;
    
    NSInteger index = 0;
    if (self.salesLow) {//销量高为1
        index = 1;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didButtonWithIndex:)]) {
        [self.delegate didButtonWithIndex:index];
    }
    
}
- (IBAction)ProductClick:(UIButton *)sender {
    NSLog(@"新品");
    if (self.delegate && [self.delegate respondsToSelector:@selector(didButtonWithIndex:)]) {
        [self.delegate didButtonWithIndex:3];
    }
}
- (IBAction)PriceClick:(UIButton *)sender {
    NSLog(@"价格");
    
    self.priceLow = sender.selected;
    
    NSInteger index = 3;
    if (self.priceLow) {//价格高为4
        index = 4;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didButtonWithIndex:)]) {
        [self.delegate didButtonWithIndex:index];
    }
}

@end
