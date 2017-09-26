//
//  DONGMainTitleView.h
//  DONG_Universal_Project
//
//  Created by yesdgq on 16/6/30.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DongMainTitleView : UIViewController

/*********
 * titleView数组
 *********/
@property (nonatomic, strong) NSMutableArray *titleArr;

/*********
 * 标题栏scrollView
 *********/
@property (nonatomic, strong) UIScrollView *titleScroll;

/*********
 * 内容栏scrollView
 *********/
@property (nonatomic, strong) UIScrollView *contentScroll;

@property (nonatomic, strong) NSString *str;

- (instancetype)initWithFrame:(CGRect)frame View:(UIView *)view;

@end
