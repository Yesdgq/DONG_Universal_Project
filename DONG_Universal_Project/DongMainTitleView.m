//
//  DONGMainTitleView.m
//  DONG_Universal_Project
//
//  Created by yesdgq on 16/6/30.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import "DongMainTitleView.h"
#import "DongTilteLabel.h"

const CGFloat TitieHeight = 40.0f;
const CGFloat StatusBarHeight = 20.0f;
const CGFloat LabelWidth = 70;

@interface DongMainTitleView ()<UIScrollViewDelegate>

@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, strong) UIView *line;
@end

@implementation DongMainTitleView
#pragma mark- init

- (instancetype)initWithFrame:(CGRect)frame View:(UIView *)view{
    self = [super init];
    if (self) {
        [self.view setFrame:frame];
        /** 添加标题栏 */
        [self constructTitleView];
        /** 添加内容页面 */
        [self constructContentView];
        
        [view addSubview:self.view];//将self添加到指定view
        
        // 添加默认控制器到contentScroll
        UIViewController *vc = [self.childViewControllers firstObject];
        vc.view.frame = self.contentScroll.bounds;
        [self.contentScroll addSubview:vc.view];
        DongTilteLabel *lable = [self.titleScroll.subviews firstObject];
        lable.scale = 1.0;
        
    }
    return self;
}

#pragma mark-  ViewLife Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = [@[@"头条",@"娱乐",@"体育",@"科技",@"热点",@"财经",@"汽车",@"美女"] copy];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillLayoutSubviews{
}


#pragma mark- Public methods




#pragma mark- private methods
/** 添加标题栏label */
- (void)constructTitleView{
    _titleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, TitieHeight)];//滚动窗口
    _titleScroll.showsHorizontalScrollIndicator = NO;
    _titleScroll.showsVerticalScrollIndicator = NO;
    _titleScroll.scrollsToTop = NO;
//    _titleScroll.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_titleScroll];
    [self addLabel];//添加标题label
    
    //1、底部滑动短线
    _bottomLine = [CALayer layer];
//    [_bottomLine setBackgroundColor:[UIColor redColor].CGColor];
//    _bottomLine.frame = CGRectMake(0, _titleScroll.frame.origin.y+StatusBarHeight-1, LabelWidth, 1);
    
    //  2、底部自定义图片
    _bottomLine.contents = (__bridge id _Nullable)([UIImage imageNamed:@"redTriangle"].CGImage);
    
    _bottomLine.frame = CGRectMake(LabelWidth/2, _titleScroll.frame.origin.y+StatusBarHeight-4, 7, 4);
    
    
    [_titleScroll.layer addSublayer:_bottomLine];
    
    
}

/** 添加标题栏label */
- (void)addLabel{
    for (int i = 0; i < _titleArr.count; i++) {
        CGFloat lbW = LabelWidth;                //宽
        CGFloat lbH = TitieHeight;       //高
        CGFloat lbX = i * lbW;           //X
        CGFloat lbY = 0;                 //Y
        DongTilteLabel *label = [[DongTilteLabel alloc] initWithFrame:(CGRectMake(lbX, lbY, lbW, lbH))];
        //        UIViewController *vc = self.childViewControllers[i];
        label.text =_titleArr[i];
        label.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.titleScroll addSubview:label];
        NSLog(@"====label:%@",NSStringFromCGRect(label.frame));
        label.tag = i;
        label.userInteractionEnabled = YES;
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)]];
    }
    
    _titleScroll.contentSize = CGSizeMake(LabelWidth * _titleArr.count, 0);
    
}

/** 添加正文内容页 */
- (void)constructContentView{
    _contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarHeight+TitieHeight, self.view.bounds.size.width, self.view.bounds.size.height-TitieHeight-StatusBarHeight)];//滚动窗口
    _contentScroll.scrollsToTop = NO;
    _contentScroll.showsHorizontalScrollIndicator = NO;
    _contentScroll.pagingEnabled = YES;
    _contentScroll.delegate = self;
//    _contentScroll.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_contentScroll];
    //添加子控制器
    for (int i=0 ; i<_titleArr.count ;i++){
        UIViewController *vc = [[UIViewController alloc] init];
        
        
        UILabel *lab = [[UILabel alloc] init];
        [lab setFrame:CGRectMake(140, 200, 100, 40)];
        [vc.view addSubview:lab];
        lab.text = [NSString stringWithFormat:@"%d",i+1];
        lab.font = [UIFont fontWithName:@"HYQiHei" size:19];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor grayColor];
        
        [self addChildViewController:vc];
    }
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    _contentScroll.contentSize = CGSizeMake(contentX, 0);
}

#pragma mark- Event reponse
- (void)labelClick:(UITapGestureRecognizer *)recognizer{
    DongTilteLabel *label = (DongTilteLabel *)recognizer.view;
    CGFloat offsetX = label.tag * _contentScroll.frame.size.width;
    
    CGFloat offsetY = _contentScroll.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [_contentScroll setContentOffset:offset animated:YES];
}


#pragma mark - UIScrollViewDelegate
/** 滚动结束后调用（代码导致的滚动停止） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / _contentScroll.frame.size.width;
    // 滚动标题栏
    DongTilteLabel *titleLable = (DongTilteLabel *)_titleScroll.subviews[index];
    //把下划线与titieLabel的frame绑定(下划线滑动方式)
    //_bottomLine.frame = CGRectMake(titleLable.frame.origin.x, _titleScroll.frame.origin.y+StatusBarHeight-1, LabelWidth, 1);

    CGFloat offsetx = titleLable.center.x - _titleScroll.frame.size.width * 0.5;
    
    CGFloat offsetMax = _titleScroll.contentSize.width - _titleScroll.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, _titleScroll.contentOffset.y);
    [_titleScroll setContentOffset:offset animated:YES];
    
    // 将控制器添加到contentScroll
    UIViewController *vc = self.childViewControllers[index];
//    vc.index = index;
    
    [_titleScroll.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            DongTilteLabel *temlabel = _titleScroll.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
//    [self setScrollToTopWithTableViewIndex:index];
    
    if (vc.view.superview) return;//阻止vc重复添加
    vc.view.frame = scrollView.bounds;
    [_contentScroll addSubview:vc.view];
    

}

/** 滚动结束（手势导致的滚动停止） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    DongTilteLabel *labelLeft = _titleScroll.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < _titleScroll.subviews.count) {
        DongTilteLabel *labelRight = _titleScroll.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
    //下划线即时滑动
    float modulus = scrollView.contentOffset.x/_contentScroll.contentSize.width;
//    _bottomLine.frame = CGRectMake(modulus * _titleScroll.contentSize.width, _titleScroll.frame.origin.y+StatusBarHeight-1, LabelWidth, 1);
    
    //自定义滑条
    _bottomLine.frame = CGRectMake(modulus * _titleScroll.contentSize.width + LabelWidth/2, _titleScroll.frame.origin.y+StatusBarHeight-4, 7, 4);
}

#pragma mark- NSNotification



@end
