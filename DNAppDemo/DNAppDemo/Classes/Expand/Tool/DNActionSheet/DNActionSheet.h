//
//  DNActionSheet.h
//  DNAppDemo
//
//  Created by mainone on 16/4/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNActionSheet;

@protocol DNActionSheetDelegate <NSObject>

@optional

- (void)actionSheetCancel:(DNActionSheet *)actionSheet;
- (void)actionSheet:(DNActionSheet *)sheet clickedButtonIndex:(NSInteger)buttonIndex;

@end

@interface DNActionSheet : UIView

@property (weak, nonatomic) id<DNActionSheetDelegate> delegate;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *cancelButtonTitle;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show;

- (void)hide;

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

- (void)setButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size atIndex:(int)index;

- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size;

@end
