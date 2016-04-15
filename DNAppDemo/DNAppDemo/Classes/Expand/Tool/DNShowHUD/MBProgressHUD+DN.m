//
//  MBProgressHUD+DN.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "MBProgressHUD+DN.h"

@interface MBProgressHUD ()

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation MBProgressHUD (DN)

+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.5f];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = (MBProgressHUD *)[view viewWithTag:1000002];
    if (HUD != nil) {
        if (HUD.labelText == text)
            return;
        else
            [HUD hide:YES];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tag = 1000002;
    hud.labelText = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.5f];
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (void)showIndicatorViewToView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[view viewWithTag:1001];
    if (activity != nil) {
        return;
    }
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    activityIndicatorView.tag                 = 1000001;
    activityIndicatorView.center              = view.center;
    activityIndicatorView.layer.cornerRadius  = 8;
    activityIndicatorView.layer.masksToBounds = YES;
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicatorView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.8]];
    [view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

+ (void)hideIndicatorViewInView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[view viewWithTag:1000001];
    [activity stopAnimating];
    [activity removeFromSuperview];
}

@end
