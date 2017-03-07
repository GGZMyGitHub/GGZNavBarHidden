//
//  TestViewController.m
//  GGZNavBarHidden
//
//  Created by apple on 17/3/7.
//  Copyright © 2017年 GuangZhou Gu. All rights reserved.
//

#import "TestViewController.h"
#import "UIViewController+NavBarHidden.h"

#define Kscreen_width  [UIScreen mainScreen].bounds.size.width
#define Kscreen_height [UIScreen mainScreen].bounds.size.height

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *reuseIdentifier = @"cell";
@implementation TestViewController

#pragma mark -Getter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, Kscreen_width, Kscreen_height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置当有导航栏自动添加64的高度的属性为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setKeyScrollView:self.tableView scrolOffsetY:600 options:GGZHidenControlOptionLeft | GGZHidenControlOptionTitle];
    //设置tableView的头部视图
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 250)];
    imageView.image = [UIImage imageNamed:@"lol"];
    self.tableView.tableHeaderView = imageView;
    [self setNavBarBackgroundImage:[UIImage imageNamed:@"2.jpg"]];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self ggz_viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self ggz_viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self ggz_viewWillDisappear:animated];
}

#pragma mark - Table View Data Source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.text = @"你好，屌丝";
    cell.detailTextLabel.textColor = [UIColor blackColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
