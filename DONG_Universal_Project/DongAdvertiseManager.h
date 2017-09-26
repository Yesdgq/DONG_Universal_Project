//
//  DongAdvertiseManager.h
//  DONG_Universal_Project
//
//  Created by yesdgq on 16/6/30.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DongAdvertiseManager : NSObject

+ (BOOL)isShouldDisplayAd;
+ (UIImage *)getAdImage;
+ (void)loadLatestAdImage;

@end
