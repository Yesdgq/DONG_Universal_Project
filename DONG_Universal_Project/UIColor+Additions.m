//
//  UIColor+Addtions.m
// Joymis
//
//  Created by Gao on 7/19/15.
//  Copyright © 2015 GaoYan. All rights reserved.
//

#import "UIColor+Additions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIColor (Additions)

UIColor *UIColorWithRGBFloatValue(CGFloat red,CGFloat green,CGFloat blue)
{
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}

+ (nullable UIColor *) colorWithHexString: (nullable NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString= [cString substringWithRange:range];
    
    // Scan values
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((CGFloat) r / 255.0f)
                           green:((CGFloat) g / 255.0f)
                            blue:((CGFloat) b / 255.0f)
                           alpha:1.0f];
}


+ (nullable UIColor *) colorWithDesignIndex:(NSInteger)index{
    
    static  NSArray *textColors = nil;//主题黄色10
    
    if (textColors == nil) {
        //                 0         1          2          3          4
        textColors=@[@"#FFFFFF",@"#444444",@"#666666",@"#999999",@"#f6f6f6",
                     //    5         6          7          8          9
                     @"#d5d5d5",@"#ebebeb",@"#384154",@"#3a3b4e",@"#333846",
                     //    10        11        12         13
                     @"#f27861",@"#9d9d9d",@"#e65349",@"00c194"];
    }
    
    if ( (index >= 0 && index < [textColors count]) == NO) {
        return [UIColor blackColor];
    }
    
    static NSMutableDictionary *colorContainer = nil;
    if (colorContainer == nil) {
        colorContainer = [NSMutableDictionary dictionary];
    }
    
    UIColor *retColor =  [colorContainer objectForKey:[NSNumber numberWithInteger:index]];
    if (retColor == nil) {
        retColor = [UIColor colorWithHexString:textColors[index]];
        [colorContainer setObject:retColor forKey:[NSNumber numberWithInteger:index]];
        return retColor;
    }else{
        return retColor;
    }
    
}


+ (BOOL) isTheSameColor:(nullable UIColor*)color1 anotherColor:(nullable UIColor*)color2
{
    if (CGColorEqualToColor(color1.CGColor, color2.CGColor)) {
        return YES;
    }
    else {
        return NO;
    }
}

@end

NS_ASSUME_NONNULL_END
