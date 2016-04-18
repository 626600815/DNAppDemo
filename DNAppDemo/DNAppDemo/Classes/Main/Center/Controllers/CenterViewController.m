//
//  CenterViewController.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "CenterViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DNQRCodeReader.h"
#import "DetailViewController.h"

@interface CenterViewController ()<DNQRCodeReaderDelegate>

@property (nonatomic, strong) UIView *QRBackView;

@end

@implementation CenterViewController

- (void)dealloc {
    [[DNQRCodeReader sharedReader] setDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initNav];//初始化导航栏
    [[DNQRCodeReader sharedReader] setDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DNQRCodeReader sharedReader] startReaderOnView:self.QRBackView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ItemMethod
- (void)getPhotos {
    NSLog(@"从相册中选取");
}

- (void)dismissVC {
    NSLog(@"关闭页面");
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - DNQRCodeReaderDelegate
- (void)didDetectQRCode:(AVMetadataMachineReadableCodeObject *)qrCode {
    [[DNQRCodeReader sharedReader] stopReader];
    NSString *message = [NSString stringWithFormat:@"Detected a QR code! type:%@, value:%@",qrCode.type, qrCode.stringValue];
    NSLog(@"扫码的到的信息是:%@",message);
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:NSStringFromClass([DetailViewController class]) bundle:nil];
    detailVC.urlString = qrCode.stringValue;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 初始化

- (UIView *)QRBackView {
    if (!_QRBackView) {
        _QRBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80)];
        _QRBackView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_QRBackView];
    }
    return _QRBackView;
}

- (void)initNav {
    self.navigationItem.title = @"二维码扫描";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(getPhotos)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)];
}

@end
