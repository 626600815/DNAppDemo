//
//  SecondViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/15.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "SecondViewController.h"
#import "MenuViewController.h"
#import "OpenShareHeader.h"
#import "DNShareView.h"
#import "SDCycleScrollView.h"
#import "SecondServices.h"


@interface SecondViewController () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) float viewHeight;

//轮播图
@property (weak, nonatomic) IBOutlet UIView *cyclebackView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) SDCycleScrollView *centerCycleScrollView;


@property (nonatomic, strong) NSMutableArray *cycleArray;//轮播图数据
@property (nonatomic, nonnull, strong) NSMutableArray *functionArray;//功能区数据
@property (nonatomic, strong) NSMutableArray *fourthArray;//四个奇怪的数据
@property (nonatomic, strong) NSMutableArray *scrollArray;//滚动的数据
@property (nonatomic, strong) NSMutableArray *nextFourthArray;//四个奇怪的数据
@property (nonatomic, strong) NSMutableArray *centerCycleArray;//中间轮播图

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(shareMenu)];
    
    //创建功能区
    [self createFunctionButton];
    [self createFourthButton];
    [self highesCommission];
    [self createNextFourthButton];
    
    self.scrollView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [SecondServices requestListInfo:^(NSDictionary *listinfoDic) {
            [self.scrollView.mj_header endRefreshing];
            
            //给各个模块赋值
            self.cycleArray = listinfoDic[@"cycle"];
            self.functionArray = listinfoDic[@"function"];
            self.fourthArray = listinfoDic[@"fourth"];
            self.scrollArray = listinfoDic[@"scroll"];
            self.centerCycleArray = listinfoDic[@"centercycle"];
            //刷新界面
            [self refreshView];
        }];
    }];
    [self.scrollView.mj_header beginRefreshing];
}



- (void)refreshView {
    
    //设置轮播图
    NSMutableArray *mutArray = [NSMutableArray arrayWithCapacity:self.cycleArray.count];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < self.cycleArray.count; i++) {
            NSString *imageurl = self.cycleArray[i][@"image"];
            [mutArray addObject:imageurl];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"mutArray : %@",mutArray);
            self.cycleScrollView.imageURLStringsGroup = mutArray;
        });
    });
    
        //设置功能区
        for (NSInteger i = 0; i < 10; i++) {
            UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:100+i];
            UILabel *label = (UILabel *)[self.scrollView viewWithTag:1000+i];
            label.text = self.functionArray[i][@"name"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.functionArray[i][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [imageView addCornerWithRadius:imageView.width/2];
            }];
            [imageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                NSLog(@"功能区点击的按钮是:%@",self.functionArray[i][@"id"]);
            }];
        }
    
    //设置四个奇怪的按钮
    for (NSInteger i = 0; i < self.fourthArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:1400+i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.fourthArray[i][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        imageView.userInteractionEnabled = YES;
        [imageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            NSLog(@"点击的四个奇怪按钮上得图标：%@",self.fourthArray[i][@"id"]);
        }];
    }
    
    //能滚动的
    UIScrollView *scrollV = (UIScrollView *)[self.scrollView viewWithTag:12000];
    scrollV.contentSize = CGSizeMake((scrollV.height - 50 + 10)*self.scrollArray.count, scrollV.height);
    //处理一下重复创建而导致的内存上升
    for(int i = 0;i<[scrollV.subviews count];i++){
        [scrollV.subviews[i] removeFromSuperview];
    }
    for (NSInteger i = 0; i < self.scrollArray.count; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*(scrollV.height-50 +10), 0, scrollV.height- 50, scrollV.height-50)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.scrollArray[i][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [scrollV addSubview:imageV];
        
        imageV.userInteractionEnabled = YES;
        [imageV addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            NSLog(@"点击的scrollView上得图标：%@",self.scrollArray[i][@"id"]);
        }];
        
        
        UILabel *commissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageV.x, imageV.height+5, imageV.width, 20)];
        commissionLabel.text = [NSString stringWithFormat:@"佣金：¥%@",self.scrollArray[i][@"commission"]];
        commissionLabel.textAlignment = NSTextAlignmentCenter;
        commissionLabel.font = [UIFont systemFontOfSize:14];
        commissionLabel.textColor = [UIColor whiteColor];
        [scrollV addSubview:commissionLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageV.x, imageV.height+25, imageV.width, 20)];
        priceLabel.text = [NSString stringWithFormat:@"¥%@",self.scrollArray[i][@"price"]];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.textColor = [UIColor whiteColor];
        [scrollV addSubview:priceLabel];
    }
    
    //设置另外四个奇怪的
    //设置四个奇怪的按钮
    for (NSInteger i = 0; i < self.nextFourthArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:1800+i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.nextFourthArray[i][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        imageView.userInteractionEnabled = YES;
        [imageView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            NSLog(@"点击的四个奇怪按钮上得图标：%@",self.nextFourthArray[i][@"id"]);
        }];
    }
    
    //设置轮播图
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.cycleArray.count];
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue1, ^{
        for (NSInteger i = 0; i < self.centerCycleArray.count; i++) {
            NSString *imageurl = self.centerCycleArray[i][@"image"];
            [tempArray addObject:imageurl];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"mutArray : %@",mutArray);
            self.centerCycleScrollView.imageURLStringsGroup = mutArray;
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"轮播图点击的是：%@", self.cycleArray[index][@"id"]);
}

