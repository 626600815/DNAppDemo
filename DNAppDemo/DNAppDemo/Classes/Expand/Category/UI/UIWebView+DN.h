//
//  UIWebView+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (DN) <UIWebViewDelegate>

/**
 *  加载网站
 *
 *  @param website 网址
 */
- (void)loadWebsite:(NSString *)website;

/**
 *  post加载网站
 *
 *  @param website 网址
 *  @param body    参数
 */
- (void)postWebsite:(NSString *)website body:(NSString *)body;

- (NSString *)getCurrentURL;/**<获取当前页面URL*/

- (NSString *)getTitle;/**<获取标题*/

- (NSArray *)getImgs;/**<获取图片*/

- (NSArray *)getOnClicks;/**<获取当前页面所有链接*/

- (NSString *)getContentWithID:(NSString *)tagID;/**<获取input标签中id为tagID的value*/


/**
 *  获取分享标题
 */
- (NSString *)getShareTitle;

/**
 *  获取分享图片
 */
- (NSString *)getShareImage;

/**
 *  获取分享内容
 */
- (NSString *)getSharecontent;

/**
 *  获取分享链接
 */
- (NSString *)getShareURL;


@end
