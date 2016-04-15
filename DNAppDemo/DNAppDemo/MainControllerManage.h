//
//  MainControllerManage.h
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainControllerManage : NSObject

//主视图控制器
@property(strong, readonly, nonatomic) UIViewController *mainViewController;

//获取单利
+ (MainControllerManage *)sharedManager;

@end
