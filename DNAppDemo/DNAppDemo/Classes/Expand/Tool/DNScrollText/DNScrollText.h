//
//  DNScrollText.h
//  DNAppDemo
//
//  Created by mainone on 16/4/29.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNScrollText : UIView

//标题
@property (nonatomic, strong) NSString *text;
//滚动一圈的时间, 默认是标题长度的1/3
@property (nonatomic, assign) NSTimeInterval time;
//字体,默认是17号字
@property (nonatomic, strong) UIFont *font;
//字体颜色,默认是白色
@property (nonatomic, strong) UIColor *colorText;
//开始动画,默认是YES
@property (nonatomic, assign, getter=isStart) BOOL start;

@end
