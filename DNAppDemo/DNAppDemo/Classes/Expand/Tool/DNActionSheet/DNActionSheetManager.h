//
//  DNActionSheetManager.h
//  DNAppDemo
//
//  Created by mainone on 16/4/22.
//  Copyright © 2016年 wjn. All rights reserved.
//  https://github.com/626600815/DNActionSheet

#import <Foundation/Foundation.h>

typedef void (^DNClickIndex) (NSInteger index);
typedef void (^DNSelectImage) (UIImage *image);
typedef void (^DNBlock) ();


@interface DNActionSheetManager : NSObject

+ (DNActionSheetManager *)shareActionSheet;

/**
 *  选取图片（相机或相册）
 *
 *  @param VC    当前所在的Controller
 *  @param image 返回的图片
 */
- (void)showImagePickerWithVC:(UIViewController *)VC selectImage:(DNSelectImage)image cancel:(DNBlock)cancel;

/**
 *  账号注销样式
 *
 *  @param index 点击的index
 */
- (void)showLogoutWithIndex:(DNClickIndex)index;

@end
