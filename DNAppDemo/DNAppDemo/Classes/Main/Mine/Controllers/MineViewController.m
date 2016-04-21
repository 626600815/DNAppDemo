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


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNav];//初始化导航栏
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar Rreset];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.tableView.contentOffset.y/(StretchHeaderHeight-64) < 0.8) {
        [self.navigationController.navigationBar RsetBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:self.tableView.contentOffset.y/(StretchHeaderHeight-64)]];
    }else {
        [self.navigationController.navigationBar Rreset];
    }
    
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
    bgImageView.image = [UIImage imageNamed:@"mine_bg.jpg"];
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView *avater = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageView.center.x-35, bgImageView.frame.size.height - 120, 70, 70)];
    avater.image = [UIImage imageNamed:@"mine_avater"];
    [contentView addSubview:avater];
    
    self.stretchHeaderView = [[DNTableHeaderView alloc] init];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:bgImageView subViews:contentView];
}


#pragma mark - table delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
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
    if (scrollView.contentOffset.y/(StretchHeaderHeight-64) < 0.8) {
        [self.navigationController.navigationBar RsetBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:scrollView.contentOffset.y/(StretchHeaderHeight-64)]];
    }else {
        [self.navigationController.navigationBar Rreset];
    }
}

- (void)viewDidLayoutSubviews {
    [self.stretchHeaderView resizeView];
}

#pragma mark - 初始化
- (void)initNav {
    
    [self.navigationController.navigationBar RsetBackgroundColor:[UIColor clearColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self initStretchHeader];
}

@end
