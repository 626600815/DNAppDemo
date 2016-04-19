//
//  UIWebView+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIWebView+DN.h"

@implementation UIWebView (DN)

- (void)loadWebsite:(NSString *)website {
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:website]]];
}

- (void)postWebsite:(NSString *)website body:(NSString *)body {
    NSURL *url = [NSURL URLWithString:website];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [self loadRequest:request];
}

- (int)nodeCountOfTag:(NSString *)tag {
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    int len = [[self stringByEvaluatingJavaScriptFromString:jsString] intValue];
    return len;
}

- (NSString *)getCurrentURL {
    return [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}

- (NSString *)getTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (NSArray *)getImgs {
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
    }
    return arrImgURL;
}

- (NSArray *)getOnClicks {
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"a"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%d].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        NSLog(@"%@", clickString);
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}


- (NSString *)getContentWithID:(NSString *)tagID {
    for (int i = 0; i < [self nodeCountOfTag:@"input"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('input')[%d].value", i];
        NSString *jsStringID = [NSString stringWithFormat:@"document.getElementsByTagName('input')[%d].id", i];
        if ([[self stringByEvaluatingJavaScriptFromString:jsStringID] isEqualToString:tagID]) {
            return [self stringByEvaluatingJavaScriptFromString:jsString];
        }
    }
    return nil;
}


- (NSString *)getShareTitle {
    NSString *shareTitle = [self getContentWithID:@"title_share"];
    return shareTitle;
}

- (NSString *)getShareImage {
    NSString *shareImage = [self getContentWithID:@"image_share"];
    if (shareImage.length > 0) {
        return shareImage;
    }else {
        return @"http://img.wiibao.cn/wiibao/144.png";
    }
    
}

- (NSString *)getSharecontent {
    NSString *sharecontent = [self getContentWithID:@"content_share"];
    if (sharecontent.length > 0) {
        return sharecontent;
    }else {
        return @"详情";
    }
}

- (NSString *)getShareURL {
    NSString *shareURL= [self getContentWithID:@"url_share"];
    return shareURL;
    
}


@end

