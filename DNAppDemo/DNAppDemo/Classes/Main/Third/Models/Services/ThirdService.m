//
//  ThirdService.m
//  DNAppDemo
//
//  Created by mainone on 16/4/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ThirdService.h"
#import "Friend.h"
#import "FriendGroup.h"

@implementation ThirdService

+ (void)requestFriendListInfo:(void (^)(NSArray *listArray))infoArr {
    NSArray *tempArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil]];
    NSArray *listArray = [FriendGroup mj_objectArrayWithKeyValuesArray:tempArr];
    infoArr(listArray);
}

@end
