//
//  DNSNSRequest.h
//  DNAppDemo
//
//  Created by mainone on 16/4/27.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNSNSRequest : NSObject

+ (void)get:(NSString *)urlPath completionHandler:(void (^)(id data, NSError *error))completionHandler;
+ (void)get:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;

@end
