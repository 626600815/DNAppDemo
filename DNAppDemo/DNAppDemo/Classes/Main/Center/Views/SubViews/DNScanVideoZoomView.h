//
//  DNScanVideoZoomView.h
//  DNAppDemo
//
//  Created by mainone on 16/4/29.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNScanVideoZoomView : UIView

/**
 *  控件值变化
 */
@property (nonatomic, copy) void (^block)(float value);

- (void)setMaximunValue:(CGFloat)value;

@end
