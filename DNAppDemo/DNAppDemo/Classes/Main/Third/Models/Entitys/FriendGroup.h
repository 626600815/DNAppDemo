//
//  FriendGroup.h
//  DNAppDemo
//
//  Created by mainone on 16/4/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendGroup : NSObject

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger online;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

@end
