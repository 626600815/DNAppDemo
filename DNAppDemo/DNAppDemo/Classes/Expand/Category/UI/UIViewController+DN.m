//
//  UIViewController+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIViewController+DN.h"

@implementation UIViewController (DN)

- (NSString *)toString {
    return NSStringFromClass([self class]);
}

- (void)dismissAllModalController{
    UIViewController *presentViewController = [self presentingViewController];
    UIViewController *lastViewController = self;
    while (presentViewController) {
        id temp = presentViewController;
        presentViewController = [presentViewController presentingViewController];
        lastViewController = temp;
    }
    [lastViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
