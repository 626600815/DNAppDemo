//
//  UIView+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (DN)

-(CGSize)size;
-(void)setSize:(CGSize)size;
-(void)setSize:(CGSize)size animated:(BOOL)animated;
-(void)setSize:(CGSize)size animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setSize:(CGSize)size animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGPoint)origin;
-(void)setOrigin:(CGPoint)origin;
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated;
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGFloat)x;
-(void)setX:(CGFloat)x;
-(void)setX:(CGFloat)x animated:(BOOL)animated;
-(void)setX:(CGFloat)x animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setX:(CGFloat)x animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;


-(CGFloat)y;
-(void)setY:(CGFloat)y;
-(void)setY:(CGFloat)y animated:(BOOL)animated;
-(void)setY:(CGFloat)y animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setY:(CGFloat)y animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGFloat)width;
-(void)setWidth:(CGFloat)width;
-(void)setWidth:(CGFloat)width animated:(BOOL)animated;
-(void)setWidth:(CGFloat)width animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setWidth:(CGFloat)width animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

-(CGFloat)height;
-(void)setHeight:(CGFloat)height;
-(void)setHeight:(CGFloat)height animated:(BOOL)animated;
-(void)setHeight:(CGFloat)height animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)setHeight:(CGFloat)height animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;


/**
 *  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(GestureActionBlock)block;
/**
 *  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;

/**
 *  添加侧滑手势
 *
 *  @param direction 侧滑方向
 *  @param block     代码块
 */
- (void)addSwipeWithDirection:(UISwipeGestureRecognizerDirection)direction Block:(GestureActionBlock)block;

/**
 *  移除所有手势
 */
-(void)removeGestureRecognizers;

/**
 *  从xib获取视图
 *
 *  @param name  xib名字
 *  @param index 视图编号
 *
 *  @return 视图
 */
-(UIView *)getViewWithXibName:(NSString *)name withIndex:(NSInteger)index;

/**
 *  获取视图的控制器
 *
 *  @return 控制器
 */
-(UIViewController *)getSuperViewController;

/**
 *  添加描边
 *
 *  @param borderColor 颜色
 *  @param borderWidth 大小
 */
-(void)addEffectWithBorderColor:(UIColor*)borderColor borderWidth:(float)borderWidth;

/**
 *  添加阴影
 *
 *  @param radius      阴影大小
 *  @param offset      便宜
 *  @param opacity     阴影透明度
 *  @param shadowColor 颜色
 */
-(void)addEffectWithShadowRadius:(float)radius shadowOffset:(CGSize)offset shadowOpacity:(float)opacity shadowColor:(UIColor*)shadowColor;

/**
 *  添加模糊效果
 *
 *  @param alpha 模糊程度 alpha越大越模糊
 */
- (void)addBlurwithAlpha:(float)alpha;

/**
 *  添加运动效果（类似home页的壁纸效果）
 *
 *  @param minRel     最小位移
 *  @param maxRel     最大位移
 *  @param effectType 位移方向（水平，垂直）
 *  @param keyPath    位移坐标（"center.x"，"center.y"）
 */
- (void)addMotionEffectWithMinRelative:(float)minRel maxRelative:(float)maxRel EffectType:(UIInterpolatingMotionEffectType)effectType keyPath:(NSString *)keyPath;

@end

