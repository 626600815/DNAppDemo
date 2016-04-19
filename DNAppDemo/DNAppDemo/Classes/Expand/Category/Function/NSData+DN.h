//
//  NSData+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DN)

/**
 *  将NSData类型的token转换成字符串
 *
 *  @return 整理后的字符串
 */
- (NSString *)APNSToken;

/**
 *  字符串base64转data
 *
 *  @param string 要转的字符串
 *
 *  @return base64转码之后的data
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

/**
 *  NSData转字符串
 *
 *  @return base64
 */
- (NSString *)base64EncodedString;

/**
 *  AES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  AES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  3DES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  3DES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
- (NSString *)UTF8String;

@end

