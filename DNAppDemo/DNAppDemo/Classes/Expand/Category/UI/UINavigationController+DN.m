//
//  UINavigationController+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UINavigationController+DN.h"

@implementation UINavigationController (DN)

- (id)findViewController:(NSString*)className {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    
    return nil;
}

- (BOOL)isOnlyContainRootViewController {
    if (self.viewControllers &&
        self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

- (UIViewController *)rootViewController {
    if (self.viewControllers && [self.viewControllers count] >0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}

- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated; {
    return [self popToViewController:[self findViewController:className] animated:YES];
}

- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated {
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated orientation:(UINavigationControllerPushOrientation)orientation{
    if (animated) {
        CATransition *transition = [CATransition animation];
        transition.duration = .5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        NSString *sub = kCATransitionFromLeft;
        switch (orientation) {
            case 0:sub = kCATransitionFromLeft;break;
            case 1:sub = kCATransitionFromRight;break;
            case 2:sub = kCATransitionFromTop;break;
            case 3:sub = kCATransitionFromBottom;break;
        }
        transition.subtype = sub;
        [self.view.layer addAnimation:transition forKey:nil];
    }
    [self pushViewController:viewController animated:NO];
}




@end

