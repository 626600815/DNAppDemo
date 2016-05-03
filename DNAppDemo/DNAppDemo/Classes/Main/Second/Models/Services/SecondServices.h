//
//  SecondServices.h
//  DNAppDemo
//
//  Created by mainone on 16/5/3.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondServices : NSObject

+ (void)requestListInfo:(void (^)(NSDictionary *listinfoDic))infoDic;

@end
