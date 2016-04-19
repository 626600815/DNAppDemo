//
//  UIImageView+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DN)

/**
 *  多张图片播放
 *
 *  @param imageArray 图片数组
 *  @param duration   持续时间
 *
 *  @return imageView
 */
+ (id) imageViewWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;

/**
 *  为图片绘制圆角
 *
 *  @param radius 圆角大小
 */
- (void)addCornerWithRadius:(CGFloat)radius;

@end
