//
//  DNTableHeaderView.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNTableHeaderView.h"

@interface DNTableHeaderView() {
    CGRect initialFrame;
    CGFloat defaultViewHeight;
    CGRect saveFrame;
}
@end

@implementation DNTableHeaderView

@synthesize tableView = _tableView;
@synthesize view = _view;

- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view subViews:(UIView*)subview {
    _tableView                   = tableView;
    _view                        = view;

    initialFrame                 = _view.frame;
    defaultViewHeight            = initialFrame.size.height;

    saveFrame                    = _view.frame;
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView   = emptyTableHeaderView;
    [_tableView addSubview:_view];
    [_tableView addSubview:subview];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGRect f     = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame  = f;
    
    if(scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;

        initialFrame.origin.y    = - offsetY * 1;
        initialFrame.origin.x    = - offsetY / 2;

        initialFrame.size.width  = _tableView.frame.size.width + offsetY;
        initialFrame.size.height = defaultViewHeight + offsetY;

        _view.frame              = initialFrame;
    } else {
        [self resizeView];
    }
}

- (void)resizeView {
    initialFrame.size.width = _tableView.frame.size.width;
    _view.frame             = saveFrame;
}


@end
