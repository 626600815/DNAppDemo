//
//  ResignViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ResignViewController.h"
#import "MainControllerManage.h"

@interface ResignViewController ()

@end

@implementation ResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置导航栏样式
    [self initNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 初始化
- (void)initNav {
    self.navigationItem.title = @"注册";
}


@end
