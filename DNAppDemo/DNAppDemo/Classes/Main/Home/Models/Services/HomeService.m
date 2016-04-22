//
//  HomeService.m
//  DNAppDemo
//
//  Created by mainone on 16/4/21.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "HomeService.h"
#import "HomeModel.h"

@implementation HomeService

+ (void)requestHomeListInfo:(DNListInfo)infoArr {
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"Home" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *feedDicts = rootDict[@"feed"];
    
    NSArray *listArray = [HomeModel mj_objectArrayWithKeyValuesArray:feedDicts];
    infoArr(listArray);
}

@end
