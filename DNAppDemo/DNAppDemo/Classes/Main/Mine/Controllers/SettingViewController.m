//
//  SettingViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "SettingViewController.h"
#import "MainControllerManage.h"
#import "DNActionSheetManager.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(selectImage)];
    self.navigationItem.rightMargin = 10;
}

- (void)selectImage {
    [[DNActionSheetManager shareActionSheet] showImagePickerWithVC:self selectImage:^(UIImage *image) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }];
}

                          
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
