//
//  DongAdvertiseManager.m
//  DONG_Universal_Project
//
//  Created by yesdgq on 16/6/30.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import "DongAdvertiseManager.h"

#define kCachedCurrentImage ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adcurrent.png"])
#define kCachedNewImage     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/adnew.png"])

@interface DongAdvertiseManager ()

+ (void)downloadImage:(NSString *)imageUrl;

@end


@implementation DongAdvertiseManager

+ (BOOL)isShouldDisplayAd
{
    return ([[NSFileManager defaultManager]fileExistsAtPath:kCachedCurrentImage isDirectory:NULL] || [[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NULL
                                                                                                      ]);
}

+ (UIImage *)getAdImage
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:kCachedNewImage isDirectory:NULL]) {
        [[NSFileManager defaultManager]removeItemAtPath:kCachedCurrentImage error:nil];
        [[NSFileManager defaultManager]moveItemAtPath:kCachedNewImage toPath:kCachedCurrentImage error:nil];
    }
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:kCachedCurrentImage]];
}

+ (void)downloadImage:(NSString *)imageUrl
{
    //异步下载图片
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"====222222:%@",[NSThread currentThread]);//子线程
        if (data) {
            [data writeToFile:kCachedNewImage atomically:YES];
        }
    }];
    [task resume];
}

+ (void)loadLatestAdImage
{
    
    NSInteger now = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=%ld",(long)now];
    NSLog(@"path===%@",path);
   
//    [[[SXNetworkTools sharedNetworkToolsWithoutBaseUrl] GET:path parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
//        NSLog(@"====11111:%@",[NSThread currentThread]);
//        NSArray *adArray = [responseObject valueForKey:@"ads"];
//        NSString *imgUrl = adArray[0][@"res_url"][0];
//        NSString *imgUrl2 = nil;
//        if (adArray.count >1) {
//            imgUrl2= adArray[1][@"res_url"][0];
//        }
//        
//        BOOL one = [[NSUserDefaults standardUserDefaults]boolForKey:@"one"];
//        if (imgUrl2.length > 0) {
//            if (one) {
//                [self downloadImage:imgUrl];
//                [[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
//            }else{
//                [self downloadImage:imgUrl2];
//                [[NSUserDefaults standardUserDefaults]setBool:!one forKey:@"one"];
//            }
//        }else{
//            [self downloadImage:imgUrl];
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }] resume];
}

@end
