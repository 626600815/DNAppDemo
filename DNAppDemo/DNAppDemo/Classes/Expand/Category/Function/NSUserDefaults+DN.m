//
//  NSUserDefaults+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSUserDefaults+DN.h"

@implementation NSUserDefaults (DN)

- (void)setObj:(id)i forKey:(NSString*)key {
    if (i!=nil && ![i isEqual:[NSNull null]]) {
        [self setObject:i forKey:key];
    }
}

@end
