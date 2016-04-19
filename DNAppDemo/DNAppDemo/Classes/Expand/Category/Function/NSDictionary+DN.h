//
//  NSDictionary+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DN)

/**
 *  字典转json字符串
 *
 *  @return json字符串
 */
- (NSString *)JSONString;

/**
 *  合并两个字典
 *
 *  @param dict1 字典1
 *  @param dict2 字典2
 *
 *  @return 合并后的字典
 */
+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;

/**
 *  一个字典合并进另一个字典
 *
 *  @param dict 要合并进来的字典
 *
 *  @return 合并后的字典
 */
- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict;

/**
 *  安全的取出字典中对用key值
 *
 *  @param key key
 *
 *  @return 值
 */
- (NSString*)stringForKey:(id)key;

/**
 *  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)XMLString;

@end

@interface NSMutableDictionary (DN)

/**
 *  安全的存入一个键值对
 *
 *  @param i   value
 *  @param key key
 */
-(void)setObj:(id)i forKey:(NSString*)key;

@end

