//
//  HomeCell.m
//  DNAppDemo
//
//  Created by mainone on 16/4/21.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel        = homeModel;
    self.titleLabel.text  = _homeModel.title;
    self.detailLabel.text = _homeModel.content;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.imageName]];
}


@end
