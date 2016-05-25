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
#import "DNTabBarController.h"
#import "DetailViewController.h"

#import "UMessage.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface AppDelegate ()

@property (nonatomic, assign) CFAbsoluteTime resignTime;  //记录进入后台的时间
@property (nonatomic, assign) CFAbsoluteTime currentTime; //记录进入前台的时间

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    DNDocumentUrl;
    /*-----------------与界面无关的设置-----------------*/
    //设置全局接口请求的主机域名
    [DNNetworking updateBaseUrl:DNHostURLStr];
    //设置三方登录分享的key
    [self setThirdKeys];
    //检测app版本是否需要升级
//    [self upgradeAppVersion];
    //设置友盟推送
    [self setUMPushWithOptions:launchOptions];
    
    //创建跟视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MainControllerManage sharedManager] mainViewController];
    [self.window makeKeyAndVisible];
    
    /*-----------------与界面相关的设置需要在创建跟视图之后设置-----------------*/
    [self PageLoadingGuide];//设置引导图
//    [self TouchSetting];//设置3D touch
    
    
   //处理应用退出后的推送
    NSDictionary *userInfo = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (userInfo) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self pushToDetailVCWithNotification:userInfo];
            }
        } title:@"新消息" message:@"有一条新消息" cancelButtonName:@"忽略" otherButtonTitles:@"查看", nil];

    }
    
    [[MainControllerManage sharedManager] setBadgeValue:@"4" atIndex:3];
    
    return YES;
}

// 程序暂行
- (void)applicationWillResignActive:(UIApplication *)application {
    DNLog(@"程序暂行");
    //记录进入后台的时间
    self.resignTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
}

// 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    DNLog(@"程序进入后台");
}

// 程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    DNLog(@"程序进入前台");
    //当应用进入后台时间超过10分钟(处理一些有时效性的界面或者账号)
    self.currentTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    if (self.resignTime != 0 && self.currentTime - self.resignTime > 600) {
        DNLog(@"我是不是沉睡了好长时间");
    }
}

// 程序重新激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
    DNLog(@"程序重新激活");
}

// 程序意外退出
- (void)applicationWillTerminate:(UIApplication *)application {
    DNLog(@"程序意外退出");
}

//远程推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [UMessage registerDeviceToken:deviceToken];
    DNLog(@"deviceToken :%@",[deviceToken APNSToken]);
}

//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    //如果注册成功，可以删掉这个方法
//    NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //消息接收后处理
    [UMessage sendClickReportForRemoteNotification:userInfo];
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive || [UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self pushToDetailVCWithNotification:userInfo];
            }
        } title:@"新消息" message:@"有一条新消息" cancelButtonName:@"忽略" otherButtonTitles:@"查看", nil];
    }else {
        [self pushToDetailVCWithNotification:userInfo];
    }
}


//本地推送接收消息
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive || [UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self pushToDetailVCWithNotification:notification.userInfo];
            }
        } title:@"新消息" message:notification.alertBody cancelButtonName:@"忽略" otherButtonTitles:@"查看", nil];
    }else {
        [self pushToDetailVCWithNotification:notification.userInfo];
    }
}

//客户端回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
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
        UITabBarController *mytab = (UITabBarController *)self.window.rootViewController;
        mytab.selectedIndex       = 0;
    }else if ([shortcutItem.type isEqualToString:@"two"]){
        UITabBarController *mytab     = (UITabBarController *)self.window.rootViewController;
        mytab.selectedIndex           = 1;
        DrawViewController *DrawVC    = [[DrawViewController alloc] initWithNibName:@"DrawViewController" bundle:nil];
        UINavigationController *myNAV = [mytab.viewControllers objectAtIndex:1];
        [myNAV pushViewController:DrawVC animated:YES];
        
    } else if ([shortcutItem.type isEqualToString:@"third"]) {
        UITabBarController *mytab      = (UITabBarController *)self.window.rootViewController;
        CenterViewController *centerVC = [[CenterViewController alloc] initWithNibName:NSStringFromClass([CenterViewController class]) bundle:nil];
        DNNavigationController *nav    = [[DNNavigationController alloc] initWithRootViewController:centerVC];
        [mytab presentViewController:nav animated:NO completion:nil];
    }
}
#pragma mark - method
//检测到app有新版本提醒更新
- (void)upgradeAppVersion {
    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appstoreId];
    [DNNetworking getWithURLString:urlStr success:^(id obj) {
        //下载地址
        NSString *trackViewUrlStr = [[[obj objectForKey:@"results"] firstObject] objectForKey:@"trackViewUrl"];
        //线上版本
        NSString *appstoreVersion = [[[obj objectForKey:@"results"] firstObject] objectForKey:@"version"];
        //当前版本
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        DNLog(@"线上版本%@----当前版本%@----下载地址%@",appstoreVersion, currentVersion, trackViewUrlStr);
        //判断客户端是不是最新版本
        if ([appstoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:trackViewUrlStr]];
                }
            } title:@"温馨提示" message:@"发现新版本，是否升级" cancelButtonName:@"取消" otherButtonTitles:@"升级", nil];
        }
    } failure:^(NSError *error) {
        
    }];
}

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
- (void)TouchSetting {//也可以在info.plist中静态配置UIApplicationShortcutItems
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"扫码" localizedTitle:@"扫码"];
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"打开应用" localizedTitle:@"打开应用"];
    NSArray *shortItems                   = [[NSArray alloc] initWithObjects:shortItem1, shortItem2, nil];
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
}

//设置三方登录分享的key
- (void)setThirdKeys {
    [OpenShare connectQQWithAppId:QQAppID];
    [OpenShare connectWeiboWithAppKey:WeiBoAppId];
    [OpenShare connectWeixinWithAppId:weixinAppID];
    [OpenShare connectAlipay];//支付宝参数都是服务器端生成的，这里不需要key.
}

//设置友盟推送
- (void)setUMPushWithOptions:(NSDictionary *)launchOptions {
    [UMessage startWithAppkey:UM_AppKey launchOptions:launchOptions];
    if (UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    }else {
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
    [UMessage setLogEnabled:YES];
    
}

//push消息接收后跳转
- (void)pushToDetailVCWithNotification:(NSDictionary *)userInfo {
    if (userInfo) {
        //通知栏的通知消息全部清除
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        DetailViewController *detailVC               = [[DetailViewController alloc] init];
        detailVC.urlStr                              = userInfo[@"go_url"];
        
        UITabBarController *tabViewController        = (UITabBarController *)self.window.rootViewController;
        DNNavigationController *sourceViewController = (DNNavigationController *)tabViewController.viewControllers[tabViewController.selectedIndex];
        [sourceViewController dismissAllModalControllerWithAnimated:NO];
        [sourceViewController pushViewController:detailVC animated:YES];
    }
}


@end
