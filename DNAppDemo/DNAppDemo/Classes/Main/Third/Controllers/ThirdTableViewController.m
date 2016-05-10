//
//  ThirdTableViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ThirdTableViewController.h"
#import "ThirdService.h"
#import "FriendGroup.h"
#import "Friend.h"
#import "ThirdHeadView.h"
#import "LayoutViewController.h"

@interface ThirdTableViewController () <ThirdHeadViewDelegate>

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation ThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionHeaderHeight = 50;
    self.tableView.rowHeight           = 65;
    self.tableView.tableFooterView     = [[UIView alloc] init];
    [self loadListData];
}

- (void)loadListData {
    [ThirdService requestFriendListInfo:^(NSArray *listArray) {
        [self.listArray addObjectsFromArray:listArray];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FriendGroup *friendGroup = self.listArray[section];
    NSInteger count = friendGroup.isOpened ? friendGroup.friends.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    FriendGroup *friendGroup  = self.listArray[indexPath.section];
    Friend *friend            = friendGroup.friends[indexPath.row];

    cell.imageView.image      = [UIImage imageNamed:friend.icon];
    cell.textLabel.textColor  = friend.isVip ? [UIColor redColor] : [UIColor blackColor];
    cell.textLabel.text       = friend.name;
    cell.detailTextLabel.text = friend.intro;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ThirdHeadView *headView = [ThirdHeadView headViewWithTableView:tableView];
    headView.delegate       = self;
    headView.friendGroup    = self.listArray[section];
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LayoutViewController *layoutVC = [[LayoutViewController alloc] initWithNibName:@"LayoutViewController" bundle:nil];
    [self.navigationController pushViewController:layoutVC animated:YES];
}

- (void)clickHeadView {
    [self.tableView reloadData];
}

#pragma mark - 初始化
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}

@end
