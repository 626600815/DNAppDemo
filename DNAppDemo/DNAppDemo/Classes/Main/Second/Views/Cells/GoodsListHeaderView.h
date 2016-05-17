//
//  GoodsListHeaderView.h
//  DNAppDemo
//
//  Created by mainone on 16/5/11.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsListHeaderViewDelegate <NSObject>

@optional
- (void)didButtonWithIndex:(NSInteger)index;

@end

@interface GoodsListHeaderView : UICollectionReusableView

@property (nonatomic, assign) id<GoodsListHeaderViewDelegate>delegate;

@end
