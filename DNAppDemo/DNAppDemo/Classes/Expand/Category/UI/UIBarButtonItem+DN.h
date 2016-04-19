//
//  UIBarButtonItem+DN.h
//  iOSAppDemo2
//
//  Created by mainone on 16/3/11.
//  Copyright © 2016年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DNActionBlock)(id weakSender);

@interface UIBarButtonItem (DN)

/**
 *  Item(系统样式)
 *
 *  @param systemItem  系统Item
 *  @param actionBlock 点击回调
 *
 *  @return Item
 */
+ (UIBarButtonItem *)itemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(DNActionBlock)actionBlock;

/**
 *  Item(image+landscapeImagePhone)
 *
 *  @param image               图片
 *  @param landscapeImagePhone 图片（包括竖屏和横屏显示不同的图片）
 *  @param style               类型
 *  @param actionBlock         点击回调
 *
 *  @return Item
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style block:(DNActionBlock)actionBlock;

/**
 *  Item(image)
 *
 *  @param image       图片
 *  @param style       类型
 *  @param actionBlock 点击回调
 *
 *  @return Item
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style block:(DNActionBlock)actionBlock;

/**
 *  Item(title)
 *
 *  @param title       文字
 *  @param style       类型
 *  @param actionBlock 点击回调
 *
 *  @return Item
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style block:(DNActionBlock)actionBlock;

/**
 *  给Item添加回调事件
 *
 *  @param actionBlock 点击回调
 */
- (void)setBlock:(DNActionBlock)actionBlock;

@end
