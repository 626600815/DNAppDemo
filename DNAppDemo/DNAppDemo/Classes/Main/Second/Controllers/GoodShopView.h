//
//  GoodShopView.h
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScrollBlock)(NSString *ScrollID);

@interface GoodShopView : UIView

@property (nonatomic, copy) ScrollBlock block;

@property (nonatomic, strong) NSMutableArray *shopArray;

@end
