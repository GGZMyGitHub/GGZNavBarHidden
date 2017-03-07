//
//  GGZViewController.m
//  GGZNavBarHidden
//
//  Created by apple on 17/3/7.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "GGZViewController.h"

@interface GGZViewController ()
{
    
    NSInteger _hidenControlOptions;
    CGFloat _scrolOffsetY;
    UIScrollView * _keyScrollView;
    CGFloat _alpha;
    UIImage * _navBarBackgroundImage;
}

@end

@implementation GGZViewController


- (void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(GGZHidenControlOptions)options{
    
    _keyScrollView = keyScrollView;
    _hidenControlOptions = options;
    _scrolOffsetY = scrolOffsetY;
    
    [_keyScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGPoint point = _keyScrollView.contentOffset;
    _alpha =  point.y/_scrolOffsetY;
    _alpha = (_alpha <= 0)?0:_alpha;
    _alpha = (_alpha >= 1)?1:_alpha;
    
    [self setNavSubViewsAlpha];
}

- (void)dealloc{
    
    [_keyScrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:(BOOL)animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _navBarBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    });
    
    
    //设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:_navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    //清除边框，设置一张空的图片
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self setNavSubViewsAlpha];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self setNavSubViewsAlpha];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
}

- (void)setNavSubViewsAlpha {
    
    self.navigationItem.leftBarButtonItem.customView.alpha = _hidenControlOptions & 1?_alpha:1;
    self.navigationItem.titleView.alpha = _hidenControlOptions >> 1 & 1 ?_alpha:1;
    self.navigationItem.rightBarButtonItem.customView.alpha = _hidenControlOptions >> 2 & 1?_alpha:1;
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:_alpha];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
