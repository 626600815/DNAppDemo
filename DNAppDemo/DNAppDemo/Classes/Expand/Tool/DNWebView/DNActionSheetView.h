//
//  DNActionSheetView.h
//  distribution
//
//  Created by mainone on 15/12/14.
//  Copyright © 2015年 mainone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNActionSheetView;

@protocol DNActionSheetViewDelegate <NSObject>

@optional

- (void)clickButtonType:(NSInteger)index;

@end

@interface DNActionSheetView : UIView

@property (nonatomic, assign)id <DNActionSheetViewDelegate>delegate;

@end