- (void)dismissVC {
    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuVC animated:YES];
}

- (void)shareMenu {
    DNShareView *shareView = [[DNShareView alloc] initWithShare];
    shareView.contentUrl = @"http://www.baidu.com";
    shareView.showtext = @"content";
    shareView.myCopyUrl = @"http://www.baidu.com";
    shareView.erweimaUrl = @"http://www.baidu.com";
    shareView.titleName = @"title";
    shareView.showImageUrl = @"http://www.5068.com/u/faceimg/20140804114111.jpg";
    [shareView showInView:self.view];
}

#pragma mark - 初始化
//轮播图
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        self.cyclebackView.width = SCREEM_WIDTH;
        // 网络加载 --- 创建带标题的图片轮播器
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.cyclebackView.frame delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.autoScrollTimeInterval = 4.0f;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self.cyclebackView addSubview:_cycleScrollView];
        _cycleScrollView.autoScroll = NO;
    }
    return _cycleScrollView;
}

//功能区
- (void)createFunctionButton {
    for (NSInteger i = 0; i < 10; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i%5*(SCREEM_WIDTH/5)+10, 190+i/5*(SCREEM_WIDTH/5 + 10), SCREEM_WIDTH/5-20, SCREEM_WIDTH/5-20)];
        imageView.tag = 100+i;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        UILabel *functionLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.x, imageView.y + imageView.height, imageView.width, 20)];
        functionLabel.tag = 1000+i;
        functionLabel.text = @"女装";
        functionLabel.font = [UIFont systemFontOfSize:12];
        functionLabel.textColor = [UIColor grayColor];
        functionLabel.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:functionLabel];
    }
    self.viewHeight = 190 + SCREEM_WIDTH*2/5 + 20;
}

//四个奇怪的组合
- (void)createFourthButton {
    UIImageView *imagev1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.viewHeight, SCREEM_WIDTH*2/5, SCREEM_WIDTH*3/5)];
    imagev1.backgroundColor = [UIColor RandomColor];
    imagev1.tag = 1400;
    [self.scrollView addSubview:imagev1];
    
    UIImageView *imagev2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEM_WIDTH*2/5, self.viewHeight, SCREEM_WIDTH*3/5, SCREEM_WIDTH*1.5/5)];
    imagev2.backgroundColor = [UIColor RandomColor];
    imagev2.tag = 1401;
    [self.scrollView addSubview:imagev2];
    
    UIImageView *imagev3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEM_WIDTH*2/5, self.viewHeight+SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5)];
    imagev3.backgroundColor = [UIColor RandomColor];
    imagev3.tag = 1402;
    [self.scrollView addSubview:imagev3];
    
    UIImageView *imagev4 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEM_WIDTH*3.5/5, self.viewHeight+SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5, SCREEM_WIDTH*1.5/5)];
    imagev4.backgroundColor = [UIColor RandomColor];
    imagev4.tag = 1403;
    [self.scrollView addSubview:imagev4];
    
    
    self.viewHeight += SCREEM_WIDTH*3/5;
}

