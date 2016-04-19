//
//  UINavigationItem+DN.m
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UINavigationItem+DN.h"
#import <objc/runtime.h>

static void *ANLoaderPositionAssociationKey = &ANLoaderPositionAssociationKey;
static void *ANSubstitutedViewAssociationKey = &ANSubstitutedViewAssociationKey;

@implementation UINavigationItem (DN)

- (void)startAnimatingAt:(ANNavBarLoaderPosition)position {
    [self stopAnimating];
    objc_setAssociatedObject(self, ANLoaderPositionAssociationKey, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIActivityIndicatorView* loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    switch (position) {
        case ANNavBarLoaderPositionLeft:
            objc_setAssociatedObject(self, ANSubstitutedViewAssociationKey, self.leftBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.leftBarButtonItem.customView = loader;
            break;
            
        case ANNavBarLoaderPositionCenter:
            objc_setAssociatedObject(self, ANSubstitutedViewAssociationKey, self.titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.titleView = loader;
            break;
            
        case ANNavBarLoaderPositionRight:
            objc_setAssociatedObject(self, ANSubstitutedViewAssociationKey, self.rightBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.rightBarButtonItem.customView = loader;
            break;
    }
    
    [loader startAnimating];
}

- (void)stopAnimating {
    NSNumber* positionToRestore = objc_getAssociatedObject(self, ANLoaderPositionAssociationKey);
    id componentToRestore = objc_getAssociatedObject(self, ANSubstitutedViewAssociationKey);
    if (positionToRestore) {
        switch (positionToRestore.intValue) {
            case ANNavBarLoaderPositionLeft:
                self.leftBarButtonItem.customView = componentToRestore;
                break;
                
            case ANNavBarLoaderPositionCenter:
                self.titleView = componentToRestore;
                break;
                
            case ANNavBarLoaderPositionRight:
                self.rightBarButtonItem.customView = componentToRestore;
                break;
        }
    }
    
    objc_setAssociatedObject(self, ANLoaderPositionAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, ANSubstitutedViewAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lockRightItem:(BOOL)lock {
    NSArray *rightBarItems = self.rightBarButtonItems;
    if (rightBarItems  && [rightBarItems count]>0) {
        [rightBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIBarButtonItem class]] ||
                [obj isMemberOfClass:[UIBarButtonItem class]])
            {
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)obj;
                barButtonItem.enabled = !lock;
            }
        }];
    }
}

- (void)lockLeftItem:(BOOL)lock {
    NSArray *leftBarItems = self.leftBarButtonItems;
    if (leftBarItems  && [leftBarItems count]>0) {
        [leftBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIBarButtonItem class]] ||
                [obj isMemberOfClass:[UIBarButtonItem class]])
            {
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)obj;
                barButtonItem.enabled = !lock;
            }
        }];
    }
}

+ (void)load {
    // left
    [self swizzle:@selector(leftBarButtonItem)];
    [self swizzle:@selector(setLeftBarButtonItem:animated:)];
    [self swizzle:@selector(leftBarButtonItems)];
    [self swizzle:@selector(setLeftBarButtonItems:animated:)];
    
    // right
    [self swizzle:@selector(rightBarButtonItem)];
    [self swizzle:@selector(setRightBarButtonItem:animated:)];
    [self swizzle:@selector(rightBarButtonItems)];
    [self swizzle:@selector(setRightBarButtonItems:animated:)];
}

+ (void)swizzle:(SEL)selector {
    NSString *name = [NSString stringWithFormat:@"swizzled_%@", NSStringFromSelector(selector)];
    
    Method m1 = class_getInstanceMethod(self, selector);
    Method m2 = class_getInstanceMethod(self, NSSelectorFromString(name));
    
    method_exchangeImplementations(m1, m2);
}

#pragma mark - Global
+ (CGFloat)systemMargin {
    return 16; // iOS 7+
}

