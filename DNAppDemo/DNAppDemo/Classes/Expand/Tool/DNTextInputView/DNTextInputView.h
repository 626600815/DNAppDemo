//
//  DNTextInputView.h
//  DNTextInputView
//
//  Created by mainone on 16/5/5.
//  Copyright © 2016年 wjn. All rights reserved.
//  https://github.com/626600815/DNTextInputView

#import <UIKit/UIKit.h>

typedef void (^textInputBlock)(NSString *text);

@interface DNTextInputView : UIView

+ (DNTextInputView *)shareInstance;

/**
 *  显示文本输入框
 *
 *  @param title 标题名称
 *  @param block 输入的内容
 */
- (void)showToVC:(UIViewController *)vc WithTitle:(NSString *)title inputBlock:(textInputBlock)block;

@end


/**
 使用方法
 在controller中添加代码 
 [[DNTextInputView shareInstance] showToVC:self WithTitle:@"你是谁" inputBlock:^(NSString *text) {
 NSLog(@"发送的内容：%@",text);
 }];
 
 */