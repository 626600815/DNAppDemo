//
//  GoodsListViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/5/11.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsListCell.h"
#import "GoodsListHeaderView.h"
#import "GoodsListFooterView.h"
#import "ListButton.h"

@interface GoodsListViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GoodsListHeaderViewDelegate>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) CGFloat lastPosition;//记住滑动前的位置

@property (nonatomic, strong) UIView *headerView;//筛选背景

@property (nonatomic, assign) NSInteger listPage;
@property (nonatomic, strong) NSString *type_s;
@property (nonatomic, strong) NSString *type_p;
@property (nonatomic, strong) NSString *add_time;


@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodsListCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsListCell"];
    self.navigationItem.title = @"分销列表";
    
    //设置顶部筛选按钮
    [self headerView];
    [self createButton];
    
    self.listPage = 1;

    //添加列表刷新功能
    self.collectionView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadDataWithPage:self.listPage];
    }];
    
}

- (void)loadDataWithPage:(NSInteger)page {
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (page == 1) {
            [self.collectionView.mj_header endRefreshing];
        }else {
            [self.collectionView.mj_footer endRefreshing];
            
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];//全部数据
            self.collectionView.mj_footer.automaticallyChangeAlpha = YES;
            
        }
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar RsetTranslationY:0];
    self.headerView.y = 64;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat currentPostion = scrollView.contentOffset.y;
    CGFloat poorNum = currentPostion - self.lastPosition;
    if (poorNum > 64 && currentPostion > 0) {
        self.lastPosition = currentPostion;
        [UIView animateWithDuration:.4 animations:^{
            [self.navigationController.navigationBar RsetTranslationY:-64];
        }];
        [UIView animateWithDuration:.3 animations:^{
            self.headerView.y = 20;
        }];
        
    } else if (-poorNum > 64) {
        self.lastPosition = currentPostion;
        [UIView animateWithDuration:.2 animations:^{
            [self.navigationController.navigationBar RsetTranslationY:0];
        }];
        [UIView animateWithDuration:.3 animations:^{
            self.headerView.y = 64;
        }];
    }
    
}

- (void)createButton {
    UIColor *buttonBackColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    ListButton *button1 = [[ListButton alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    button1.backgroundColor = buttonBackColor;
    button1.layer.cornerRadius = 5;
    button1.layer.masksToBounds = YES;
    [button1 setTitle:@"销量" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    [button1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [button1 addEffectWithBorderColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] borderWidth:.5];
    [self.headerView addSubview:button1];
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(90, 10, 60, 30)];
    button2.backgroundColor = buttonBackColor;
    button2.layer.cornerRadius = 5;
    button2.layer.masksToBounds = YES;
    [button2 setTitle:@"新品" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:13];
    button2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button2 addEffectWithBorderColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] borderWidth:.5];
    [self.headerView addSubview:button2];
    
    
    ListButton *button3 = [[ListButton alloc] initWithFrame:CGRectMake(160, 10, 60, 30)];
    button3.backgroundColor = buttonBackColor;
    button3.layer.cornerRadius = 5;
    button3.layer.masksToBounds = YES;
    [button3 setTitle:@"价格" forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:13];
    [button3 setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button3 addEffectWithBorderColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] borderWidth:.5];
    [self.headerView addSubview:button3];
    
    
    
    __weak typeof(UIButton *)button1self = button1;
    __weak typeof(UIButton *)button2self = button2;
    __weak typeof(UIButton *)button3self = button3;

    [button1 addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        button1self.selected = !button1self.selected;
        
        //button1的处理
        [button1self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button1self.imageView.transform = button1self.selected ? CGAffineTransformMakeRotation(-M_PI_2) : CGAffineTransformMakeRotation(M_PI_2);


        //button2的处理
        [button2self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button2self.selected = NO;
        
        //button3的处理
        [button3self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button3self.imageView.transform = CGAffineTransformMakeRotation(0);
        button3self.selected = NO;

        
    }];
    [button2 addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        button2self.selected = !button2self.selected;
        //button1的处理
        [button1self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button1self.imageView.transform = CGAffineTransformMakeRotation(0);
        button1self.selected = NO;
        
        //button2的处理
        [button2self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        //button3的处理
        [button3self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button3self.imageView.transform = CGAffineTransformMakeRotation(0);
        button3self.selected = NO;
        
    }];
    [button3 addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        button3self.selected = !button3self.selected;

        //button1的处理
        [button1self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button1self.imageView.transform = CGAffineTransformMakeRotation(0);
        button1self.selected = NO;
        
        //button2的处理
        [button2self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button2self.selected = NO;
        
        //button3的处理
        [button3self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button3self.imageView.transform = button3self.selected ? CGAffineTransformMakeRotation(-M_PI_2) : CGAffineTransformMakeRotation(M_PI_2);
    }];
}




#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GoodsListCell";
    GoodsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.listModel = nil;
    
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 5, 5, 5);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.item);
}

#pragma mark - 初始化
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc]init];
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowlayout.minimumLineSpacing           = 10;
        flowlayout.minimumInteritemSpacing      = 5;
        flowlayout.itemSize = CGSizeMake((SCREEM_WIDTH-20)/2, ((SCREEM_WIDTH-20)/2-10)+80);
        
        _collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SCREEM_WIDTH, SCREEM_HEIGHT-50) collectionViewLayout:flowlayout];
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.backgroundColor                = [UIColor colorWithWholeRed:245 green:245 blue:245 alpha:1];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEM_WIDTH, 50)];
        _headerView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [self.view addSubview:_headerView];
        [_headerView addEffectWithShadowRadius:1 shadowOffset:CGSizeMake(1.5, 1.5) shadowOpacity:0.5 shadowColor:GRAYCOLOR];
    }
    return _headerView;
}


@end
