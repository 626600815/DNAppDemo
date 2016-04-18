//
//  HomeViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "HomeViewController.h"
#import "DNUserInfo.h"
#import "DNLocationManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [[DNLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
//        NSLog(@"经度:%f-----维度:%f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
//    }];
    
    [[DNLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        NSLog(@"经度:%f-----维度:%f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
    } withAddress:^(NSString *addressString) {
        NSLog(@"地址：%@",addressString);
    } failure:^(NSError *error) {
        NSLog(@"出现的错误：%@",error);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
