//
//  UIColor+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DN)



/**
 *  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变的垂直高度
 *
 *  @return 渐变的颜色
 */
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

/**
 *  颜色
 *
 *  @param hexString 16进制色值
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  颜色
 *
 *  @param red   红
 *  @param green 绿
 *  @param blue  蓝
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;

/**
 *  随机颜色
 *
 *  @return 颜色
 */
+ (UIColor *)RandomColor;

@end

