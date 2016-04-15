//
//  DNTabBarController.h
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNTabBarButton.h"

@interface DNTabBarController : UITabBarController

//中心按钮
@property(strong, readonly, nonatomic) DNTabBarButton *centerButton;

@end
