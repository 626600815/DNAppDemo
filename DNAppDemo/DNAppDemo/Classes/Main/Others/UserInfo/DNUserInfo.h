//
//  DNUserInfo.h
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

#define DNUser [DNUserInfo sharedDNUserInfo]

@interface DNUserInfo : NSObject

singleton_interface(DNUserInfo);

@property (nonatomic, strong) NSString *user_NickName;/**<用户昵称*/
@property (nonatomic, strong) NSString *user_Avatars;/**<用户头像*/
@property (nonatomic, strong) NSString *user_PhoneNumber;/**<绑定手机号*/
@property (nonatomic, strong) NSString *user_Email;/**<绑定邮箱*/
@property (nonatomic, strong) NSString *user_Sex;/**<用户性别*/
@property (nonatomic, strong) NSString *user_Content;/**<用户简介*/

@property (nonatomic, assign) BOOL isRemPassword;/**<记住密码*/
@property (nonatomic, assign) BOOL isLoginStatus;/**<登录状态*/


#pragma mark - methods

- (void)saveUserToSanbox;/**<保存信息*/

- (void)loadUserFromSanbox;/**<更新加载信息*/

@end
