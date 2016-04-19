//
//  NSArray+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSArray+DN.h"

@implementation NSArray (DN)

-(id)objectWithIndex:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    } else {
        return nil;
    }
}

- (NSString *)string {
    if(self==nil || self.count==0) return @"";
    NSMutableString *str=[NSMutableString string];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,",obj];
    }];
    //删除最后一个','
    NSString *strForRight = [str substringWithRange:NSMakeRange(0, str.length-1)];
    
    return strForRight;
}

@end

@implementation NSMutableArray (DN)

-(void)addObj:(id)i {
    if (i != nil) {
        [self addObject:i];
    }
}

@end