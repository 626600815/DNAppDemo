//
//  NSArray+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DN)
/**
 *  安全取出数组中的元素
 */
- (id)objectWithIndex:(NSUInteger)index;

/**
 *  数组转字符串
 */
-(NSString *)string;

@end

@interface NSMutableArray(DN)
/**
 *  安全的把元素存入到数组中
 *
 *  @param i 元素
 */
-(void)addObj:(id)i;


@end