//
//  LoginViewController.h
//  DNAppDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, DNLoginType){
    DNLoginTypeSuccess,
    DNLoginTypeCancel
};

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

@optional

- (void)dismissWithtype:(DNLoginType)type withTabSelect:(NSInteger)index;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) id<LoginViewControllerDelegate>loginDelegate;

@end
