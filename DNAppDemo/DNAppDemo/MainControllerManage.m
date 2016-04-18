//
//  MainControllerManage.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "MainControllerManage.h"
#import "DNNavigationController.h"
#import "DNTabBarController.h"
#import "DNTabBarButton.h"
#import "TabBarTool.h"

#import "CenterViewController.h"

@interface MainControllerManage ()

//主视图(tabbar)
@property (nonatomic, strong) UIViewController *mainViewController;
//tabbar
@property (nonatomic, strong) DNTabBarController *tabBarController;
//所有controller的信息
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MainControllerManage

+ (MainControllerManage *)sharedManager {
    static MainControllerManage *managerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerInstance = [[MainControllerManage alloc] init];
    });
    return managerInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MainController" ofType:@"plist"]];
        self.mainViewController = [self creatMainControllerWithArray:array];
    }
    return self;
}


- (UIViewController *)creatMainControllerWithArray:(NSArray *)array {
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *className =obj[@"controller"];
        Class aClass = NSClassFromString(className);
        if (aClass) {
            id instance = [[aClass alloc] init];
            if ([instance isKindOfClass:[UIViewController class]]) {
                NSString *title = obj[@"title"];
                NSString *imageName = obj[@"image"];
                NSString *HimageName = obj[@"imageH"];
                
                [self.dataArray addObject:[self addChildWithVC:instance title:title imageName:imageName selectImageName:HimageName]];
            }
        }
    }];
    
    self.tabBarController.selectedIndex = 0;
    self.tabBarController.viewControllers = self.dataArray;
    
    //设置tabBar中间的按钮
    [self.tabBarController.centerButton setHeightOffset:5];
    [self.tabBarController.centerButton setImage:[UIImage imageNamed:@"tab_center_normal"] forState:UIControlStateNormal];
    [self.tabBarController.centerButton setImage:[UIImage imageNamed:@"tab_center_selected"] forState:UIControlStateHighlighted];
    [self.tabBarController.centerButton addTarget:self action:@selector(centerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    return self.tabBarController;
}


- (DNNavigationController *)addChildWithVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName {
    childVC.tabBarItem = [TabBarTool  itemWithTitle:title normalImg:imageName selectImg:selectImageName];
    childVC.navigationItem.title = title;
    DNNavigationController *navi = [[DNNavigationController alloc] initWithRootViewController:childVC];
    return navi;
}

//按钮按下
- (void)centerButtonPressed {
    CenterViewController *centerVC = [[CenterViewController alloc] initWithNibName:NSStringFromClass([CenterViewController class]) bundle:nil];
    DNNavigationController *nav = [[DNNavigationController alloc] initWithRootViewController:centerVC];
    [self.tabBarController presentViewController:nav animated:NO completion:nil];
}

#pragma mark - 初始化

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return  _dataArray;
}

- (DNTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[DNTabBarController alloc] init];
    }
    return _tabBarController;
}

@end
