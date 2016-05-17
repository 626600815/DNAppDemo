//
//  HomeViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "HomeViewController.h"
#import "DNUserInfo.h"
#import "DNLocationManager.h"
#import "HomeService.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "TouchViewController.h"
#import "DrawViewController.h"


static NSString *const Indentifier = @"cellID";

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:Indentifier];
    self.tableView.fd_debugLogEnabled = NO;

    [self loadDataList];
    
   
    
}

//请求数据刷新列表
- (void)loadDataList {
    [HomeService requestHomeListInfo:^(NSArray *listArray) {
        [self.listArray addObjectsFromArray:listArray];
        [self.tableView reloadData];
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //判断是否支持3Dtouch
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f) {
        if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
    }
    [self configureCell:cell atIndexPath:indexPath];
   
    return cell;
}

- (void)configureCell:(HomeCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    cell.homeModel = self.listArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   CGFloat cellHeight = [tableView fd_heightForCellWithIdentifier:Indentifier configuration:^(id cell) {
         [self configureCell:cell atIndexPath:indexPath];
    }];
    
    if (cellHeight < 100) {
        return 100;
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DrawViewController *vc = [[DrawViewController alloc] initWithNibName:@"DrawViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id)context viewControllerForLocation:(CGPoint) point {
    
    NSIndexPath *indexPath       = [self.tableView indexPathForCell:(UITableViewCell* )[context sourceView]];
    HomeModel *homeModel         = self.listArray[indexPath.row];

    TouchViewController *touchVC = [[TouchViewController alloc] initWithNibName:@"TouchViewController" bundle:nil];
    touchVC.preferredContentSize = CGSizeMake(0.0f,600.f);
    touchVC.homeModel            = homeModel;
    return touchVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark- 初始化
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}

@end
