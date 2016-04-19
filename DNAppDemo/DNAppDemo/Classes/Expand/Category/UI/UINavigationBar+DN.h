//
//  UINavigationBar+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (DN)

/**
 *  设置背景颜色
 *
 *  @param backgroundColor 背景颜色
 */
- (void)RsetBackgroundColor:(UIColor *)backgroundColor;

/**
 *  设置透明度
 *
 *  @param alpha 透明度
 */
- (void)RsetElementsAlpha:(CGFloat)alpha;

/**
 *  设置导航栏Y值
 *
 *  @param translationY Y坐标
 */
- (void)RsetTranslationY:(CGFloat)translationY;

/**
 *  导航栏样式重置
 */
- (void)Rreset;

@end
