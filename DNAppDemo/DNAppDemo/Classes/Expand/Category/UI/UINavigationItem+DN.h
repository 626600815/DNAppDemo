//
//  UINavigationItem+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ANNavBarLoaderPosition){
    ANNavBarLoaderPositionCenter = 0,
    ANNavBarLoaderPositionLeft,
    ANNavBarLoaderPositionRight
};
@interface UINavigationItem (DN)

/**
 *  导航栏不同位置显示菊花
 *
 *  @param position 位置
 */
- (void)startAnimatingAt:(ANNavBarLoaderPosition)position;

/**
 *  停止转动菊花
 */
- (void)stopAnimating;

/**
 *  锁定右侧Item
 *
 *  @param lock 是否锁定
 */
- (void)lockRightItem:(BOOL)lock;

/**
 *  锁定左侧Item
 *
 *  @param lock 是否锁定
 */
- (void)lockLeftItem:(BOOL)lock;

@property (nonatomic, assign) CGFloat leftMargin;/**<左侧Item边距*/
@property (nonatomic, assign) CGFloat rightMargin;/**<右侧Item边距*/

+ (CGFloat)systemMargin;/**<系统默认边距*/

@end