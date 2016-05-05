//
//  MyQRCodeViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "MyQRCodeViewController.h"

@interface MyQRCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *ewmImage;//二维码

@end

@implementation MyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的二维码";
    
    //二维码
    self.ewmImage = [UIImage createQRForString:self.myUrlString withSize:200];
    self.imageView.image = self.ewmImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
