//
//  FunctionView.h
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^functionBlock)(NSString *functionID);

@interface FunctionView : UIView

@property (nonatomic, copy) functionBlock block;
@property (nonatomic, strong) NSMutableArray *functionArray;

@end


/*
 CGFloat functionViewHeight = SCREEM_WIDTH*2/5 +5;
 FunctionView *functionView = [[FunctionView alloc] initWithFrame:CGRectMake(0, 200, SCREEM_WIDTH, functionViewHeight)];
 [self.view addSubview:functionView];
 [SecondServices requestListInfo:^(NSDictionary *listinfoDic) {
 functionView.functionArray = listinfoDic[@"function"];
 }];
 
 functionView.block = ^(NSString *functionID) {
 NSLog(@"点击ID是：%@",functionID);
 };

 */