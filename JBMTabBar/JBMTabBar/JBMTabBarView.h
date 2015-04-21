//
//  JBMTabBar.h
//  JBMTabBar
//
//  Created by J Blair Metcalf on 4/20/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Be sure to set automaticallyAdjustsScrollViewInsets to NO in the UIViewController,
 * or it will adjust the UIScrollView contentInset
 *
 * self.automaticallyAdjustsScrollViewInsets = NO;
 */
@protocol JBMTabBarControllerDelegate

- (void)tabBar:(id)tabBar didSelectIndex:(NSUInteger)index;

@end

@interface JBMTabBarView : UIView

typedef NS_ENUM(NSInteger, JBMTabBarAlignment) {
    JBMTabBarAlignmentLeft,
    JBMTabBarAlignmentRight,
    JBMTabBarAlignmentCenter,
    JBMTabBarAlignmentFull,
    JBMTabBarAlignmentScroll
};

- (instancetype)initWithFrame:(CGRect)frame
                 buttonTitles:(NSArray *)buttonTitles
                  buttonWidth:(CGFloat)buttonWidth
                   buttonFont:(UIFont *)buttonFont
             contentAlignment:(JBMTabBarAlignment)contentAlignment
              normalTextColor:(UIColor *)normalTextColor
            selectedTextColor:(UIColor *)selectedTextColor
        normalBackgroundColor:(UIColor *)normalBackgroundColor
      selectedBackgroundColor:(UIColor *)selectedBackgroundColor
            bottomBorderColor:(UIColor *)bottomBorderColor
            animationDuration:(CGFloat)animationDuration
             animateIndicator:(BOOL)animateIndicator
               indicatorInset:(CGFloat)indicatorInset
              indicatorHeight:(CGFloat)indicatorHeight;

@property (nonatomic) NSInteger index;
@property (nonatomic) CGFloat scrollPercent;
@property (nonatomic, weak) id <JBMTabBarControllerDelegate>delegate;

@end
