//
//  UIFont+Utility.h
//  JBMCategories
//
//  Created by J Blair Metcalf on 4/19/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Utility)

+ (CGSize)sizeOfText:(NSString *)text withFont:(UIFont *)font width:(CGFloat)width;

@end
