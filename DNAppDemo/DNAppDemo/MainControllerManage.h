//
//  MainControllerManage.h
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainControllerManage : NSObject

//获取单利
+ (MainControllerManage *)sharedManager;

/**
 *  主视图控制器
 */
@property(strong, readonly, nonatomic) UIViewController *mainViewController;

/**
 *  跳转到首页
 *
 *  @param VC 当前视图控制器
 */
- (void)jumpToHomeFromVC:(UIViewController *)VC;

- (void)setBadgeValue:(NSString *)value atIndex:(NSInteger)index;

@end