#pragma mark - Spacer
- (UIBarButtonItem *)spacerForItem:(UIBarButtonItem *)item withMargin:(CGFloat)margin {
    UIBarButtonSystemItem type = UIBarButtonSystemItemFixedSpace;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:type target:self action:nil];
    spacer.width = margin - [self.class systemMargin];
    if (!item.customView) {
        spacer.width += 8; // a margin of private class `UINavigationButton` is different from custom view
    }
    return spacer;
}

- (UIBarButtonItem *)leftSpacerForItem:(UIBarButtonItem *)item {
    return [self spacerForItem:item withMargin:self.leftMargin];
}

- (UIBarButtonItem *)rightSpacerForItem:(UIBarButtonItem *)item {
    return [self spacerForItem:item withMargin:self.rightMargin];
}

#pragma mark - Margin

- (CGFloat)leftMargin {
    NSNumber *value = objc_getAssociatedObject(self, @selector(leftMargin));
    return value ? value.floatValue : [self.class systemMargin];
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    objc_setAssociatedObject(self, @selector(leftMargin), @(leftMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.leftBarButtonItems = self.leftBarButtonItems;
}

- (CGFloat)rightMargin {
    NSNumber *value = objc_getAssociatedObject(self, @selector(rightMargin));
    return value ? value.floatValue : [self.class systemMargin];
}

- (void)setRightMargin:(CGFloat)rightMargin {
    objc_setAssociatedObject(self, @selector(rightMargin), @(rightMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.rightBarButtonItems = self.rightBarButtonItems;
}


#pragma mark - Original Bar Button Items
- (NSArray *)originalLeftBarButtonItems {
    return objc_getAssociatedObject(self, @selector(originalLeftBarButtonItems));
}

- (void)setOriginalLeftBarButtonItems:(NSArray *)items {
    objc_setAssociatedObject(self, @selector(originalLeftBarButtonItems), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)originalRightBarButtonItems {
    return objc_getAssociatedObject(self, @selector(originalRightBarButtonItems));
}

- (void)setOriginalRightBarButtonItems:(NSArray *)items {
    objc_setAssociatedObject(self, @selector(originalRightBarButtonItems), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Bar Button Item
- (UIBarButtonItem *)swizzled_leftBarButtonItem {
    return self.originalLeftBarButtonItems.firstObject;
}

- (void)swizzled_setLeftBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    if (!item) {
        [self setLeftBarButtonItems:nil animated:animated];
    } else {
        [self setLeftBarButtonItems:@[item] animated:animated];
    }
}

- (UIBarButtonItem *)swizzled_rightBarButtonItem {
    return self.originalRightBarButtonItems.firstObject;
}

- (void)swizzled_setRightBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    if (!item) {
        [self setRightBarButtonItems:nil animated:animated];
    } else {
        [self setRightBarButtonItems:@[item] animated:animated];
    }
}

#pragma mark - Bar Button Items
- (NSArray *)swizzled_leftBarButtonItems {
    return self.originalLeftBarButtonItems;
}

- (void)swizzled_setLeftBarButtonItems:(NSArray *)items animated:(BOOL)animated {
    if (items.count) {
        self.originalLeftBarButtonItems = items;
        UIBarButtonItem *spacer = [self leftSpacerForItem:items.firstObject];
        NSArray *itemsWithMargin = [@[spacer] arrayByAddingObjectsFromArray:items];
        [self swizzled_setLeftBarButtonItems:itemsWithMargin animated:animated];
    } else {
        self.originalLeftBarButtonItems = nil;
        [self swizzled_setLeftBarButtonItem:nil animated:animated];
    }
}

- (NSArray *)swizzled_rightBarButtonItems {
    return self.originalRightBarButtonItems;
}

- (void)swizzled_setRightBarButtonItems:(NSArray *)items animated:(BOOL)animated {
    if (items.count) {
        self.originalRightBarButtonItems = items;
        UIBarButtonItem *spacer = [self rightSpacerForItem:items.firstObject];
        NSArray *itemsWithMargin = [@[spacer] arrayByAddingObjectsFromArray:items];
        [self swizzled_setRightBarButtonItems:itemsWithMargin animated:animated];
    } else {
        self.originalRightBarButtonItems = nil;
        [self swizzled_setRightBarButtonItem:nil animated:animated];
    }
}

@end