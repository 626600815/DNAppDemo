//
//  DNWebViewController.h
//  distribution
//
//  Created by mainone on 15/12/14.
//  Copyright © 2015年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "DNBaseViewController.h"

@class DNWebViewController;

@protocol DNWebViewControllerDelegate <NSObject>

@optional

- (void)webView:(DNWebViewController *)webView didStartLoadingURL:(NSURL *)URL;
- (void)webView:(DNWebViewController *)webView didFinishLoadingURL:(NSURL *)URL;
- (void)webView:(DNWebViewController *)webView didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)menuBtnClick;

@end


@interface DNWebViewController : DNBaseViewController <WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate>

@property (nonatomic, weak) id <DNWebViewControllerDelegate> delegate;

//不同系统调用不同的网页加载控件
@property (nonatomic, strong) WKWebView *wkWebView;//iOS8之后
@property (nonatomic, strong) UIWebView *uiWebView;

//加载进度条
@property (nonatomic, strong) UIProgressView *progressView;

//加载不同形式的网页
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadURL:(NSURL *)URL;
- (void)loadURLString:(NSString *)URLString;
- (void)loadHTMLString:(NSString *)HTMLString;

@end

/*
    记得加webkit.framework
 */
