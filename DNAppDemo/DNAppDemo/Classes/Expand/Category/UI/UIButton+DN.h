//
//  UIButton+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchedBlock)(NSInteger tag);
@interface UIButton (DN)

/**
 *  设置按钮的背景颜色
 *
 *  @param backgroundColor 背景色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  button添加点击事件
 *
 *  @param touchHandler tag是button的tag值
 */
-(void)addActionHandler:(TouchedBlock)touchHandler;

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title 如获取验证码
 *  @param subTitle 倒计时中的子名字，如时、分、秒
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/**
 *  显示指示器
 */
- (void) showIndicator;

/**
 *  掩藏指示器
 */
- (void) hideIndicator;

/**
 *  图片文字上下排列居中对齐
 *
 *  @param spacing 上下间距
 */
- (void)middleAlignButtonWithSpacing:(CGFloat)spacing;

/**
 *  按钮点击后禁用按钮并在按钮上显示 指示器和文字
 *
 *  @param title 显示的文字
 */
- (void)beginSubmitting:(NSString *)title;

/**
 *  恢复点击前的状态
 */
- (void)endSubmitting;

/**
 *  按钮是否在提交中
 */
@property(nonatomic, readonly, getter=isSubmitting) NSNumber *submitting;

/**
 *  设置button额外点击有效区域
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

@end
