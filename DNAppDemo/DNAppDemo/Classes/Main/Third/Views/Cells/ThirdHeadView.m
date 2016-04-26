//
//  ThirdHeadView.m
//  DNAppDemo
//
//  Created by mainone on 16/4/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ThirdHeadView.h"

@interface ThirdHeadView() {
    UIButton *_bgButton;
    UILabel *_numLabel;
}
@end

@implementation ThirdHeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView {
    static NSString *headIdentifier = @"header";
    
    ThirdHeadView *headView = (ThirdHeadView *)[tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[ThirdHeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:numLabel];
        _numLabel = numLabel;
    }
    return self;
}

- (void)headBtnClick {
    _friendGroup.opened = !_friendGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}

- (void)setFriendGroup:(FriendGroup *)friendGroup {
    _friendGroup = friendGroup;
    
    [_bgButton setTitle:friendGroup.name forState:UIControlStateNormal];
    _numLabel.text = [NSString stringWithFormat:@"%d/%d", friendGroup.online, friendGroup.friends.count];
}

- (void)didMoveToSuperview {
    _bgButton.imageView.transform = _friendGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    _numLabel.frame = CGRectMake(self.frame.size.width - 70, 0, 60, self.frame.size.height);
}

@end
