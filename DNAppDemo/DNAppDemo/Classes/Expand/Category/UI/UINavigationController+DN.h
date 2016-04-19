//
//  UINavigationController+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UINavigationControllerPushOrientation) {
    UINavigationControllerPushOrientationLeft = 0,
    UINavigationControllerPushOrientationRight,
    UINavigationControllerPushOrientationTop,
    UINavigationControllerPushOrientationBottom
};


@interface UINavigationController (DN)
/**
 *  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)findViewController:(NSString*)className;
/**
 *  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)isOnlyContainRootViewController;
/**
 *  RootViewController
 *
 *  @return RootViewController
 */
- (UIViewController *)rootViewController;
/**
 *  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
/**
 *  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;

/**
 *  带有方向的push
 *
 *  @param viewController VC
 *  @param animated       动画
 *  @param orientation    方向
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated orientation:(UINavigationControllerPushOrientation)orientation;


@end