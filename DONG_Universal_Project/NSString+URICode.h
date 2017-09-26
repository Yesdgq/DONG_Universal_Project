//
//  NSString+URICode.h
//  JoytingSuperNew
//
//  Created by Gao on 7/22/15.
//  Copyright © 2015 Joymis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URICode)

+ (NSString*)escapeHTML:(NSString*)src;
+ (NSString*)unescapeHTML:(NSString*)src;
+ (NSString*)escapeURIComponent:(NSString*)src;
+ (NSString*)unescapeURIComponent:(NSString*)url;

@end
