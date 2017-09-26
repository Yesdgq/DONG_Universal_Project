//
//  NSObject+Runtime.h
//  JoytingSuperNew
//
//  Created by Gao on 7/22/15.
//  Copyright © 2015 Joymis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

#pragma mark- RunTime

- (void)associateValue:(id)value withKey:(void *)key;

- (void)associateCopyOfValue:(id)value withKey:(void *)key;

- (void)weaklyAssociateValue:(id)value withKey:(void *)key;

- (id)associatedValueForKey:(void *)key;

@end
