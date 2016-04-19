//
//  DNNavigationController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNNavigationController.h"

@interface DNNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation DNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
//    [self.navigationBar setBarTintColor:Nav_BarTintColor];
    [self.navigationBar setTintColor:Nav_TintColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:Nav_TitleFont,
                                                                      NSForegroundColorAttributeName:Nav_TitleColor}];
    [self.navigationBar setBarStyle:UIBarStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
        // 左上角的返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"nav_back_selected"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -10;
        
        viewController.navigationItem.leftBarButtonItems = @[spaceItem, leftItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(nonnull UIGestureRecognizer *)gestureRecognizer {
    // 如果当前显示的是第一个子控制器,就应该禁止掉[返回手势]
    return self.childViewControllers.count > 1;
}


@end
