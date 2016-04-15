//
//  TabBarTool.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "TabBarTool.h"

@implementation TabBarTool

+ (UITabBarItem *)itemWithTitle:(NSString *)title normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg {
    UITabBarItem *tabItem;
    UIImage * normalImage = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage = [[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabItem = [[UITabBarItem alloc] initWithTitle:nil
                                            image:normalImage
                                    selectedImage:selectImage];
    [tabItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}
                           forState:UIControlStateSelected];
    tabItem.title = title;
    return tabItem;
}

@end
