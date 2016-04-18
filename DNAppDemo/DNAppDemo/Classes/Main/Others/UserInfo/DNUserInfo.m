//
//  DNUserInfo.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNUserInfo.h"

#define NickName    @"user_NickName"
#define Avatars     @"user_Avatars"
#define PhoneNumber @"user_PhoneNumber"
#define Email       @"user_Email"
#define Sex         @"user_Sex"
#define Content     @"user_Content"

#define RemPassword @"isRemPassword"
#define LoginStatus @"isLoginStatus"

@implementation DNUserInfo

singleton_implementation(DNUserInfo);


- (void)saveUserToSanbox {
    [self setSafeObj:self.user_NickName forKey:NickName];
    [self setSafeObj:self.user_Avatars forKey:Avatars];
    [self setSafeObj:self.user_PhoneNumber forKey:PhoneNumber];
    [self setSafeObj:self.user_Email forKey:Email];
    [self setSafeObj:self.user_Sex forKey:Sex];
    [self setSafeObj:self.user_Content forKey:Content];
    
    [self setSafeBool:self.isRemPassword forKey:RemPassword];
    [self setSafeBool:self.isLoginStatus forKey:LoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadUserFromSanbox {
    NSUserDefaults *def   = [NSUserDefaults standardUserDefaults];
    self.user_NickName    = [def objectForKey:NickName];
    self.user_Avatars     = [def objectForKey:Avatars];
    self.user_PhoneNumber = [def objectForKey:PhoneNumber];
    self.user_Email       = [def objectForKey:Email];
    self.user_Sex         = [def objectForKey:Sex];
    self.user_Content     = [def objectForKey:Content];

    self.isRemPassword    = [def boolForKey:RemPassword];
    self.isLoginStatus    = [def boolForKey:LoginStatus];
}

//安全存入数据，防止出现NULL而崩溃
-(void)setSafeObj:(id)value forKey:(NSString *)key {
    if (value!=nil && ![value isEqual:[NSNull null]]) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
}

- (void)setSafeBool:(BOOL)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

@end
