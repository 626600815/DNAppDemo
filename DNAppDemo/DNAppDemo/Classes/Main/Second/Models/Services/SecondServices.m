//
//  SecondServices.m
//  DNAppDemo
//
//  Created by mainone on 16/5/3.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "SecondServices.h"

#define homeUrl @""

@implementation SecondServices

+ (void)requestListInfo:(void (^)(NSDictionary *listinfoDic))infoDic {
    //模拟加载延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"HomeListData" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        infoDic(rootDict);
    });
    
    NSString *getUrl = [NSString stringWithFormat:@"%@/appservice/distributioninterface/indexapp",DNHostURLStr];
    [DNNetworking getWithURLString:getUrl success:^(id obj) {
        NSLog(@"我获得的home数据---->%@",obj);
        
    } failure:^(NSError *error) {
        
    }];
   
}

@end
