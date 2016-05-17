//
//  GoodsListCell.h
//  DNAppDemo
//
//  Created by mainone on 16/5/11.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface GoodsListCell : UICollectionViewCell

@property (nonatomic, strong) GoodsListModel *listModel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commissionLabel;


@end
