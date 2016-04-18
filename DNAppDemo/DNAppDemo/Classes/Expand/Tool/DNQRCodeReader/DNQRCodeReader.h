//
//  DNQRCodeReader.h
//  DNAppDemo
//
//  Created by mainone on 16/4/18.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVMetadataMachineReadableCodeObject;

@protocol DNQRCodeReaderDelegate <NSObject>

@optional
- (void)didDetectQRCode:(AVMetadataMachineReadableCodeObject *)qrCode;

@end

@interface DNQRCodeReader : NSObject

@property (nonatomic, weak) id<DNQRCodeReaderDelegate>delegate;

+ (DNQRCodeReader *)sharedReader;

- (void)startReaderOnView:(UIView *)view;
- (void)stopReader;

@end
