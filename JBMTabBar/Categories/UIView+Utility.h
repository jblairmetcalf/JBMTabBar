//
//  UIView+Utility.h
//  JBMCategories
//
//  Created by J Blair Metcalf on 4/19/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utility)

+ (void)animateView:(UIView *)view withEndAlpha:(CGFloat)endAlpha endScale:(CGFloat)endScale duration:(CGFloat)duration ease:(CGFloat)ease completion:(void (^)(void))completionBlock;
+ (void)setView:(UIView *)view width:(CGFloat)width;
+ (void)setView:(UIView *)view height:(CGFloat)height;
+ (void)setView:(UIView *)view x:(CGFloat)x;
+ (void)setView:(UIView *)view y:(CGFloat)y;

@end
