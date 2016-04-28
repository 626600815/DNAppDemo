//
//  TypeButtonCell.h
//  MobileApp
//
//  Created by mainone on 16/2/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TypeButtonCell;

@protocol TypeButtonCellDelegate <NSObject>

@optional

- (void)clickButtonWithName:(NSString *)name;

@end

@interface TypeButtonCell : UICollectionViewCell

@property (nonatomic, assign) id <TypeButtonCellDelegate>delegete;

@property (nonatomic, strong) UIButton *button;/**<按钮*/
@property (nonatomic, strong) NSString *titleName;/**<名称*/
@property (nonatomic, strong) NSString *imageName;/**<图片*/

@end
