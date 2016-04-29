//
//  DetailViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DetailViewController.h"
#import "DNActionSheetView.h"

#define ActionSheetHeight 150

@interface DetailViewController () <DNWebViewControllerDelegate, DNActionSheetViewDelegate>

@property (nonatomic, strong) DNActionSheetView *actionSheet;
@property (nonatomic, strong) UIView *backView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.delegate = self;
    if (self.urlStr) {
        [self loadURLString:self.urlStr];
    }else{
        [self loadURLString:@"http://www.baidu.com"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (DNActionSheetView *)actionSheet {
    if (!_actionSheet) {
        _actionSheet = [[DNActionSheetView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, ActionSheetHeight)];
        _actionSheet.delegate = self;
        [self.view addSubview:self.actionSheet];
    }
    return _actionSheet;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:self.view.bounds];
        _backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backView.hidden = YES;
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
        [self.view addSubview:_backView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissBackView)];
        _backView.userInteractionEnabled = YES;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (void)menuBtnClick {
    self.backView.hidden = NO;
    if (self.actionSheet.y == self.view.frame.size.height) {
        [UIView animateWithDuration:.3 animations:^{
            self.actionSheet.y = self.view.frame.size.height - ActionSheetHeight;
        }];
    }else {
        [self dismissBackView];
    }
}

- (void)clickButtonType:(NSInteger)index {
    [self dismissBackView];
    if (index == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index == 1) {
        if ([WKWebView class]) {
            [self.wkWebView stopLoading];
            [self loadURLString:self.wkWebView.URL.absoluteString];
        }else {
            [self.uiWebView stopLoading];
            [self.uiWebView reload];
        }
    }
}

- (void)dismissBackView {
    self.backView.hidden = YES;
    [UIView animateWithDuration:.3 animations:^{
        self.actionSheet.y = self.view.height;
    } completion:^(BOOL finished) {
        [self.actionSheet removeFromSuperview];
        self.actionSheet = nil;
    }];
}


- (void)webView:(DNWebViewController *)webView didStartLoadingURL:(NSURL *)URL {
    DNLog(@"开始加载");
}

- (void)webView:(DNWebViewController *)webView didFinishLoadingURL:(NSURL *)URL {
    DNLog(@"结束加载");
}

- (void)webView:(DNWebViewController *)webView didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    DNLog(@"加载失败:%@",error);
}



@end
