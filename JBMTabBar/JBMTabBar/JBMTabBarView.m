//
//  JBMTabBar.m
//  JBMTabBar
//
//  Created by J Blair Metcalf on 4/20/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import "JBMTabBarView.h"
#import "JBMTabBarScrollView.h"

#import "UIFont+Utility.h"
#import "UIView+Utility.h"

@interface JBMTabBarView ()

@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic) CGFloat buttonWidth;
@property (nonatomic, strong) UIFont *buttonFont;
@property (nonatomic) JBMTabBarAlignment contentAlignment;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *bottomBorderColor;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) BOOL animateIndicator;
@property (nonatomic) CGFloat indicatorInset;
@property (nonatomic) CGFloat indicatorHeight;

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic) CGFloat contentX;
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) BOOL animating;

@property (nonatomic, strong) JBMTabBarScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *indicatorInsetView;

@end

@implementation JBMTabBarView

#pragma mark - Override Methods

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
              indicatorHeight:(CGFloat)indicatorHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        _index = NSNotFound;
        
        if (contentAlignment == JBMTabBarAlignmentFull) {
            _buttonWidth = roundf(self.frame.size.width/buttonTitles.count);
        } else {
            _buttonWidth = buttonWidth;
        }
        
        _contentAlignment = contentAlignment;
        _buttonFont = buttonFont;
        _normalTextColor = normalTextColor;
        _selectedTextColor = selectedTextColor;
        _normalBackgroundColor = normalBackgroundColor;
        _selectedBackgroundColor = selectedBackgroundColor;
        _bottomBorderColor = bottomBorderColor;
        _animationDuration = animationDuration;
        _animateIndicator = animateIndicator;
        _indicatorInset = indicatorInset;
        _indicatorHeight = indicatorHeight;
        
        self.backgroundColor = self.normalBackgroundColor;
        
        [self setButtonTitles:buttonTitles];
        
        self.indicatorInsetView.hidden = NO;
    }
    return self;
}

#pragma mark - Public Methods

- (void)setScrollPercent:(CGFloat)scrollPercent {
    if (!self.animating || self.animateIndicator) {
        CGFloat width = self.contentWidth-self.indicatorView.frame.size.width;
        CGFloat x = self.contentX+(scrollPercent*width);
        CGRect indicatorViewFrame = self.indicatorView.frame;
        indicatorViewFrame.origin.x = x;
        self.indicatorView.frame = indicatorViewFrame;
    }
}

- (void)setIndex:(NSInteger)index {
    if (_index != index && index >= 0 && index <= self.buttonTitles.count-1) {
        UIButton *previousButton;
        BOOL hasBeenSet = _index != NSNotFound;
        if (hasBeenSet) {
            previousButton = self.buttons[_index];
            previousButton.selected = NO;
        }
        _index = index;
        UIButton *currentButton = self.buttons[_index];
        currentButton.selected = YES;
        CGFloat scrollPercent = (CGFloat)index/(CGFloat)(self.buttonTitles.count-1);
        if (hasBeenSet) {
            self.animating = YES;
            [UIView animateWithDuration:self.animationDuration
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.scrollPercent = scrollPercent;
                                 previousButton.backgroundColor = self.normalBackgroundColor;
                                 currentButton.backgroundColor = self.selectedBackgroundColor;
                             }
                             completion:^(BOOL finished){
                                 self.animating = NO;
                             }];
        } else {
            self.scrollPercent = scrollPercent;
            previousButton.backgroundColor = self.normalBackgroundColor;
            currentButton.backgroundColor = self.selectedBackgroundColor;
        }
        if (self.contentAlignment == JBMTabBarAlignmentScroll && self.contentWidth > self.frame.size.width) {
            [self scrollToButton:currentButton];
        }
    }
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    
    CGFloat width = self.frame.size.width;
    if (_scrollView) {
        [UIView setView:self.scrollView width:width];
    }
    if (_lineView) {
        [UIView setView:self.lineView width:width];
    }
    if (_buttons) {
        [self setButtonFrames];
    }
}

#pragma mark - Interaction Methods

