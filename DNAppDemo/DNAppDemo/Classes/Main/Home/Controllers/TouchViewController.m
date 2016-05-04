//
//  TouchViewController.m
//  DN3DTouchDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "TouchViewController.h"
#import "AppDelegate.h"
#import "DrawViewController.h"

@interface TouchViewController ()

@end

@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我是标题";
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.numberOfLines = 0;
    label.text = self.homeModel.content;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction * action1 = [UIPreviewAction actionWithTitle:@"去画画" style:0 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        DrawViewController *vc = [[DrawViewController alloc] initWithNibName:@"DrawViewController" bundle:nil];
        [[self topViewController].navigationController pushViewController:vc animated:YES];
    }];
    UIPreviewAction * action2 = [UIPreviewAction actionWithTitle:@"取消" style:2 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    }];
    NSArray * actions = @[action1,action2];
    
    return actions;
}

- (UIViewController*)topViewController {
     UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    return [self topViewControllerWithRootViewController:window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
