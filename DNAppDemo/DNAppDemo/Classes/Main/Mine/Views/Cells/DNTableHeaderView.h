//
//  DNTableHeaderView.h
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNTableHeaderView : NSObject

@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,retain) UIView* view;

- (void)stretchHeaderForTableView:(UITableView*)tableView
                         withView:(UIView*)view
                         subViews:(UIView*)subview;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

- (void)resizeView;

@end
