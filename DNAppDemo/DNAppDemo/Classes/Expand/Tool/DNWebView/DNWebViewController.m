//
//  DNWebViewController.m
//  distribution
//
//  Created by mainone on 15/12/14.
//  Copyright © 2015年 mainone. All rights reserved.
//

#import "DNWebViewController.h"
#import "DNActionSheetView.h"

static void *DNWebViewContext = &DNWebViewContext;

@interface DNWebViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, strong) UIPopoverController *actionPopoverController;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;
@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;



@end

@implementation DNWebViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        if([WKWebView class]) {
            self.wkWebView = [[WKWebView alloc] init];
        }else {
            self.uiWebView = [[UIWebView alloc] init];
        }
        self.externalAppPermissionAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"这网页试图打开外部应用。你确定你想要打开它吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor whiteColor];
    if(self.wkWebView) {
        [self.wkWebView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.wkWebView setNavigationDelegate:self];
        [self.wkWebView setUIDelegate:self];
        [self.wkWebView setMultipleTouchEnabled:YES];
        [self.wkWebView setAutoresizesSubviews:YES];
        [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
        [self.view addSubview:self.wkWebView];
        
        [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:DNWebViewContext];
        [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        
    }else if(self.uiWebView) {
        [self.uiWebView setFrame:self.view.bounds];
        [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.uiWebView setDelegate:self];
        [self.uiWebView setMultipleTouchEnabled:YES];
        [self.uiWebView setAutoresizesSubviews:YES];
        [self.uiWebView setScalesPageToFit:YES];
        [self.uiWebView.scrollView setAlwaysBounceVertical:YES];
        [self.view addSubview:self.uiWebView];
    }
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [self.progressView setProgressTintColor:[UIColor colorWithRed:72.0/255 green:118.0/255 blue:255.0/255 alpha:1.0]];
    [self.progressView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-self.progressView.frame.size.height, self.view.frame.size.width, self.progressView.frame.size.height)];
    [self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    
    [self createLeftRightItem];//导航栏按钮
}

- (void)createLeftRightItem {
    
    UIImage *menuImage = [UIImage imageNamed:@"webview_menu"];
    menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [menuBtn setTintColor:[UIColor darkGrayColor]];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 5);
    [menuBtn addTarget:self action:@selector(btnMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = menuItem;
}

//点击弹出菜单
- (void)btnMenu {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuBtnClick)]) {
        [self.delegate menuBtnClick];
    }
   
}

//重新返回事件
- (void)backBarButtonItemAction {
    if ([self.uiWebView canGoBack] || [self.wkWebView canGoBack]) {
        if ([self.uiWebView canGoBack]) {
            [self.uiWebView goBack];
        }else{
            [self.wkWebView goBack];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.uiWebView setDelegate:nil];
    [self.progressView removeFromSuperview];
}

#pragma mark - Public Interface
- (void)loadRequest:(NSURLRequest *)request {
    if(self.wkWebView) {
        [self.wkWebView loadRequest:request];
    }
    else if(self.uiWebView) {
        [self.uiWebView loadRequest:request];
    }
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    if(self.wkWebView) {
        [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
    }else if(self.uiWebView) {
        [self.uiWebView loadHTMLString:HTMLString baseURL:nil];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(webView == self.uiWebView) {
        if(![self externalAppRequiredToOpenURL:request.URL]) {
            self.uiWebViewCurrentURL = request.URL;
            self.uiWebViewIsLoading = YES;
            
            [self fakeProgressViewStartLoading];
            
            if([self.delegate respondsToSelector:@selector(webView:didStartLoadingURL:)]) {
                [self.delegate webView:self didStartLoadingURL:request.URL];
            }
            return YES;
        }else {
            [self launchExternalAppWithURL:request.URL];
            return NO;
        }
    }
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView == self.uiWebView) {
        if(!self.uiWebView.isLoading) {
            self.uiWebViewIsLoading = NO;
            [self fakeProgressBarStopLoading];
        }
        self.title = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if([self.delegate respondsToSelector:@selector(webView:didFinishLoadingURL:)]) {
            [self.delegate webView:self didFinishLoadingURL:self.uiWebView.request.URL];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if(webView == self.uiWebView) {
        if(!self.uiWebView.isLoading) {
            self.uiWebViewIsLoading = NO;
//            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" inDirectory:@"www"]];
//            [webView loadRequest:[NSURLRequest requestWithURL:url]];
            
            [self fakeProgressBarStopLoading];
        }
        if([self.delegate respondsToSelector:@selector(webView:didFailToLoadURL:error:)]) {
            [self.delegate webView:self didFailToLoadURL:self.uiWebView.request.URL error:error];
//            NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" inDirectory:@"www"];
//            NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                            encoding:NSUTF8StringEncoding
//                                                               error:nil];
//            [webView loadHTMLString:htmlCont baseURL:nil];
        }
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        if([self.delegate respondsToSelector:@selector(webView:didStartLoadingURL:)]) {
            [self.delegate webView:self didStartLoadingURL:self.wkWebView.URL];
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        self.title = self.wkWebView.title;
        if([self.delegate respondsToSelector:@selector(webView:didFinishLoadingURL:)]) {
            [self.delegate webView:self didFinishLoadingURL:self.wkWebView.URL];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(webView == self.wkWebView) {
        if([self.delegate respondsToSelector:@selector(webView:didFailToLoadURL:error:)]) {
            [self.delegate webView:self didFailToLoadURL:self.wkWebView.URL error:error];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(webView == self.wkWebView) {
        if([self.delegate respondsToSelector:@selector(webView:didFailToLoadURL:error:)]) {
            [self.delegate webView:self didFailToLoadURL:self.wkWebView.URL error:error];
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView == self.wkWebView) {
        
        NSURL *URL = navigationAction.request.URL;
        if(![self externalAppRequiredToOpenURL:URL]) {
            if(!navigationAction.targetFrame) {
                [self loadURL:URL];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
        }else if([[UIApplication sharedApplication] canOpenURL:URL]) {
            [self launchExternalAppWithURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - Estimated Progress KVO (WKWebView)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.wkWebView.title;
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Fake Progress Bar Control (UIWebView)
- (void)fakeProgressViewStartLoading {
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    if(!self.fakeProgressTimer) {
        self.fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading {
    if(self.fakeProgressTimer) {
        [self.fakeProgressTimer invalidate];
    }
    if(self.progressView) {
        [self.progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender {
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if([self.uiWebView isLoading]) {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if(self.progressView.progress < 0.95) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

#pragma mark - External App Support
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
    return ![validSchemes containsObject:URL.scheme];
}

- (void)launchExternalAppWithURL:(NSURL *)URL {
    self.URLToLaunchWithPermission = URL;
    if (![self.externalAppPermissionAlertView isVisible]) {
        [self.externalAppPermissionAlertView show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView == self.externalAppPermissionAlertView) {
        if(buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:self.URLToLaunchWithPermission];
        }
        self.URLToLaunchWithPermission = nil;
    }
}

#pragma mark - Dealloc
- (void)dealloc {
    [self.uiWebView setDelegate:nil];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    if ([self isViewLoaded]) {
        [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
        [self.wkWebView removeObserver:self forKeyPath:@"title"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
