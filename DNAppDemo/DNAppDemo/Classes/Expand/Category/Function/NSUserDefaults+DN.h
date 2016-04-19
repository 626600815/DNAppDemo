//
//  NSUserDefaults+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (DN)

/**
 *  安全的存入一个键值对
 *
 *  @param i   value
 *  @param key key
 */
-(void)setObj:(id)i forKey:(NSString*)key;

@end
