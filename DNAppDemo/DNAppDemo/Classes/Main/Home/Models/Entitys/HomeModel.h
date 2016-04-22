//
//  HomeModel.h
//  DNAppDemo
//
//  Created by mainone on 16/4/21.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeModel : NSObject


@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, copy) NSString *content;  //内容
@property (nonatomic, copy) NSString *username; //名字
@property (nonatomic, copy) NSString *time;     //时间
@property (nonatomic, copy) NSString *imageName;//图片。

@end
