//
//  UIColor+Utility.m
//  JBMCategories
//
//  Created by J Blair Metcalf on 4/19/15.
//  Copyright (c) 2015 J Blair Metcalf. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch (colorString.length) {
        case 3:
            alpha = 1.0f;
            red   = [self colorComponentFromString:colorString start:0 length:1];
            green = [self colorComponentFromString:colorString start:1 length:1];
            blue  = [self colorComponentFromString:colorString start:2 length:1];
            break;
        case 4:
            alpha = [self colorComponentFromString:colorString start:0 length:1];
            red   = [self colorComponentFromString:colorString start:1 length:1];
            green = [self colorComponentFromString:colorString start:2 length:1];
            blue  = [self colorComponentFromString:colorString start:3 length:1];
            break;
        case 6:
            alpha = 1.0f;
            red   = [self colorComponentFromString:colorString start:0 length:2];
            green = [self colorComponentFromString:colorString start:2 length:2];
            blue  = [self colorComponentFromString:colorString start:4 length:2];
            break;
        case 8:
            alpha = [self colorComponentFromString:colorString start:0 length:2];
            red   = [self colorComponentFromString:colorString start:2 length:2];
            green = [self colorComponentFromString:colorString start:4 length:2];
            blue  = [self colorComponentFromString:colorString start:6 length:2];
            break;
        default:
            [NSException raise:@"UIColor (Utility): colorWithHexString: Invalid Length" format:@"Color value %@ is invalid. It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFromString:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt:&hexComponent];
    return hexComponent/255.0f;
}

@end
