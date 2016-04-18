//
//  MineViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "MineViewController.h"
#import "DNTableHeaderView.h"
#import "SettingViewController.h"

#define StretchHeaderHeight 200


@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) DNTableHeaderView *stretchHeaderView;

@property (nonatomic, strong) UIView *statusBar;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNav];//初始化导航栏
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initStretchHeader {
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, StretchHeaderHeight)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo" ofType:@"jpg"]];
    
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView *avater = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageView.frame.size.width - 90, bgImageView.frame.size.height - 40, 70, 70)];
    avater.image = [UIImage imageNamed:@"avater"];
    [contentView addSubview:avater];
     
    
    self.stretchHeaderView = [[DNTableHeaderView alloc] init];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:bgImageView subViews:contentView];
}


#pragma mark - table delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld个cell",(long)indexPath.row];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SettingViewController *setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:(scrollView.contentOffset.y/(StretchHeaderHeight-64))];
    self.statusBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:(scrollView.contentOffset.y/(StretchHeaderHeight-64))];
    if (scrollView.contentOffset.y < (StretchHeaderHeight-64)/3) {
        self.navigationItem.title = @"";
    }else {
        self.navigationItem.title = @"个人中心";
    }
}

- (void)viewDidLayoutSubviews {
    [self.stretchHeaderView resizeView];
}

#pragma mark - 初始化
- (void)initNav {
    self.navigationItem.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.statusBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.statusBar];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self initStretchHeader];
}

@end
