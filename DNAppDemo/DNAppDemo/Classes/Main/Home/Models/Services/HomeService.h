//
//  HomeService.h
//  DNAppDemo
//
//  Created by mainone on 16/4/21.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"

typedef void (^DNListInfo)(NSArray *listArray);

@interface HomeService : NSObject

+ (void)requestHomeListInfo:(DNListInfo)infoArr;


@end
