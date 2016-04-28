//
//  DNShareView.h
//  MobileApp
//
//  Created by mainone on 16/2/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNShareView : UIView

- (instancetype)initWithShare;

- (void)showInView:(UIView *)view;

//最好这些参数都设置一下,当缺少图片和内容地址的时候打开QQ失败
@property (nonatomic, strong) NSString *showImageUrl;/**<显示的图片*/
@property (nonatomic, strong) NSString *contentUrl;/**<内容地址*/
@property (nonatomic, strong) NSString *showtext;/**<分享的详情*/
@property (nonatomic, strong) NSString *myCopyUrl;/**<复制链接*/
@property (nonatomic, strong) NSString *erweimaUrl;/**<二维码地址*/
@property (nonatomic, strong) NSString *titleName;/**<标题名称*/

@end

/*
    用法:
 
 DNShareView *shareV = [[DNShareView alloc]initWithFrame:self.view.bounds];
 [shareV showInView:self.view];
 */