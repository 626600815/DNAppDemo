//
//  UIView+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIView+DN.h"
#import <objc/runtime.h>

#define SCREEN_H    ([[UIScreen mainScreen] bounds].size.height)
#define BottomRect CGRectMake(self.frame.origin.x, SCREEN_H, self.frame.size.width, self.frame.size.height)


static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;
static char kActionHandlerSwipeBlockKey;
static char kActionHandlerSwipeGestureKey;

@implementation UIView (DN)

-(CGSize)size{
    return self.frame.size;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setSize:(CGSize)size animated:(BOOL)animated{
    CGRect frame = self.frame;
    frame.size = size;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setSize:(CGSize)size animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size = size;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setSize:(CGSize)size animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size = size;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGPoint)origin{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated{
    CGRect frame = self.frame;
    frame.origin = origin;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }];
    }else{
        self.frame = frame;
    }
}
-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin = origin;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setOrigin:(CGPoint)origin animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin = origin;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setX:(CGFloat)x animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        }];
    }else{
        self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    
}

-(void)setX:(CGFloat)x animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.x = x;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setX:(CGFloat)x animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.x = x;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

-(void)setY:(CGFloat)y animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
        }];
    }else{
        self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
    }
}

-(void)setY:(CGFloat)y animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.y= y;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setY:(CGFloat)y animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.origin.y = y;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

-(void)setWidth:(CGFloat)width animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
        }];
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    }
}

-(void)setWidth:(CGFloat)width animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.width = width;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setWidth:(CGFloat)width animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.width = width;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}


-(CGFloat)height{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

-(void)setHeight:(CGFloat)height animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
        }];
    }else{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    }
}

-(void)setHeight:(CGFloat)height animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.height = height;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

-(void)setHeight:(CGFloat)height animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion{
    CGRect frame = self.frame;
    frame.size.height = height;
    if (animated) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
        }completion:^(BOOL finished) {
            completion(finished);
        }];
    }else{
        self.frame = frame;
    }
}

- (void)addTapActionWithBlock:(GestureActionBlock)block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)addLongPressActionWithBlock:(GestureActionBlock)block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)addSwipeWithDirection:(UISwipeGestureRecognizerDirection)direction Block:(GestureActionBlock)block {
    UISwipeGestureRecognizer * gesture = objc_getAssociatedObject(self, &kActionHandlerSwipeGestureKey);
    gesture.direction = direction;
    if (!gesture) {
        gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForSwipeGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerSwipeGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerSwipeBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForSwipeGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerSwipeBlockKey);
        if (block) {
            block(gesture);
        }
    }
}


-(void)removeGestureRecognizers{
    if (self.gestureRecognizers.count == 0)return;
    
    while (self.gestureRecognizers.count != 0) {
        UITapGestureRecognizer * tap = [self.gestureRecognizers objectAtIndex:0];
        [self removeGestureRecognizer:tap];
    }
}


- (UIView *)getViewWithXibName:(NSString *)name withIndex:(NSInteger)index {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:name owner:self options:nil];
    UIView *tmpCustomView = [nib objectAtIndex:index];
    return tmpCustomView;
}

- (UIViewController *)getSuperViewController {
    UIViewController *superVC = nil;
    id temp = nil;
    UIView *tempView = self;
    do {
        tempView = tempView.superview;
        temp = tempView.nextResponder;
        superVC = temp;
    } while (![temp isKindOfClass:[UIViewController class]]);
    
    return superVC;
}

- (void)addEffectWithBorderColor:(UIColor*)borderColor borderWidth:(float)borderWidth {
    self.layer.borderColor = [borderColor CGColor];
    self.layer.borderWidth = borderWidth;
}

- (void)addEffectWithShadowRadius:(float)radius shadowOffset:(CGSize)offset shadowOpacity:(float)opacity shadowColor:(UIColor*)shadowColor {
    if (self.clipsToBounds)self.clipsToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath =[UIBezierPath bezierPathWithRect:self.bounds].CGPath;//防止卡顿
}


// 模糊效果
- (void)addBlurwithAlpha:(float)alpha {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *test = [[UIVisualEffectView alloc] initWithEffect:effect];
    test.frame = self.bounds;
    test.alpha = alpha;
    [self addSubview:test];
}


- (void)addMotionEffectWithMinRelative:(float)minRel maxRelative:(float)maxRel EffectType:(UIInterpolatingMotionEffectType)effectType keyPath:(NSString *)keyPath {
    UIInterpolatingMotionEffect * xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:keyPath type:effectType];
    xEffect.minimumRelativeValue =  [NSNumber numberWithFloat:minRel];
    xEffect.maximumRelativeValue = [NSNumber numberWithFloat:maxRel];
    [self addMotionEffect:xEffect];
}


#pragma mark - 底部出现动画
- (void)showFromBottom {
    CGRect rect = self.frame;
    self.frame = BottomRect;
    [self executeAnimationWithFrame:rect completeBlock:nil];
}

#pragma mark - 底部消失动画
- (void)dismissToBottomWithCompleteBlock:(void(^)())completeBlock {
    [self executeAnimationWithFrame:BottomRect completeBlock:completeBlock];
}

#pragma mark - 背景浮现动画
- (void)emerge {
    self.alpha = 0.0;
    [self executeAnimationWithAlpha:0.2 completeBlock:nil];
}

#pragma mark - 背景淡去动画
- (void)fake {
    [self executeAnimationWithAlpha:0.f completeBlock:nil];
}

#pragma mark - 执行动画
- (void)executeAnimationWithAlpha:(CGFloat)alpha completeBlock:(void(^)())completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = alpha;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

- (void)executeAnimationWithFrame:(CGRect)rect completeBlock:(void(^)())completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

#pragma mark - 按钮震动动画
- (void)startSelectedAnimation {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    ani.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 0.4;
    [self.layer addAnimation:ani forKey:@"transformAni"];
}

/* 9.摇摆动画 */
- (void)shakeView {
    // 创建关键帧动画类
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    // 设置每个关键帧的值对象的数组
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)],
                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    // 设置是否自动翻转
    shake.autoreverses = YES;
    // 设置重复次数
    shake.repeatCount = 2.0f;
    // 设置间隔时间
    shake.duration = 0.07f;
    // 添加动画
    [self.layer addAnimation:shake
                      forKey:@"Shake"];
}

/* 10.脉冲动画 */
- (void)pulseViewWithTime:(CGFloat)seconds {
    [self pulseViewWithDuration:seconds];
}

- (void)pulseViewWithDuration:(CGFloat)duration {
    [UIView animateWithDuration:duration / 6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    } completion:^(BOOL finished) {
        if(finished)
        {
            [UIView animateWithDuration:duration / 6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            } completion:^(BOOL finished) {
                if(finished)
                {
                    [UIView animateWithDuration:duration / 6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    } completion:^(BOOL finished) {
                        if(finished)
                        {
                            [UIView animateWithDuration:duration / 6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            } completion:^(BOOL finished) {
                                if(finished)
                                {
                                    [UIView animateWithDuration:duration / 6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    } completion:^(BOOL finished) {
                                        if(finished)
                                        {
                                            [UIView animateWithDuration:duration / 6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            } completion:nil];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}


@end

