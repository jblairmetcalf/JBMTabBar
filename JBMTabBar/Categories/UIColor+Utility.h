//
//  UIColor+Utility.h
//  JBMCategories
//
//  Created by J Blair Metcalf on 4/19/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utility)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (CGFloat)colorComponentFromString:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length;

@end
