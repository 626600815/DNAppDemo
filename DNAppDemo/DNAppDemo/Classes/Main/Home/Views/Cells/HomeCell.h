//
//  HomeCell.h
//  DNAppDemo
//
//  Created by mainone on 16/4/21.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (nonatomic, strong) HomeModel *homeModel;


@end
