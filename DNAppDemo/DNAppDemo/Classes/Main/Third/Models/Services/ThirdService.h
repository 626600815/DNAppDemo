//
//  ThirdService.h
//  DNAppDemo
//
//  Created by mainone on 16/4/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdService : NSObject

+ (void)requestFriendListInfo:(void (^)(NSArray *listArray))infoArr;

@end
