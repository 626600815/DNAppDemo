//
//  MBProgressHUD+DN.h
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>



@interface MBProgressHUD (DN)

/**
 *  提示消息
 *
 *  @param message 消息内容
 *  @param view    显示位置
 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view;

/**
 *  提示成功
 *
 *  @param success 成功提示语
 *  @param view    显示位置
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;

/**
 *  提示失败
 *
 *  @param error 失败原因
 *  @param view  显示位置
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showError:(NSString *)error;

/**
 *  显示正在加载菊花（可操作页面）
 *
 *  @param view 显示位置
 */
+ (void)showIndicatorViewToView:(UIView *)view;

/**
 *  隐藏正在显示的菊花
 *
 *  @param view 菊花所在位置
 */
+ (void)hideIndicatorViewInView:(UIView *)view;

@end
