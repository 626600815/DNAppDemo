//
//  AppDelegate.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "AppDelegate.h"
#import "MainControllerManage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建跟视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainControllerManage sharedManager] mainViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   // 程序暂行
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 程序进入后台
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   // 程序进入前台
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   // 程序重新激活
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // 程序意外暂行
}

@end
