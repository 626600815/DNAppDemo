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
#import "ZXingObjC.h"
#import "MyQRCodeViewController.h"

@interface CenterViewController ()<DNQRCodeReaderDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *QRBackView;

/**底部几个功能：开启闪光灯、相册、我的二维码*/
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;
//加一个拉近距离


//闪光灯状态
@property(nonatomic,assign) BOOL isOpenFlash;

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
    [[DNQRCodeReader sharedReader] startReaderOnView:self.QRBackView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DNQRCodeReader sharedReader] startReader];
    [self createFunctionView];//创建摄像头操作界面
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate
//UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image              = info[UIImagePickerControllerEditedImage];
        CGImageRef imageToDecode    = image.CGImage;
        ZXLuminanceSource *source   = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
        ZXBinaryBitmap *bitmap      = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
        NSError *error              = nil;
        ZXDecodeHints *hints        = [ZXDecodeHints hints];
        ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
        ZXResult *result            = [reader decode:bitmap hints:hints error:&error];
        
        if (result.text.length == 0) {
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
               
            } title:@"解析结果" message:@"解析失败" cancelButtonName:@"确定" otherButtonTitles:nil];
            return;
        }
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self loadWebViewWithUrlStr:result.text];
            }
        } title:@"解析结果" message:result.text cancelButtonName:@"取消" otherButtonTitles:@"前往", nil];
    }];
}



//DNQRCodeReaderDelegate
- (void)didDetectQRCode:(AVMetadataMachineReadableCodeObject *)qrCode {
    [self loadWebViewWithUrlStr:qrCode.stringValue];
}


#pragma mark - Method

- (void)dismissVC {
    DNLog(@"关闭页面");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)loadWebViewWithUrlStr:(NSString *)urlString {
    [[DNQRCodeReader sharedReader] stopReader];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.urlStr = urlString;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//关闭打开闪光灯
- (void)openOrCloseFlash {
    self.isOpenFlash = !self.isOpenFlash;
    if (self.isOpenFlash) {
        [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    } else {
        [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    }
    [self turnTorchOn:self.isOpenFlash];
}

//打开相册
- (void)openPhoto {
    BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if(isCameraSupport){
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
        imagepicker.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
        imagepicker.allowsEditing            = YES;
        imagepicker.delegate                 = self;
        [self presentViewController:imagepicker animated:YES completion:nil];
    }
}

//我的二维码
- (void)myQRCode {
    MyQRCodeViewController *myCode = [[MyQRCodeViewController alloc] initWithNibName:@"MyQRCodeViewController" bundle:nil];
    myCode.myUrlString = @"http://www.baidu.com";
    [self.navigationController pushViewController:myCode animated:YES];
}

//打开闪光灯
- (void)turnTorchOn:(BOOL)on {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark - 初始化
- (UIView *)QRBackView {
    if (!_QRBackView) {
        _QRBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _QRBackView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_QRBackView];
    }
    return _QRBackView;
}

- (void)initNav {
    self.navigationItem.title = @"二维码扫描";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)];
}


- (void)createFunctionView {
    if (_bottomItemsView) {
        return;
    }
    
    self.bottomItemsView             = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-100, CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:_bottomItemsView];
    
    CGSize size      = CGSizeMake(65, 87);
    self.btnFlash    = [[UIButton alloc]init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnPhoto    = [[UIButton alloc]init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnMyQR    = [[UIButton alloc]init];
    _btnMyQR.bounds = _btnFlash.bounds;
    _btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnMyQR setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
    [_btnMyQR setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
    [_btnMyQR addTarget:self action:@selector(myQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
    [_bottomItemsView addSubview:_btnMyQR];
}



@end
