//
//  GoodsListCell.m
//  DNAppDemo
//
//  Created by mainone on 16/5/11.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "GoodsListCell.h"

@implementation GoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setListModel:(GoodsListModel *)listModel {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.3lian.com/2015/w7/90/d/1.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.descriptionLabel.text = @"2015夏季新款时尚女连衣裙";
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",@"188"];
    self.commissionLabel.text = [NSString stringWithFormat:@"佣金¥%@",@"2"];
    
}

@end
