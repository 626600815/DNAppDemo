//
//  MenuViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/19.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "MenuViewController.h"
#import "DOPDropDownMenu.h"


@interface MenuViewController () <DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>

@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"餐单";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"重新加载" style:UIBarButtonItemStylePlain target:self action:@selector(menuReloadData)];
    // 数据
    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];
}

- (void)menuReloadData {
    self.classifys = @[@"美食",@"今日新单",@"电影"];
    [_menu reloadData];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}

//图片
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0 || indexPath.column == 1) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",(long)indexPath.row];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0 && indexPath.item >= 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",(long)indexPath.item];
    }
    return nil;
}

//辅助信息
- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column < 2) {
        return [@(arc4random()%1000) stringValue];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    return [@(arc4random()%1000) stringValue];
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column {
    if (column == 0) {
        if (row == 0) {
            return self.cates.count;
        } else if (row == 2){
            return self.movices.count;
        } else if (row == 3){
            return self.hostels.count;
        }
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return self.cates[indexPath.item];
        } else if (indexPath.row == 2){
            return self.movices[indexPath.item];
        } else if (indexPath.row == 3){
            return self.hostels[indexPath.item];
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    NSString * str = @"";
    if (indexPath.item >= 0) {
        str = [NSString stringWithFormat:@"点击的是第%ld个，第%ld行，第%ld分行",(long)indexPath.column,(long)indexPath.row,(long)indexPath.item];
        NSLog(@"点击了 %ld - %ld - %ld 项目",(long)indexPath.column,(long)indexPath.row,(long)indexPath.item);
    }else {
        str = [NSString stringWithFormat:@"点击的是第%ld个，第%ld行",(long)indexPath.column,(long)indexPath.row];
        NSLog(@"点击了 %ld - %ld 项目",(long)indexPath.column,(long)indexPath.row);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
