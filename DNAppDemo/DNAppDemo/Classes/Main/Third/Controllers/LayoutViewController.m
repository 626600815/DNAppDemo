//
//  LayoutViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/5/9.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "LayoutViewController.h"

@interface LayoutViewController ()

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self baseView];
    
 
}

- (void)baseView {
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor RandomColor];
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor RandomColor];
    [self.view addSubview:view2];
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor RandomColor];
    [self.view addSubview:view3];
    
    UIView *superview = self.view;
    NSInteger padding = 10;
    
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).offset(padding);
        make.top.equalTo(superview.mas_top).offset(padding + 64);
        make.width.equalTo(view2.mas_width);
        make.height.equalTo(superview.mas_height).multipliedBy(0.5).offset(-64);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(view1.mas_right).offset(padding);
        make.top.equalTo(view1.mas_top);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.height.equalTo(view1.mas_height);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(padding);
        make.left.equalTo(view1.mas_left);
        make.right.equalTo(view2.mas_right);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
