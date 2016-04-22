//
//  HomeService.h
//  DNAppDemo
//
//  Created by mainone on 16/4/21.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

//typedef void (^DNListInfo)(NSArray *listArray);

@interface HomeService : NSObject

/**
 *  请求首页列表信息
 *
 *  @param infoArr 列表信息数组
 */
+ (void)requestHomeListInfo:(void (^)(NSArray *listArray))infoArr;


@end
