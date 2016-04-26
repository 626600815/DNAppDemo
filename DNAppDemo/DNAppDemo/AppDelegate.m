//
//  AppDelegate.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "AppDelegate.h"
#import "MainControllerManage.h"
#import "DNPageView.h"

@interface AppDelegate ()

@property (nonatomic, assign) CFAbsoluteTime resignTime;  //记录进入后台的时间
@property (nonatomic, assign) CFAbsoluteTime currentTime; //记录进入前台的时间

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置全局接口请求的主机域名
    [DNNetworking updateBaseUrl:DNHostURLStr];
    
    //创建跟视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainControllerManage sharedManager] mainViewController];
    [self.window makeKeyAndVisible];
    
    //设置引导图
    [self PageLoadingGuide];
    
    return YES;
}

// 程序暂行
- (void)applicationWillResignActive:(UIApplication *)application {
    //记录进入后台的时间
    self.resignTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
}

// 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

// 程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    //当应用进入后台时间超过10分钟(处理一些有时效性的界面或者账号)
    self.currentTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    if (self.resignTime != 0 && self.currentTime - self.resignTime > 600) {
        NSLog(@"我是不是沉睡了好长时间");
    }
}

// 程序重新激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

// 程序意外暂行
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - method
//加载引导页
- (void)PageLoadingGuide {
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *historyVersion =[NSFileManager getAppSettingsForObjectWithKey:@"VersionStr"];
    if (historyVersion == nil || [historyVersion compare:currentVersion options:NSNumericSearch] == NSOrderedAscending) {
        [DNPageView sharePageView].isPageControl = NO;
        [[DNPageView sharePageView] initPageViewToView:self.window dismiss:^{
            NSLog(@"记住了 我已经看过你了");
            [NSFileManager setAppSettingsForObject:currentVersion forKey:@"VersionStr"];
        }];
    }
}

@end
