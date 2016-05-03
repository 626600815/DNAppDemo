//
//  SecondServices.m
//  DNAppDemo
//
//  Created by mainone on 16/5/3.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "SecondServices.h"

@implementation SecondServices

+ (void)requestListInfo:(void (^)(NSDictionary *listinfoDic))infoDic {
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"HomeListData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    infoDic(rootDict);
}

@end
