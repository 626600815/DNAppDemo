//
//  LoginViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "LoginViewController.h"
#import "ResignViewController.h"
#import "DNThirdLogin.h"
#import "OpenShareHeader.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

#pragma mark - Method
//取消按钮点击
- (void)leftItemClick {
    [self dismissAllModalController];
}

//注销按钮点击
- (void)rightItemClick {
    ResignViewController *resignVC = [[ResignViewController alloc] initWithNibName:@"ResignViewController" bundle:nil];
    [self.navigationController pushViewController:resignVC animated:YES];
}

#pragma mark - 三方登录

//QQ登录
- (IBAction)QQLoginClick:(UIButton *)sender {
    [self thirdLogin:DNThirdLoginTypeQQ];
}

//微信登录
- (IBAction)weixinLoginClick:(UIButton *)sender {
    [self thirdLogin:DNThirdLoginTypeWeiXin];

}

//微博登录
- (IBAction)weiboLoginClick:(UIButton *)sender {
    [self thirdLogin:DNThirdLoginTypeWeibo];
}

//三方登陆
- (void)thirdLogin:(DNThirdLoginType)type {
    [[DNThirdLogin shareLogin] loginToPlatform:type completionHandle:^(NSDictionary *data, NSError *error) {
        if (error) {
            DNLog(@"----->%@",error);
            return ;
        }
        DNLog(@"=======>%@",data);
    }];
}


#pragma mark - 初始化
//设置导航栏样式
- (void)initNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    self.navigationItem.title = @"登录";
}


@end
