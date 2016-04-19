//
//  NSData+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "NSData+DN.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>


#pragma GCC diagnostic ignored "-Wselector"
@implementation NSData (DN)

- (NSString *)APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    if (![string length]) return nil;
    NSData *decoded = nil;
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
#pragma clang diagnostic pop
    }
    else
#endif
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    return [decoded length]? decoded: nil;
}

- (NSString *)base64EncodedString {
    return [self base64EncodedStringWithWrapWidth:0];
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
    if (![self length]) return nil;
    NSString *encoded = nil;
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        encoded = [self base64Encoding];
#pragma clang diagnostic pop
        
    }
    else
#endif
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    if (!wrapWidth || wrapWidth >= [encoded length]) {
        return encoded;
    }
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth) {
        if (i + wrapWidth >= [encoded length]) {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    return result;
}

- (NSData*)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    CCCryptorStatus status = CCCrypt(kCCEncrypt,kCCAlgorithmAES128,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,encryptedData.mutableBytes,encryptedData.length,&dataMoved);
    if (status == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    return nil;
}

- (NSData*)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    CCCryptorStatus result = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding, keyData.bytes, keyData.length,iv.bytes,self.bytes,self.length,decryptedData.mutableBytes, decryptedData.length,&dataMoved);
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

- (NSData*)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    CCCryptorStatus result = CCCrypt(kCCEncrypt,kCCAlgorithm3DES,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,encryptedData.mutableBytes,encryptedData.length,&dataMoved);
    if (result == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    return nil;
}

- (NSData*)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    CCCryptorStatus result = CCCrypt(kCCDecrypt,kCCAlgorithm3DES,kCCOptionPKCS7Padding,keyData.bytes,keyData.length,iv.bytes,self.bytes,self.length,decryptedData.mutableBytes,decryptedData.length,&dataMoved);
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

- (NSString *)UTF8String {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
