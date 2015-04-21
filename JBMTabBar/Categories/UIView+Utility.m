//
//  UIView+Utility.m
//  JBMCategories
//
//  Created by J Blair Metcalf on 4/19/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import "UIView+Utility.h"

@implementation UIView (Utility)

+ (void)animateView:(UIView *)view withEndAlpha:(CGFloat)endAlpha endScale:(CGFloat)endScale duration:(CGFloat)duration ease:(CGFloat)ease completion:(void (^)(void))completionBlock {
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:ease
                     animations:^{
                         view.alpha = endAlpha;
                         view.transform = CGAffineTransformScale(CGAffineTransformIdentity, endScale, endScale);
                     }
                     completion:^(BOOL finished) {
                         if (completionBlock != nil) {
                             completionBlock();
                         }
                     }];
}

+ (void)setView:(UIView *)view width:(CGFloat)width {
    CGRect viewFrame = view.frame;
    viewFrame.size.width = width;
    view.frame = viewFrame;
}

+ (void)setView:(UIView *)view height:(CGFloat)height {
    CGRect viewFrame = view.frame;
    viewFrame.size.height = height;
    view.frame = viewFrame;
}

+ (void)setView:(UIView *)view x:(CGFloat)x {
    CGRect viewFrame = view.frame;
    viewFrame.origin.x = x;
    view.frame = viewFrame;
}

+ (void)setView:(UIView *)view y:(CGFloat)y {
    CGRect viewFrame = view.frame;
    viewFrame.origin.y = y;
    view.frame = viewFrame;
}

@end
