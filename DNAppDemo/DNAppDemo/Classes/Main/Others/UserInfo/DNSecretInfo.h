//
//  DNSecretInfo.h
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h> 

@interface DNSecretInfo : NSObject

/**存储账号和密码*/
+ (void)savePassWord:(NSString *)password UserName:(NSString *)username;

/**存储用户ID*/
+ (void)saveUserID:(NSString *)userID;

/**读取用户ID*/
+ (NSString *)readUID;

/**读取用户名*/
+ (NSString *)readUserName;

/**读取密码*/
+ (NSString *)readPassWord;

/**删除用户所有信息*/
+ (void)deletePassWord;

@end
