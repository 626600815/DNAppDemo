//
//  SecondViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "SecondViewController.h"
#import "MenuViewController.h"
#import "OpenShareHeader.h"
#import "DNShareView.h"
#import "DNThirdLogin.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(shareMenu)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
           NSLog(@"----->%@",error);
           return ;
       }
       NSLog(@"=======>%@",data);
   }];
}


- (void)dismissVC {
    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuVC animated:YES];
}

- (void)shareMenu {
    DNShareView *shareView = [[DNShareView alloc] initWithShare];
    shareView.contentUrl = @"http://www.baidu.com";
    shareView.showtext = @"content";
    shareView.myCopyUrl = @"http://www.baidu.com";
    shareView.erweimaUrl = @"http://www.baidu.com";
    shareView.titleName = @"title";
    shareView.showImageUrl = @"http://www.5068.com/u/faceimg/20140804114111.jpg";
    [shareView showInView:self.view];
}

@end
