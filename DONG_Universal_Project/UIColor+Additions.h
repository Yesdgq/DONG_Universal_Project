//
//  UIColor+Addtions.h
// Joymis
//
//  Created by Gao on 7/19/15.
//  Copyright © 2015 GaoYan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Additions)

UIColor *UIColorWithRGBFloatValue(CGFloat red,CGFloat green,CGFloat blue);

+ (nullable UIColor *) colorWithHexString: (nullable NSString *) stringToConvert;

+ (nullable UIColor *) colorWithDesignIndex:(NSInteger)index;

+ (BOOL) isTheSameColor:(nullable UIColor*)color1 anotherColor:(nullable UIColor*)color2;

@end

NS_ASSUME_NONNULL_END