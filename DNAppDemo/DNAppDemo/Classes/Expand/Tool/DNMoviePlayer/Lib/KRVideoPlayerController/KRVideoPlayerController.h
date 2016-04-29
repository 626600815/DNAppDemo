//
//  KRVideoPlayerController.h
//  KRKit
//
//  Created by aidenluo on 5/23/15.
//  Copyright (c) 2015 36kr. All rights reserved.
//

@import MediaPlayer;

@class KRVideoPlayerController;

@protocol KRVideoPlayerControllerDelegate <NSObject>

@optional
//满屏
- (void)fullScreen;
//小屏
- (void)shrinkScreen;

@end

@interface KRVideoPlayerController : MPMoviePlayerController

@property (nonatomic, assign) id<KRVideoPlayerControllerDelegate>delegate;

@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
@property (nonatomic, assign) CGRect frame;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)showInWindow;
- (void)showInView:(UIView *)view;
- (void)dismiss;

@end