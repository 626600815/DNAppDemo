//
//  FourPictureView.h
//  DNAppDemo
//
//  Created by mainone on 16/5/10.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PictureBlock)(NSString *PictureID);


@interface FourPictureView : UIView

@property (nonatomic, copy) PictureBlock block;

@property (nonatomic, strong) NSMutableArray *picArray;

@end
