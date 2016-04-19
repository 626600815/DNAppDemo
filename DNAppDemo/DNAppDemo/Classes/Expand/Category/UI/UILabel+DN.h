//
//  UILabel+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double UILabelAutomaticWritingVersionNumber;
FOUNDATION_EXPORT const unsigned char UILabelAutomaticWritingVersionString[];
extern NSTimeInterval const UILabelAWDefaultDuration;
extern unichar const UILabelAWDefaultCharacter;

FOUNDATION_EXPORT double UINavigationItem_MarginVersionNumber;
FOUNDATION_EXPORT const unsigned char UINavigationItem_MarginVersionString[];

typedef NS_ENUM(NSInteger, UILabelAWBlinkingMode) {//光标显示类型
    UILabelAWBlinkingModeNone,
    UILabelAWBlinkingModeUntilFinish,
    UILabelAWBlinkingModeUntilFinishKeeping,
    UILabelAWBlinkingModeWhenFinish,
    UILabelAWBlinkingModeWhenFinishShowing,
    UILabelAWBlinkingModeAlways
};

@interface UILabel (DN)

@property (strong, nonatomic) NSOperationQueue *automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/**
 *  设置文字,逐字显示动画
 *
 *  @param text label文字
 */
- (void)setTextWithAutomaticWritingAnimation:(NSString *)text;

/**
 *  设置文字,逐字显示动画(光标显示类型)
 *
 *  @param text         文字
 *  @param blinkingMode 光标显示类型
 */
- (void)setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelAWBlinkingMode)blinkingMode;

/**
 *  设置文字,逐字显示动画(文字出现间隔时间)
 *
 *  @param text     文字
 *  @param duration 间隔时间
 */
- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

/**
 *  设置文字,逐字显示动画(文字出现间隔时间+光标类型)
 *
 *  @param text         文字
 *  @param duration     间隔时间
 *  @param blinkingMode 光标类型
 */
- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelAWBlinkingMode)blinkingMode;

/**
 *  设置文字,逐字显示动画(文字出现时间间隔+光标类型+自定义光标符号)
 *
 *  @param text              文字
 *  @param duration          间隔时间
 *  @param blinkingMode      光标类型
 *  @param blinkingCharacter 自定义光标符号
 */
- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelAWBlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

/**
 *  设置文字,逐字显示动画(文字出现时间间隔+光标类型+自定义光标)
 *
 *  @param text              文字
 *  @param duration          时间间隔
 *  @param blinkingMode      光标类型
 *  @param blinkingCharacter 自定义光标符号
 *  @param completion        完成回调
 */
- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelAWBlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;

@end
