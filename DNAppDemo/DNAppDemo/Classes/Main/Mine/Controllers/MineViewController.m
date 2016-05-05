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
#import "DNPageView.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DNNavigationController.h"

#define StretchHeaderHeight 200


@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) DNTableHeaderView *stretchHeaderView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNav];//初始化导航栏
    [self loadDataWithArray];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar Rreset];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.tableView.contentOffset.y/(StretchHeaderHeight-64) < 0.8) {
        float alphaNum = self.tableView.contentOffset.y/(StretchHeaderHeight-64);
        [self.navigationController.navigationBar RsetBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:alphaNum]];
        [self.navigationController.navigationBar RsetElementsAlpha:alphaNum];
    }else {
        [self.navigationController.navigationBar Rreset];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataWithArray {
    NSArray *array = @[@"重现引导页", @"选个图片放个视频"];
    [self.dataArray addObjectsFromArray:array];
}

- (void)initStretchHeader {
    //背景
    UIImageView *bgImageView      = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, StretchHeaderHeight)];
    bgImageView.contentMode       = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds     = YES;
    bgImageView.image             = [UIImage imageNamed:@"mine_bg.jpg"];

    //背景之上的内容
    UIView *contentView           = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor   = [UIColor clearColor];

    UIImageView *avater           = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageView.center.x-35, bgImageView.frame.size.height - 120, 70, 70)];
    avater.image                  = [UIImage imageNamed:@"mine_avater"];
    [contentView addSubview:avater];

    avater.userInteractionEnabled = YES;
    //点击头像去登录
    [avater addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        LoginViewController *loginVC     = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        DNNavigationController *loginNvc = [[DNNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNvc animated:YES completion:nil];
    }];
    
    self.stretchHeaderView = [[DNTableHeaderView alloc] init];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:bgImageView subViews:contentView];
}

#pragma mark - table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text          = self.dataArray[indexPath.row];
    cell.backgroundColor         = [UIColor colorWithRed:230 green:230 blue:230 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [NSFileManager setAppSettingsForObject:@"1.0" forKey:@"VersionStr"];
        return;
    }
    SettingViewController *setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark - stretchableTable delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
    if (scrollView.contentOffset.y/(StretchHeaderHeight-64) < 0.8) {
        float alphaNum = self.tableView.contentOffset.y/(StretchHeaderHeight-64);
        [self.navigationController.navigationBar RsetBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:alphaNum]];
        [self.navigationController.navigationBar RsetElementsAlpha:alphaNum];
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