//能滚动的最高返佣
- (void)highesCommission {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewHeight, SCREEM_WIDTH, 30)];
    backView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:backView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEM_WIDTH, 30)];
    label.text = @"最高返佣";
    label.font = [UIFont systemFontOfSize:14];
    [backView addSubview:label];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"查看更多" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.frame = CGRectMake(SCREEM_WIDTH- 90, 0, 90, 30);
    [backView addSubview:button];
    [button addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSLog(@"查看更多");
    }];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.viewHeight + 30, SCREEM_WIDTH, 150)];
    scrollV.backgroundColor = [UIColor redColor];
    scrollV.tag = 12000;
    [self.scrollView addSubview:scrollV];
    
    self.viewHeight += scrollV.height + 30;
}

- (void)createNextFourthButton {
    
    float widthAndHeight = SCREEM_WIDTH*1/3;
    UIImageView *imagev1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.viewHeight, SCREEM_WIDTH, widthAndHeight)];
    imagev1.backgroundColor = [UIColor RandomColor];
    imagev1.tag = 1800;
    [self.scrollView addSubview:imagev1];
    
    UIImageView *imagev2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.viewHeight+widthAndHeight, widthAndHeight, widthAndHeight)];
    imagev2.backgroundColor = [UIColor RandomColor];
    imagev2.tag = 1801;
    [self.scrollView addSubview:imagev2];
    
    UIImageView *imagev3 = [[UIImageView alloc] initWithFrame:CGRectMake(widthAndHeight, self.viewHeight+widthAndHeight, widthAndHeight, widthAndHeight)];
    imagev3.backgroundColor = [UIColor RandomColor];
    imagev3.tag = 1802;
    [self.scrollView addSubview:imagev3];
    
    UIImageView *imagev4 = [[UIImageView alloc] initWithFrame:CGRectMake(widthAndHeight*2, self.viewHeight+widthAndHeight, widthAndHeight, widthAndHeight)];
    imagev4.backgroundColor = [UIColor RandomColor];
    imagev4.tag = 1803;
    [self.scrollView addSubview:imagev4];
    
    
    self.viewHeight += widthAndHeight*2;
}

//中间轮播图
- (SDCycleScrollView *)centerCycleScrollView {
    if (!_centerCycleScrollView) {
        self.cyclebackView.width = SCREEM_WIDTH;
        // 网络加载 --- 创建带标题的图片轮播器
        _centerCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, self.viewHeight, SCREEM_WIDTH, 100) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _centerCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _centerCycleScrollView.autoScrollTimeInterval = 4.0f;
        _centerCycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self.scrollView addSubview:_centerCycleScrollView];
        _centerCycleScrollView.autoScroll = NO;
    }
    return _centerCycleScrollView;
}

- (NSMutableArray *)cycleArray {
    if (!_cycleArray) {
        _cycleArray = [[NSMutableArray alloc] init];
    }
    return _cycleArray;
}

- (NSMutableArray *)functionArray {
    if (!_functionArray) {
        _functionArray = [[NSMutableArray alloc] init];
    }
    return _functionArray;
}

- (NSMutableArray *)fourthArray {
    if (!_fourthArray) {
        _fourthArray = [[NSMutableArray alloc] init];
    }
    return _fourthArray;
}

- (NSMutableArray *)scrollArray {
    if (!_scrollArray) {
        _scrollArray = [[NSMutableArray alloc] init];
    }
    return _scrollArray;
}

- (NSMutableArray *)centerCycleArray {
    if (!_centerCycleArray) {
        _centerCycleArray = [[NSMutableArray alloc] init];
    }
    return _centerCycleArray;
}

- (NSMutableArray *)nextFourthArray {
    if (!_nextFourthArray) {
        _nextFourthArray = [[NSMutableArray alloc] init];
    }
    return _nextFourthArray;
}

@end
