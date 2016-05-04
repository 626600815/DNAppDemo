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
#import "OpenShareHeader.h"
#import "DrawViewController.h"
#import "CenterViewController.h"
#import "DNNavigationController.h"

@interface AppDelegate ()

@property (nonatomic, assign) CFAbsoluteTime resignTime;  //记录进入后台的时间
@property (nonatomic, assign) CFAbsoluteTime currentTime; //记录进入前台的时间

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置全局接口请求的主机域名
    [DNNetworking updateBaseUrl:DNHostURLStr];
    [self setThirdKeys];
    
    //创建跟视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainControllerManage sharedManager] mainViewController];
    [self.window makeKeyAndVisible];
    
    
    [self PageLoadingGuide];//设置引导图
//    [self TouchSetting];//设置3D touch
    
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
        DNLog(@"我是不是沉睡了好长时间");
    }
}

// 程序重新激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

// 程序意外暂行
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

//客户端回调
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //第二步：添加回调
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    //这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
    return YES;
}

//3D touch回调
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type isEqualToString:@"one"]) {
        
        UITabBarController *mytab = (UITabBarController*)self.window.rootViewController;
        mytab.selectedIndex = 0;
    }else if ([shortcutItem.type isEqualToString:@"two"]){
        DrawViewController *DrawVC = [[DrawViewController alloc]initWithNibName:@"DrawViewController" bundle:nil];
        UITabBarController *mytab = (UITabBarController*)self.window.rootViewController;
        mytab.selectedIndex = 0;
        UINavigationController *myNAV = [mytab.viewControllers firstObject];
        [myNAV pushViewController:DrawVC animated:YES];
        
    } else if ([shortcutItem.type isEqualToString:@"third"]) {
        UITabBarController *mytab = (UITabBarController*)self.window.rootViewController;
        CenterViewController *centerVC = [[CenterViewController alloc] initWithNibName:NSStringFromClass([CenterViewController class]) bundle:nil];
        DNNavigationController *nav = [[DNNavigationController alloc] initWithRootViewController:centerVC];
        [mytab presentViewController:nav animated:NO completion:nil];
    }
}

#pragma mark - method
//加载引导页
- (void)PageLoadingGuide {
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *historyVersion =[NSFileManager getAppSettingsForObjectWithKey:@"VersionStr"];
    if (historyVersion == nil || [historyVersion compare:currentVersion options:NSNumericSearch] == NSOrderedAscending) {
        [DNPageView sharePageView].isPageControl = NO;
        [[DNPageView sharePageView] initPageViewToView:self.window dismiss:^{
            DNLog(@"记住了 我已经看过你了");
            [NSFileManager setAppSettingsForObject:currentVersion forKey:@"VersionStr"];
        }];
    }
}

//设置3D touch
- (void)TouchSetting {
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"扫码" localizedTitle:@"扫码"];
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"打开应用" localizedTitle:@"打开应用"];
    NSArray *shortItems = [[NSArray alloc] initWithObjects:shortItem1, shortItem2, nil];
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
}


//设置三方登录分享的key
- (void)setThirdKeys {
    [OpenShare connectQQWithAppId:QQAppID];
    [OpenShare connectWeiboWithAppKey:WeiBoAppId];
    [OpenShare connectWeixinWithAppId:weixinAppID];
    [OpenShare connectAlipay];//支付宝参数都是服务器端生成的，这里不需要key.
}

@end
