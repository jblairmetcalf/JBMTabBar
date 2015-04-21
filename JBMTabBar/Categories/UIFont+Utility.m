//
//  UIFont+Utility.m
//  JBMCategories
//
//  Created by J Blair Metcalf on 4/19/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import "UIFont+Utility.h"

@implementation UIFont (Utility)

+ (CGSize)sizeOfText:(NSString *)text withFont:(UIFont *)font width:(CGFloat)width {
    if ([text length]) {
        if ([[text substringFromIndex:[text length] - 1] isEqualToString:@"\n"]) {
            text = [text stringByAppendingString:@" "];
        }
    }
    NSDictionary *attributes = @{ NSFontAttributeName:font };
    CGSize singleLineRect = [text sizeWithAttributes:attributes];
    if (singleLineRect.width < width) {
        return singleLineRect;
    } else {
        CGSize multipleLineSize = CGSizeMake(width, CGFLOAT_MAX);
        CGRect multipleLineRect = [text boundingRectWithSize:multipleLineSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributes
                                                     context:nil];
        return multipleLineRect.size;
    }
}

@end
