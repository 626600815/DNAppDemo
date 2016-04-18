//
//  DNSecretInfo.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNSecretInfo.h"
#import "DNKeyChain.h"

static NSString * const KEY_IN_KEYCHAIN = @"com.wjn.DNAppDemo.allinfo";
static NSString * const KEY_PASSWORD = @"com.wjn.DNAppDemo.password";//密码
static NSString * const KEY_USERNAME = @"com.wjn.DNAppDemo.username";//用户名
static NSString * const KEY_USERID = @"com.wjn.DNAppDemo.userid";//用户ID

@implementation DNSecretInfo

//保存用户名和密码
+ (void)savePassWord:(NSString *)password UserName:(NSString *)username {
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    //存用户信息
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [usernamepasswordKVPairs setObject:username forKey:KEY_USERNAME];
    
    [DNKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}
//读取所有信息
+ (id)readall {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[DNKeyChain load:KEY_IN_KEYCHAIN];
    return usernamepasswordKVPair;
}
//保存用户ID
+ (void)saveUserID:(NSString *)userID {
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:userID forKey:KEY_USERID];
    [DNKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}
//读取用户ID
+ (NSString *)readUID {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[DNKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_USERID];
}
//读取用户密码
+ (NSString *)readPassWord {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[DNKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}
//读取用户名
+ (NSString *)readUserName {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[DNKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_USERNAME];
}
//删除用户名和密码
+ (void)deletePassWord {
    [DNKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
