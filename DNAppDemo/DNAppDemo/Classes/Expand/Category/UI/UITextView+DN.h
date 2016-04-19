//
//  UITextView+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (DN) <UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;
/**
 *  TextView添加提示语
 *
 *  @param placeHolder 提示语
 */
- (void)addPlaceHolder:(NSString *)placeHolder;

@end
