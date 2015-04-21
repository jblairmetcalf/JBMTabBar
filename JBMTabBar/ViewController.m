//
//  ViewController.m
//  JBMTabBar
//
//  Created by J Blair Metcalf on 4/20/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import "ViewController.h"

#import "JBMTabBarView.h"

#import "UIView+Utility.h"
#import "UIColor+Utility.h"

@interface ViewController () <JBMTabBarControllerDelegate>

@property (nonatomic, strong) JBMTabBarView *leftAlignedTabBar;
@property (nonatomic, strong) JBMTabBarView *centerAlignedTabBar;
@property (nonatomic, strong) JBMTabBarView *rightAlignedTabBar;
@property (nonatomic, strong) JBMTabBarView *fullTabBar;
@property (nonatomic, strong) JBMTabBarView *scrollingTabBar;

@end

@implementation ViewController

#pragma mark - Override Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Be sure to set automaticallyAdjustsScrollViewInsets to NO in the UIViewController,
     * or it will adjust the UIScrollView contentInset
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.leftAlignedTabBar.index = 0;
    self.centerAlignedTabBar.index = 1;
    self.rightAlignedTabBar.index = 2;
    self.fullTabBar.index = 0;
    self.scrollingTabBar.index = 0;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateWidth];
}

- (void)updateWidth {
    CGFloat width = self.view.frame.size.width;
    [UIView setView:self.leftAlignedTabBar width:width];
    [UIView setView:self.centerAlignedTabBar width:width];
    [UIView setView:self.rightAlignedTabBar width:width];
    [UIView setView:self.fullTabBar width:width];
    [UIView setView:self.scrollingTabBar width:width];
}

#pragma mark - Delegate Methods

- (void)tabBar:(JBMTabBarView *)tabBar didSelectIndex:(NSUInteger)index {
    NSLog(@"tabBar: didSelectIndex: %li", index);
}

#pragma mark - Instantiation Methods

- (JBMTabBarView *)leftAlignedTabBar {
    if (!_leftAlignedTabBar) {
        _leftAlignedTabBar = [self tabBarWithFrame:CGRectMake(0.0f, 50.0f, self.view.frame.size.width, 44.0f) contentAlignment:JBMTabBarAlignmentLeft];
    }
    return _leftAlignedTabBar;
}

- (JBMTabBarView *)centerAlignedTabBar {
    if (!_centerAlignedTabBar) {
        _centerAlignedTabBar = [self tabBarWithFrame:CGRectMake(0.0f, 125.0f, self.view.frame.size.width, 44.0f) contentAlignment:JBMTabBarAlignmentCenter];
    }
    return _centerAlignedTabBar;
}

- (JBMTabBarView *)rightAlignedTabBar {
    if (!_rightAlignedTabBar) {
        _rightAlignedTabBar = [self tabBarWithFrame:CGRectMake(0.0f, 200.0f, self.view.frame.size.width, 44.0f) contentAlignment:JBMTabBarAlignmentRight];
    }
    return _rightAlignedTabBar;
}

- (JBMTabBarView *)fullTabBar {
    if (!_fullTabBar) {
        _fullTabBar = [self tabBarWithFrame:CGRectMake(0.0f, 275.0f, self.view.frame.size.width, 44.0f) contentAlignment:JBMTabBarAlignmentFull];
    }
    return _fullTabBar;
}

- (JBMTabBarView *)scrollingTabBar {
    if (!_scrollingTabBar) {
        _scrollingTabBar = [[JBMTabBarView alloc] initWithFrame:CGRectMake(0.0f, 350.0f, self.view.frame.size.width, 44.0f)
                                                    buttonTitles:@[@"LOREM", @"IPSUM", @"DOLOR", @"SIT", @"AMET", @"ELIT"]
                                                     buttonWidth:75.0f
                                                      buttonFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
                                                contentAlignment:JBMTabBarAlignmentScroll
                                                 normalTextColor:[UIColor grayColor]
                                               selectedTextColor:[UIColor colorWithHexString:@"#007aff"]
                                           normalBackgroundColor:[UIColor colorWithHexString:@"#f8f8f8"]
                                         selectedBackgroundColor:[UIColor colorWithHexString:@"#f8f8f8"]
                                               bottomBorderColor:[UIColor colorWithHexString:@"#acacac"]
                                               animationDuration:0.33f
                                                animateIndicator:YES
                                                  indicatorInset:16.0f
                                                 indicatorHeight:2.0f];
        _scrollingTabBar.delegate = self;
        [self.view addSubview:_scrollingTabBar];
    }
    return _scrollingTabBar;
}

#pragma mark - Private Methods

- (JBMTabBarView *)tabBarWithFrame:(CGRect)frame contentAlignment:(JBMTabBarAlignment)contentAlignment {
    JBMTabBarView *tabBar = [[JBMTabBarView alloc] initWithFrame:frame
                                                    buttonTitles:@[@"LOREM", @"IPSUM", @"DOLOR"]
                                                     buttonWidth:75.0f
                                                      buttonFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
                                                contentAlignment:contentAlignment
                                                 normalTextColor:[UIColor grayColor]
                                               selectedTextColor:[UIColor colorWithHexString:@"#007aff"]
                                           normalBackgroundColor:[UIColor colorWithHexString:@"#f8f8f8"]
                                         selectedBackgroundColor:[UIColor colorWithHexString:@"#f8f8f8"]
                                               bottomBorderColor:[UIColor colorWithHexString:@"#acacac"]
                                               animationDuration:0.33f
                                                animateIndicator:YES
                                                  indicatorInset:16.0f
                                                 indicatorHeight:2.0f];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
    return tabBar;
}

@end
