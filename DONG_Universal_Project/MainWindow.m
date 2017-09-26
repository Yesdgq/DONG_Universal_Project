//
//  ViewController.m
//  DONG_Universal_Project
//
//  Created by yesdgq on 16/6/30.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import "MainWindow.h"
#import "DongMainTitleView.h"

@interface MainWindow ()

@property (nonatomic, strong) DongMainTitleView *titleView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MainWindow

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleView = [[DongMainTitleView alloc] initWithFrame:self.view.bounds View:self.view];

    
//    self.titleView.titleArr = [NSMutableArray arrayWithArray:self.dataSource];
//    self.titleView.str = @"zhongguo";

//    _titleView.titleArr = [@[@"头条",@"娱乐",@"体育",@"科技",@"热点",@"财经",@"汽车",@"美女"] copy];
//    NSLog(@"===datasource:%@====",self.titleView.titleArr);
//    NSLog(@"===str:%@====",self.titleView.str);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Getters and Setters
- (NSArray *)dataSource{
    if (!_dataSource) {
        NSArray *array = @[@"头条",@"娱乐",@"体育",@"科技",@"热点",@"财经",@"汽车",@"美女"];
        _dataSource = array;
    }
    return _dataSource;
}

@end
