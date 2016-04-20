//
//  DNLocationManager.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface DNLocationManager () <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) DNLocationBlock locationBlock;
@property (nonatomic, strong) DNAddressBlock addressBlock;
@property (nonatomic, strong) DNCityBlock cityBlock;
@property (nonatomic, strong) DNLocationErrorBlock errorBlock;
@property (nonatomic, strong) DNAddressErrorBlock addressErrorBlock;


@property (nonatomic, strong) CLLocationManager *locationM;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation DNLocationManager

+ (DNLocationManager *)shareLocation {
    static DNLocationManager *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[DNLocationManager alloc] init];
    });
    return manage;
}

#pragma mark - 请求回调方法
- (void)getLocationCoordinate:(DNLocationBlock)locaiontBlock failure:(DNLocationErrorBlock)error {
    self.locationBlock = [locaiontBlock copy];
    self.errorBlock = [error copy];
    [self startLocation];
}

- (void)getAddress:(DNAddressBlock)addressBlock failure:(DNAddressErrorBlock)error {
    self.addressBlock = [addressBlock copy];
    self.addressErrorBlock = [error copy];
    [self startLocation];
}

- (void)getLocationCoordinate:(DNLocationBlock)locaiontBlock withAddress:(DNAddressBlock)addressBlock failure:(DNLocationErrorBlock)error addressFailure:(DNAddressErrorBlock)Aerror {
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    self.errorBlock = [error copy];
    self.addressErrorBlock = [Aerror copy];
    [self startLocation];
}

- (void)getCity:(DNCityBlock)cityBlock failure:(DNLocationErrorBlock)error{
    self.cityBlock = [cityBlock copy];
    self.addressErrorBlock = [error copy];
    [self startLocation];
}

#pragma mark - 定位功能开启
- (void)startLocation {
    [self.locationM startUpdatingLocation];
}

- (CLLocationManager *)locationM {
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc]init];
        _locationM.delegate = self;
        _locationM.desiredAccuracy = kCLLocationAccuracyBest;//定位精确度
        _locationM.distanceFilter = 10;//超出位置变化范围更新位置信息
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [_locationM requestWhenInUseAuthorization ];//使用的时候使用
            //            [_locationM requestAlwaysAuthorization];//总是使用
        }
        //        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        //            _locationM.allowsBackgroundLocationUpdates = YES;
        //        }
    }
    return _locationM;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(void)locationManager:(nonnull CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation * > *)locations {
    NSLog(@"每当请求到位置信息时, 都会调用此方法");
    CLLocation *location   = [locations firstObject];//坐标
    //返回请求结果
    if (_locationBlock) {
        _locationBlock(location.coordinate);
        _locationBlock = nil;
    }
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count==0) {
            if (_addressErrorBlock) {
                _addressErrorBlock(error);
                _addressErrorBlock = nil;
            }
            return;
        }
        CLPlacemark *placemark = [placemarks firstObject];
        
        if (_addressBlock) {
            _addressBlock(placemark.name);
            _addressBlock = nil;
        }
        
        if (_cityBlock) {
            _cityBlock(placemark.locality);
            _cityBlock = nil;
        }
        
    }];
    [manager stopUpdatingLocation];//不需要实时定位就停止定位
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败 : %@",error);
    if (_errorBlock) {
        _errorBlock(error);
        _errorBlock = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户未决定");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"访问受限");//没啥用
            break;
        case kCLAuthorizationStatusDenied: {//定位关闭时和对此APP授权为never时调用
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位开启,但被拒绝");//让用户到设置界面进行授权
                
                NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:settingURL] && [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                    //iOS8跳转到设置界面
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位功能被拒绝，是否前往设置开启" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alertView show];
                } else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位功能未开启,请在设置中开启" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                }
                
            }else{
                NSLog(@"定位关闭,不可用");
                NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:settingURL] && [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                    //iOS8跳转到设置界面
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位功能未开启，是否前往设置开启" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alertView show];
                } else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务未开启\n打开方式:设置->隐私->定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                }
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways: {
            NSLog(@"获取前后台定位授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            NSLog(@"获取前台定位授权");
            break;
        }
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingURL];
    }
}

@end
