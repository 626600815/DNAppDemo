//
//  NSString+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


enum{
    NSStringScoreOptionNone                         = 1 << 0,
    NSStringScoreOptionFavorSmallerWords            = 1 << 1,
    NSStringScoreOptionReducedLongStringPenalty     = 1 << 2
};
typedef NSUInteger NSStringScoreOption;

@interface NSString (DN)

/**
 *  判断URL中是否包含中文
 */
- (BOOL)isContainChinese;

/**
 *  是否包含空格
 */
- (BOOL)isContainBlank;

/**
 *  是否包含字符串
 */
- (BOOL)hasString:(NSString *)string;

/**
 *  是否为正确格式邮箱
 */
- (BOOL)isValidateEmail;

/**
 *  密码有效性检测检测(6-16位不是纯字母或者数字)
 */
- (BOOL)isValiratePassWord;

/**
 *  是否为正确格式手机号
 */
- (BOOL)isValidateMobile;

/**
 *  身份证号码有效性检测
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  邮政编码
 */
- (BOOL)isValidPostalcode;

/**
 *  银行卡的有效性
 */
- (BOOL)isBankCardluhmCheck;

/**
 *  网址有效性
 */
- (BOOL)isValidUrl;

/**
 *  获取字符数量
 */
- (int)wordsCount;

/**
 *  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryValue;

/**
 *  base64编码
 */
- (NSString *)base64EncodedString;

/**
 *  base64解码
 */
- (NSString *)base64DecodedString;

/**
 *  base64解码转data
 */
- (NSData *)base64DecodedData;

/**
 *  Unicode编码的字符串转成NSString
 */
- (NSString *)makeUnicodeToString;

/**
 *  AES加密
 */
- (NSString*)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  AES解密
 */
- (NSString*)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  3DES加密
 */
- (NSString*)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  3DES解密
 */
- (NSString*)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  md5加密
 */
- (NSString *)MD5String;

/**
 *  //模糊匹配字符串 查找某两个字符串的相似程度
 */
- (CGFloat) scoreAgainst:(NSString *)otherString;


/**
 *  计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  xml字符串转换成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)dictionaryFromXML;

/**
 *  网址拼接
 *
 *  @param urlString  网址
 *  @param parameters 参数
 *
 *  @return 完整网址
 */
+ (NSString *)URLString:(NSString *)urlString appendParameters:(NSDictionary *)parameters;


/// 将字符串进行Url编码
- (NSString *)encodeURL;

/// 将字符串进行Hash
- (NSString *)hmacSha1WithKey:(NSString *)key;

@end
