//
//  Friend.h
//  DNAppDemo
//
//  Created by mainone on 16/4/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign, getter = isVip) BOOL vip;

@end
