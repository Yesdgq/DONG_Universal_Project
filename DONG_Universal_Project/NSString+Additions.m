//
//  NSString+Additions.m
//  JoytingSuperNew
//
//  Created by Gao on 8/3/15.
//  Copyright © 2015 Joymis. All rights reserved.
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Additions)

- (BOOL)isValidString{
    
    if (!self || [self isEqual:[NSNull null]] || [self isEqualToString:@"<nil>"]){
        return NO;
    }

    if ([self length] == 0) {
        return NO;
    } else if ([[self stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return NO;
    }
    return YES;
}

- (NSString *)MD5String{
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, [self UTF8String], (CC_LONG)[self length]);
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *s = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
    
}


+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
    NSURL* parsedURL = [NSURL URLWithString:baseURL];
    NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator])
    {
        
        NSString* escaped_value = @"";
        escaped_value= (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes
        (
         NULL, /* allocator */
         (CFStringRef)[params objectForKey:key],
         NULL, /* charactersToLeaveUnescaped */
         (CFStringRef)@"!*'();:@&=+$,/?%#[]",
         kCFStringEncodingUTF8);
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    NSString* query = [pairs componentsJoinedByString:@"&"];
    
    return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}

+ (NSMutableDictionary *) explodeQueryStringToDictionary:(NSString *) queryString
{
    
    NSArray *firstExplode = [queryString componentsSeparatedByString:@"&"];
    NSArray *secondExplode;
    NSInteger count = [firstExplode count];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode =
        [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:@"="];
        if ([secondExplode count] == 2) {
            [returnDictionary setObject:[secondExplode objectAtIndex:1]
                                 forKey:[secondExplode objectAtIndex:0]];
        }
    }
    return returnDictionary;
}

- (NSUInteger)getWeiboTextLength
{
    NSInteger index, textLength;
    NSInteger absSumLength = 0;
    CGFloat sumLength = 0;
    if (nil != self)
    {
        textLength = [self length];
        if (textLength > 0)
        {
            for (index = 0; index < textLength; index++)
            {
                unichar c = [self characterAtIndex:index];
                sumLength += [self getCharacterLength:c];
            }
            absSumLength = sumLength;
            if (sumLength - absSumLength > 0.001)
                return absSumLength + 1;
            else
                return absSumLength;
        }
        else {
            return 0;
        }
    }
    else {
        return 0;
    }
}

- (CGFloat)getCharacterLength:(unichar)c
{
    if (c >= 32 && c <= 128)
        return 0.5;
    else
        return 1;
}

+ (NSString*)dataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}



@end
