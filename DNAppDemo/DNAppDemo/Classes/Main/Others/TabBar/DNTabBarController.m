//
//  DNTabBarController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNTabBarController.h"

@interface DNTabBarController ()

//中心按钮
@property(strong, nonatomic) DNTabBarButton *centerButton;

@end

@implementation DNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设定Tabbar的颜色
    [self.tabBar setTranslucent:YES];
    [self.tabBar setBarStyle:UIBarStyleBlack];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tabBar bringSubviewToFront:self.centerButton];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    NSInteger centerIndex              = viewControllers.count/2;
    UIViewController *viewController   = [[UIViewController alloc] init];
    NSMutableArray *newViewControllers = [[NSMutableArray alloc] initWithArray:viewControllers];
    [newViewControllers insertObject:viewController atIndex:centerIndex];
    [super setViewControllers:newViewControllers];
    self.centerButton                  = [[DNTabBarButton alloc] initWithTabBar:self.tabBar forItemIndex:centerIndex];
}


@end
