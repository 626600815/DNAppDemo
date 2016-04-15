//
//  TabBarTool.h
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabBarTool : NSObject

//创建一个标签栏的标签
+ (UITabBarItem *)itemWithTitle:(NSString *)title normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg;

@end
