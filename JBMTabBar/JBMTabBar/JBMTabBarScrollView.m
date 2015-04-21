//
//  JBMTabBarScrollView.m
//  JBMTabBar
//
//  Created by J Blair Metcalf on 4/20/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import "JBMTabBarScrollView.h"

@implementation JBMTabBarScrollView

#pragma mark - Override Methods

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIButton class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
