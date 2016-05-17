//
//  ListButton.m
//  DNAppDemo
//
//  Created by mainone on 16/5/11.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ListButton.h"

@implementation ListButton

//返回内容所占区域
-(CGRect)contentRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}
//返回标题所占区域
-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
}
//返回图片所占区域
-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height);
}

@end
