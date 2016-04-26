//
//  ThirdHeadView.h
//  DNAppDemo
//
//  Created by mainone on 16/4/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendGroup.h"

@protocol ThirdHeadViewDelegate <NSObject>

@optional
- (void)clickHeadView;

@end

@interface ThirdHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) FriendGroup *friendGroup;

@property (nonatomic, weak) id<ThirdHeadViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
