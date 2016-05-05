//
//  DNQRCodeReader.m
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNQRCodeReader.h"
@import AVFoundation;

@interface DNQRCodeReader () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation DNQRCodeReader

+ (DNQRCodeReader *)sharedReader {
    static DNQRCodeReader *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    for (AVMetadataObject *metadataObject in metadataObjects) {
        if (![metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            continue;
        }
        AVMetadataMachineReadableCodeObject *machineReadableCode = (AVMetadataMachineReadableCodeObject *)metadataObject;
        if ([self.delegate respondsToSelector:@selector(didDetectQRCode:)]) {
            [self.delegate didDetectQRCode:machineReadableCode];
        }
    }
}

#pragma mark - Public
- (void)startReaderOnView:(UIView *)view {
    NSError *error;
    AVCaptureDevice *captureDevice;
    for (AVCaptureDevice *aCaptureDevice in [AVCaptureDevice devices]) {
        if (aCaptureDevice.position == AVCaptureDevicePositionBack) {
            captureDevice = aCaptureDevice;
        }
    }
    if (!captureDevice) {
        NSLog(@"没有找到相机");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到相机,您的设备可能不支持此功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    AVCaptureDeviceInput *captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"error:%@", error);
        return;
    }
    self.captureSession               = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    if ([self.captureSession canAddInput:captureDeviceInput]) {
        [self.captureSession addInput:captureDeviceInput];
    }
    self.captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if ([self.captureSession canAddOutput:self.captureMetadataOutput]) {
        [self.captureSession addOutput:self.captureMetadataOutput];
    }
    self.captureMetadataOutput.metadataObjectTypes       = @[AVMetadataObjectTypeQRCode];
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    captureVideoPreviewLayer.videoGravity                = AVLayerVideoGravityResizeAspectFill;// AVLayerVideoGravityResizeAspect is default.
    captureVideoPreviewLayer.frame                       = view.bounds;
    [view.layer addSublayer:captureVideoPreviewLayer];
    [self.captureSession startRunning];
}

- (void)stopReader {
    [self.captureSession stopRunning];
}

- (void)startReader {
    [self.captureSession startRunning];
}

@end
