//
//  DNThirdLogin.m
//  DNAppDemo
//
//  Created by mainone on 16/4/27.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNThirdLogin.h"
#import "OpenShareHeader.h"

@implementation DNThirdLogin

+ (DNThirdLogin *)shareLogin {
    static DNThirdLogin *shareLoginManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareLoginManager = [[DNThirdLogin alloc] init];
    });
    return shareLoginManager;
}


- (void)loginToPlatform:(DNThirdLoginType)platform completionHandle:(void (^)(NSDictionary *data, NSError *error))completionHandler {
    if (platform == DNThirdLoginTypeQQ) {
        if (![OpenShare isQQInstalled]) {
            [self alertViewWithName:@"QQ"];
            return;
        }
        [OpenShare QQAuth:@"get_user_info" Success:^(NSDictionary *message) {
           [self qqOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            
        }];
       
    } else if (platform == DNThirdLoginTypeWeiXin) {
        if (![OpenShare isWeixinInstalled]) {
            [self alertViewWithName:@"微信"];
            return;
        }
        [OpenShare WeixinAuth:@"snsapi_userinfo" Success:^(NSDictionary *message) {
            [self weixinOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            
        }];
    } else if (platform == DNThirdLoginTypeWeibo) {
        if (![OpenShare isWeiboInstalled]) {
            [self alertViewWithName:@"微博"];
            return;
        }
        [OpenShare WeiboAuth:@"all" redirectURI:WeiBoAppRedirectURL Success:^(NSDictionary *message) {
            [self weiboOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            
        }];
    }
}

//提醒没有安装客户端
- (void)alertViewWithName:(NSString *)nameStr {
    NSString *msg = [NSString stringWithFormat:@"没有安装%@客户端",nameStr];
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提醒" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertV show];
}

//获取QQ用户信息
- (void)qqOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler {
    NSString *url = @"http://openapi.tencentyun.com/v3/user/get_info";
    NSMutableDictionary *params = @{@"appid": QQAppID,
                                    @"openkey": message[@"access_token"],
                                    @"openid": message[@"openid"],
                                    @"pf": @"qzone",
                                    @"format": @"json"}.mutableCopy;
    NSMutableString *paramsString = [NSString stringWithFormat:@"GET&%@&", [@"/v3/user/get_info" encodeURL]].mutableCopy;
    NSArray *keys = @[@"appid", @"format", @"openid", @"openkey", @"pf"];
    NSMutableString *keyValueString = @"".mutableCopy;
    for (NSString *key in keys) {
        [keyValueString appendFormat:@"%@=%@&", key, params[key]];
    }
    [keyValueString appendString:@"userip="];
    keyValueString = [keyValueString encodeURL].mutableCopy;
    [keyValueString appendString:@"10.0.0.1"];
    NSString *signStr = [NSString stringWithFormat:@"%@%@", paramsString, keyValueString];
    NSString *sss = [signStr hmacSha1WithKey:[NSString stringWithFormat:@"%@&", QQAppKey]];
    NSString *sig = [sss encodeURL];
    params[@"sig"] = sig;
    params[@"userip"] = @"10.0.0.1";
    
    NSMutableString *urlString = @"?".mutableCopy;
    for (NSString *key in params.allKeys) {
        [urlString appendFormat:@"%@=%@&", key, params[key]];
    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", url, urlString];
    requestUrl = [requestUrl substringToIndex:requestUrl.length - 1];
    
    [DNSNSRequest get:requestUrl completionHandler:^(NSDictionary *data, NSError *error) {
        NSMutableDictionary *dict = data.mutableCopy;
        [dict addEntriesFromDictionary:message];
        if (completionHandler) {
            completionHandler(dict, error);
        }
    }];
}

//获取微信用户信息
- (void)weixinOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler {
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", weixinAppID, weixinAppSecret, message[@"code"]];
    [DNSNSRequest get:url completionHandler:^(NSDictionary *data, NSError *error) {
        NSString *accessToken = data[@"access_token"];
        NSString *openid = data[@"openid"];
        NSString *userInfoUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=zh_CN", accessToken, openid];
        [DNSNSRequest get:userInfoUrl completionHandler:^(NSDictionary *userInfo, NSError *error) {
            NSMutableDictionary *dict = userInfo.mutableCopy;
            [dict addEntriesFromDictionary:message];
            if (completionHandler) {
                completionHandler(dict, error);
            }
        }];
    }];
}

- (void)weiboOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler {
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *params = @{@"source": WeiBoAppId,
                             @"access_token": message[@"accessToken"],
                             @"uid": message[@"userID"]};
    [DNSNSRequest get:url params:params completionHandler:^(NSDictionary *data, NSError *error) {
        NSMutableDictionary *dict = data.mutableCopy;
        [dict addEntriesFromDictionary:message];
        if (completionHandler) {
            completionHandler(dict, error);
        }
    }];
}


@end
