//
//  SettingViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "SettingViewController.h"
#import "MainControllerManage.h"
#import "DNActionSheetManager.h"
#import "KRVideoPlayerController.h"
#import "DNScrollText.h"

#define videoURL @"http://krtv.qiniudn.com/150522nextapp"


@interface SettingViewController () <KRVideoPlayerControllerDelegate>

@property (nonatomic,strong) KRVideoPlayerController *videoController;

@property (nonatomic, assign) BOOL isHiddenStatusBar;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(selectImage)];
    self.navigationItem.rightMargin = 10;
    
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    //加一个滚动文字
    DNScrollText *scrollText = [[DNScrollText alloc] initWithFrame:CGRectMake(20, width*(9.0/16.0)+80, width - 40, 50)];
    scrollText.text = @"本视频用到的三方库是KRVideoPlayerController，这个库还是很好用的，给个赞！";
    [self.view addSubview:scrollText];
    
    //加载一个视频
    self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, width, width*(9.0/16.0))];
    self.videoController.delegate = self;
    self.videoController.contentURL = [NSURL URLWithString:videoURL];
    [self.videoController showInView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.videoController play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.videoController pause];
}


#pragma mark - KRVideoPlayerControllerDelegate
//满屏
- (void)fullScreen {
    DNLog(@"我全屏显示了");
    [self.navigationController.navigationBar RsetTranslationY:-64];
    [self hideStatusBar];
}

//小屏
- (void)shrinkScreen {
    DNLog(@"回到原来位置");
     [self.navigationController.navigationBar RsetTranslationY:0];
    [self showStatusBar];
}

#pragma mark - Method
- (void)selectImage {
    [[DNActionSheetManager shareActionSheet] showImagePickerWithVC:self selectImage:^(UIImage *image) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    } cancel:^{
        DNLog(@"取消了");
    }];
}

//处理状态栏显示隐藏
- (BOOL)prefersStatusBarHidden {
    return self.isHiddenStatusBar;
}

- (void)showStatusBar {
    self.isHiddenStatusBar = NO;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideStatusBar {
    self.isHiddenStatusBar = YES;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self setNeedsStatusBarAppearanceUpdate];
    }
}
                          
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
