//
//  NSHTTPCookieStorage+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPCookieStorage (DN)

/**
 *  存储UIWebview 的 cookies到磁盘目录
 */
- (void)save;

/**
 *  读取UIwebview 的cookies从磁盘目录
 */
- (void)load;

@end
