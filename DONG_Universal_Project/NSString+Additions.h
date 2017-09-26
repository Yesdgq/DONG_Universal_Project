//
//  NSString+Additions.h
//  JoytingSuperNew
//
//  Created by Gao on 8/3/15.
//  Copyright © 2015 Joymis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)isValidString;

- (NSString *)MD5String;

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params;

+ (NSMutableDictionary *) explodeQueryStringToDictionary:(NSString *) queryString;

- (NSUInteger)getWeiboTextLength;

+ (NSString*)dataToJsonString:(id)object;

@end
