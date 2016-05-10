//
//  NSObject+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  密码强度级别枚举，从0到6
 */
typedef NS_ENUM(NSInteger, PasswordStrengthLevel)
{
    PasswordStrengthLevelVeryWeak = 0,
    PasswordStrengthLevelWeak,
    PasswordStrengthLevelAverage,
    PasswordStrengthLevelStrong,
    PasswordStrengthLevelVeryStrong,
    PasswordStrengthLevelSecure,
    PasswordStrengthLevelVerySecure
};


@interface NSObject (DN)

#pragma mark - App信息
/**
 *  发布版本号
 */
-(NSString *)ai_version;
/**
 *  内部版本号
 */
-(NSInteger)ai_build;
/**
 *  ID标识符
 */
-(NSString *)ai_identifier;
/**
 *  当前语言
 */
-(NSString *)ai_currentLanguage;
/**
 *  设备型号
 */
-(NSString *)ai_deviceModel;
/**
 *  检查密码强度级别
 */
+ (PasswordStrengthLevel)passwordCheckStrength:(NSString *)password;

/**
 *  浅拷贝目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return YES成功 NO失败
 */
- (BOOL)easyShallowCopy:(NSObject *)instance;

/**
 *   深拷贝目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return YES成功 NO失败
 */
- (BOOL)easyDeepCopy:(NSObject *)instance;

/**
 *  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)performAsynchronous:(void(^)(void))block;

/**
 *  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否异步加载
 */
- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  延迟执行代码块
 *
 *  @param seconds 延迟时间
 *  @param block   代码块
 */
- (void)performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;

@end
