//
//  UILayoutGuide+MASAdditions.m
//  Masonry LayoutGuide Extension
//
//  Created by Hiuson on 2020/8/31.
//  Copyright © 2020 Hiuson. All rights reserved.
//

#import "UILayoutGuide+MASAdditions.h"
#import "MASGuideConstraintMaker.h"
#import <objc/runtime.h>

@implementation UILayoutGuide (MASAdditions)

- (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *))block {
    MASConstraintMaker *constraintMaker = [[MASGuideConstraintMaker alloc] initWithView:self.owningView item:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *))block {
    MASConstraintMaker *constraintMaker = [[MASGuideConstraintMaker alloc] initWithView:self.owningView item:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block {
    MASConstraintMaker *constraintMaker = [[MASGuideConstraintMaker alloc] initWithView:self.owningView item:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (MASViewAttribute *)mas_left {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeLeft];
}

- (MASViewAttribute *)mas_top {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeTop];
}

- (MASViewAttribute *)mas_right {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeRight];
}

- (MASViewAttribute *)mas_bottom {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)mas_leading {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeLeading];
}

- (MASViewAttribute *)mas_trailing {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (MASViewAttribute *)mas_width {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeWidth];
}

- (MASViewAttribute *)mas_height {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeHeight];
}

- (MASViewAttribute *)mas_centerX {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (MASViewAttribute *)mas_centerY {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (MASViewAttribute *)mas_baseline {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (MASViewAttribute *(^)(NSLayoutAttribute))mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:attr];
    };
}

- (MASViewAttribute *)mas_firstBaseline {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (MASViewAttribute *)mas_lastBaseline {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (MASViewAttribute *)mas_leftMargin {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (MASViewAttribute *)mas_rightMargin {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (MASViewAttribute *)mas_topMargin {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (MASViewAttribute *)mas_bottomMargin {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (MASViewAttribute *)mas_leadingMargin {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (MASViewAttribute *)mas_trailingMargin {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (MASViewAttribute *)mas_centerXWithinMargins {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (MASViewAttribute *)mas_centerYWithinMargins {
    return [[MASViewAttribute alloc] initWithView:self.owningView item:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;

    MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MAS_VIEW *firstViewSuperview = self.owningView;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