- (IBAction)buttonTouched:(UIButton *)sender {
    NSInteger index = sender.tag;
    self.index = index;
    [self.delegate tabBar:self didSelectIndex:index];
}

#pragma mark - Private Methods

- (CGFloat)contentX {
    CGFloat contentRemainderWidth = MAX(0, self.frame.size.width-self.contentWidth);
    switch (self.contentAlignment) {
        case JBMTabBarAlignmentCenter :
            return roundf(contentRemainderWidth/2.0f);
            break;
        case JBMTabBarAlignmentRight :
            return contentRemainderWidth;
            break;
        default :
            return 0;
    }
}

- (CGFloat)contentWidth {
    return self.buttonTitles.count*self.buttonWidth;
}

- (void)setButtonTitles:(NSArray *)buttonTitles {
    _buttonTitles = buttonTitles;
    NSMutableArray *buttons = [NSMutableArray new];
    for (NSInteger i = 0; i< buttonTitles.count; i++) {
        NSString *title = buttonTitles[i];
        UIButton *button = [self addButtonWithTitle:title index:i];
        [buttons addObject:button];
    }
    self.buttons = [NSArray arrayWithArray:buttons];
}

- (void)setButtonFrames {
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        [self setButtonFrame:button index:i];
    }
}

- (void)setButtonFrame:(UIButton *)button index:(NSUInteger)index {
    CGFloat x = self.contentX+(self.buttonWidth*index);
    button.frame = CGRectMake(x, 0.0f, self.buttonWidth, self.frame.size.height);
}

- (UIButton *)addButtonWithTitle:(NSString *)title index:(NSUInteger)index {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonFrame:button index:index];
    button.tag = index;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:self.normalTextColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
    button.titleLabel.font = self.buttonFont;
    button.backgroundColor = self.normalBackgroundColor;
    [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    return button;
}

- (void)scrollToButton:(UIButton *)button {
    CGFloat buttonLeft = button.frame.origin.x;
    CGFloat contentRemainderWidth = self.contentWidth-self.buttonWidth;
    CGFloat percentage = buttonLeft/contentRemainderWidth;
    CGFloat scrollX = roundf(percentage*(self.contentWidth-self.frame.size.width));
    [self.scrollView setContentOffset:CGPointMake(scrollX, 0.0f) animated:YES];
}

#pragma mark - Instantiation Methods

- (JBMTabBarScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[JBMTabBarScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(self.contentWidth, self.frame.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.canCancelContentTouches = YES;
        [self insertSubview:_scrollView belowSubview:self.lineView];
    }
    return _scrollView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat x = self.contentX;
        CGFloat y = self.frame.size.height-self.indicatorHeight;
        CGFloat width = self.contentWidth/self.buttons.count;
        CGRect frame = CGRectMake(x, y, width, self.indicatorHeight);
        _indicatorView = [[UIView alloc] initWithFrame:frame];
        if (self.contentAlignment == JBMTabBarAlignmentScroll) {
            [self.scrollView addSubview:_indicatorView];
        } else {
            [self insertSubview:_indicatorView aboveSubview:self.lineView];
        }
    }
    return _indicatorView;
}

- (UIView *)indicatorInsetView {
    if (!_indicatorInsetView) {
        CGFloat x = self.indicatorInset;
        CGFloat width = self.indicatorView.frame.size.width-(self.indicatorInset*2.0f);
        CGRect frame = CGRectMake(x, 0.0f, width, self.indicatorView.frame.size.height);
        _indicatorInsetView = [[UIView alloc] initWithFrame:frame];
        _indicatorInsetView.backgroundColor = self.selectedTextColor;
        [self.indicatorView addSubview:_indicatorInsetView];
    }
    return _indicatorInsetView;
}

- (UIView *)lineView {
    if (!_lineView) {
        CGFloat height = 0.5f;
        CGRect frame = CGRectMake(0.0f, self.frame.size.height-height, self.frame.size.width, height);
        _lineView = [[UIView alloc] initWithFrame:frame];
        _lineView.backgroundColor = self.bottomBorderColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}

@end
