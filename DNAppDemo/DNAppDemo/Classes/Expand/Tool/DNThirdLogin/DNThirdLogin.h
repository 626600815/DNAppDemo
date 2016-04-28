//
//  DNThirdLogin.h
//  DNAppDemo
//
//  Created by mainone on 16/4/27.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DNSNSRequest.h"


typedef NS_ENUM (NSUInteger, DNThirdLoginType){
    DNThirdLoginTypeQQ,
    DNThirdLoginTypeWeiXin,
    DNThirdLoginTypeWeibo
};

@interface DNThirdLogin : NSObject

+ (DNThirdLogin *)shareLogin;

- (void)loginToPlatform:(DNThirdLoginType)platform completionHandle:(void (^)(NSDictionary *data, NSError *error))completionHandler;


@end
