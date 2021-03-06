//
//  DNLocationHelper.m
//  DNAppDemo
//
//  Created by mainone on 16/4/19.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNLocationHelper.h"

@implementation DNLocationHelper

//百度转火星坐标
+ (CLLocationCoordinate2D )bdToGGEncrypt:(CLLocationCoordinate2D)coord {
    double x                    = coord.longitude - 0.0065, y = coord.latitude - 0.006;
    double z                    = sqrt(x * x + y * y) - 0.00002 * sin(y * M_PI);
    double theta                = atan2(y, x) - 0.000003 * cos(x * M_PI);
    CLLocationCoordinate2D transformLocation ;
    transformLocation.longitude = z * cos(theta);
    transformLocation.latitude  = z * sin(theta);
    return transformLocation;
}

//火星坐标转百度坐标
+ (CLLocationCoordinate2D )ggToBDEncrypt:(CLLocationCoordinate2D)coord {
    double x                    = coord.longitude, y = coord.latitude;
    double z                    = sqrt(x * x + y * y) + 0.00002 * sin(y * M_PI);
    double theta                = atan2(y, x) + 0.000003 * cos(x * M_PI);
    CLLocationCoordinate2D transformLocation ;
    transformLocation.longitude = z * cos(theta) + 0.0065;
    transformLocation.latitude  = z * sin(theta) + 0.006;
    return transformLocation;
}

@end
