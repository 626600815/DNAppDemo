//
//  DNNetStatus.m
//  DNAppDemo
//
//  Created by mainone on 16/4/28.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNNetStatus.h"
#import "Reachability.h"

@implementation DNNetStatus

+ (NetworkStatus)status {
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
}

+ (BOOL)isWiFiEnable {
    return [self status]==ReachableViaWiFi;
}

+ (BOOL)isNetworkEnable {
    return [self status] != NotReachable;
}

@end
