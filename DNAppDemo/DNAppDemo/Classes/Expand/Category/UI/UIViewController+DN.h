//
//  UIViewController+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewControllerPresentOrientation) {
    UIViewControllerPresentOrientationLeft = 0,
    UIViewControllerPresentOrientationRight,
    UIViewControllerPresentOrientationTop,
    UIViewControllerPresentOrientationBottom
};

@interface UIViewController (DN)

/**
 *  类的字符串名字
 *
 *  @return 字符串
 */
- (NSString *)toString;

/**
 *  关闭所有modal
 */
- (void)dismissAllModalController;

@end
