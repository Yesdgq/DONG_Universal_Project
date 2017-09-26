//
//  NSObject+Runtime.m
//  JoytingSuperNew
//
//  Created by Gao on 7/22/15.
//  Copyright © 2015 Joymis. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>


@implementation NSObject (Runtime)
#pragma mark- RunTime

- (void)associateValue:(id)value withKey:(void *)key {
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)associateCopyOfValue:(id)value withKey:(void *)key {
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

- (void)weaklyAssociateValue:(id)value withKey:(void *)key {
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedValueForKey:(void *)key {
    
    return objc_getAssociatedObject(self, key);
}

@end
