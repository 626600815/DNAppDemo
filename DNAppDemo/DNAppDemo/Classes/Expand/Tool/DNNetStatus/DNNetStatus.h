//
//  DNNetStatus.h
//  DNAppDemo
//
//  Created by mainone on 16/4/28.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNNetStatus : NSObject

/**
 *  是否处于WIFI环境中：
 */
+ (BOOL)isWiFiEnable;

/**
 *  是否有网络数据连接：含2G/3G/WIFI
 */
+ (BOOL)isNetworkEnable;

@end
