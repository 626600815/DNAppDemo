//
//  DNBaseViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/19.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNBaseViewController.h"
#import "DNNavigationController.h"


@interface DNBaseViewController ()

@end

@implementation DNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = Ctr_backgroundColor;
    self.navigationItem.leftMargin = 8;
    
    DNNavigationController *nav = (DNNavigationController *)self.navigationController;
    [nav.backButton addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self backBarButtonItemAction];
    }];
}
//重新定义返回事件
- (void)backBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
