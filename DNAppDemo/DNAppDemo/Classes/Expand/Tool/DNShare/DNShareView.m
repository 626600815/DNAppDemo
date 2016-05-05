//
//  DNShareView.m
//  MobileApp
//
//  Created by mainone on 16/2/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNShareView.h"
#import "TypeButtonCell.h"
#import "ShareModel.h"
#import "MJExtension.h"
#import "OpenShareHeader.h"
#import <MessageUI/MessageUI.h>

#define SHARE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SHARE_WIDTH [UIScreen mainScreen].bounds.size.width

@interface DNShareView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TypeButtonCellDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIView *shareView;/**<分享的底部容器*/
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSMutableArray *dataArray;

@property (nonatomic, strong) MFMessageComposeViewController * smsController;

@end

@implementation DNShareView

- (instancetype)initWithShare {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SHARE_WIDTH, SHARE_HEIGHT);
        //设置背景透明层
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        __block typeof(self) bself = self;
        [self addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [bself tappedCancel];
        }];
        [self loadList];
    }
    return self;
}

#pragma mark - 加载界面资源
- (void)loadList {
    
    BOOL QQPass = NO;
    BOOL WeiPass = NO;

    NSArray *tempArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"SharePlist.plist" ofType:nil]];
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSDictionary *dict in tempArr) {
        if (WeiPass) {
            if ([[dict objectForKey:@"title"] isEqualToString:@"微信"] || [[dict objectForKey:@"title"] isEqualToString:@"微信朋友圈"]) {
                continue;
            }
        }
        if (QQPass) {
            if ([[dict objectForKey:@"title"] isEqualToString:@"QQ"] || [[dict objectForKey:@"title"] isEqualToString:@"QQ空间"]) {
                continue;
            }
        }
        ShareModel *shareM = [ShareModel mj_objectWithKeyValues:dict];
        [muArr addObject:shareM];
    }
    [self.dataArray addObjectsFromArray:muArr];
    [self createUIWithCount:self.dataArray.count];
}

#pragma mark - 创建分享界面
- (void)createUIWithCount:(NSInteger)count {
    CGFloat shareHeight = SHARE_WIDTH/2 + 55;
    if (count <= 4) {//个数不足4个的界面少一排
        shareHeight = SHARE_WIDTH/4 + 55;
    }
    
    //分享的底部容器
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, SHARE_HEIGHT, SHARE_WIDTH, shareHeight)];
    self.shareView.backgroundColor = [UIColor colorWithWholeRed:245 green:245 blue:245 alpha:1];
    [self.shareView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    [self addSubview:self.shareView];
    [UIView animateWithDuration:.25 animations:^{
        self.shareView.y = SHARE_HEIGHT - shareHeight;
    }];
    
    [self.collectionView registerClass:[TypeButtonCell class] forCellWithReuseIdentifier:@"cell"];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, shareHeight - 55 + 8, SCREEM_WIDTH, 55);
    cancelButton.backgroundColor = [UIColor colorWithWholeRed:150 green:150 blue:150 alpha:1];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self tappedCancel];
    }];
    [self.shareView addSubview:cancelButton];

}

#pragma mark - 显示视图
- (void)showInView:(UIView *)view {
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

#pragma mark - 取消收回视图
- (void)tappedCancel {
    [UIView animateWithDuration:.25 animations:^{
        self.shareView.y = SHARE_HEIGHT;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    TypeButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    ShareModel *shareM = [self.dataArray objectAtIndex:indexPath.item];
    cell.titleName = shareM.title;
    cell.imageName= shareM.image;
    cell.delegete = self;
  
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SHARE_WIDTH/4, SHARE_WIDTH/4);
}

#define mark - TypeButtonCellDelegate
- (void)clickButtonWithName:(NSString *)name {
    [self tappedCancel];
    
    if ([name isEqualToString:@"复制链接"]) {
        if (self.myCopyUrl.length != 0) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.myCopyUrl;
            [MBProgressHUD showSuccess:@"复制成功"];
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前拷贝地址为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        return;
    }
    
    if ([name isEqualToString:@"二维码保存"]) {
        if (self.erweimaUrl.length != 0) {
            UIImage *image = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:self.erweimaUrl] withSize:200];
            UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有找到对应的二维码信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        return;
    }
    
    //设置分享的内容
    OSMessage *msg = [[OSMessage alloc] init];
    msg.title      = self.titleName;
    msg.desc       = self.showtext;
    msg.link       = self.contentUrl;
    msg.image      = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.showImageUrl]]];

    if ([name isEqualToString:@"微信"]) {
        if (![OpenShare isWeixinInstalled]) {
            [self alertViewWithName:@"微信"];
            return;
        }
        [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
            [MBProgressHUD showSuccess:@"分享成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            [MBProgressHUD showError:@"分享失败"];
        }];
        
    } else if ([name isEqualToString:@"微信朋友圈"]) {
        if (![OpenShare isWeixinInstalled]) {
            [self alertViewWithName:@"微信"];
            return;
        }
        [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
            [MBProgressHUD showSuccess:@"分享成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            [MBProgressHUD showError:@"分享失败"];
        }];
    } else if ([name isEqualToString:@"QQ"]) {
        if (![OpenShare isQQInstalled]) {
            [self alertViewWithName:@"QQ"];
            return;
        }
        [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
            [MBProgressHUD showSuccess:@"分享成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            [MBProgressHUD showError:@"分享失败"];
        }];
    } else if ([name isEqualToString:@"QQ空间"]) {
        if (![OpenShare isQQInstalled]) {
            [self alertViewWithName:@"QQ"];
            return;
        }
        [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
            [MBProgressHUD showSuccess:@"分享成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            [MBProgressHUD showError:@"分享失败"];
        }];
        
    } else if ([name isEqualToString:@"新浪微博"]) {
        if (![OpenShare isWeiboInstalled]) {
            [self alertViewWithName:@"微博"];
            return;
        }
        msg.title = [NSString stringWithFormat:@"%@ %@",msg.title,msg.link];
        msg.link = nil;
        [OpenShare shareToWeibo:msg Success:^(OSMessage *message) {
            [MBProgressHUD showSuccess:@"分享成功"];
        } Fail:^(OSMessage *message, NSError *error) {
             [MBProgressHUD showError:@"分享失败"];
        }];
    } else if ([name isEqualToString:@"短信"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showMessageWithtitle:@"分享给好友" body:self.contentUrl];
        });
        
    }
}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(!error){
        [MBProgressHUD showSuccess:@"保存成功"];
    }else{
        [MBProgressHUD showError:@"保存失败"];
    }
}

-(void)showMessageWithtitle:(NSString *)title body:(NSString *)body {
    if( [MFMessageComposeViewController canSendText]) {
        self.smsController.body = body;
        [[self getSuperViewController] presentViewController:self.smsController animated:YES completion:nil];
        [[[[self.smsController viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
        //不知道为什么我的取消按钮没了
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(smsCancelClick:)];
        [[[[self.smsController viewControllers] lastObject] navigationItem] setRightBarButtonItem:rightItem];//修改短信界面标题
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - MFMessageComposeViewController
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"发送成功"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"发送失败"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"发送取消"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}

- (void)smsCancelClick:(UIBarButtonItem *)item {
    [self.smsController dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"发送取消"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
}


//提醒没有安装客户端
- (void)alertViewWithName:(NSString *)nameStr {
    NSString *msg       = [NSString stringWithFormat:@"没有安装%@客户端",nameStr];
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提醒" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertV show];
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
        flowlayout.minimumLineSpacing           = 0;
        flowlayout.minimumInteritemSpacing      = 0;
        
        _collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SHARE_WIDTH, SHARE_WIDTH/2) collectionViewLayout:flowlayout];
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.backgroundColor                = [UIColor colorWithWholeRed:245 green:245 blue:245 alpha:1];
        _collectionView.pagingEnabled                  = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.shareView addSubview:_collectionView];
    }
    return _collectionView;
}

- (MFMessageComposeViewController *)smsController {
    if (!_smsController) {
        _smsController = [[MFMessageComposeViewController alloc] init];
        _smsController.messageComposeDelegate = self;
    }
    return _smsController;
}

#pragma mark - InterpolatedUIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent          = CGRectIntegral(image.extent);
    CGFloat scale          = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width           = CGRectGetWidth(extent) * scale;
    size_t height          = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs     = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context     = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark - QRCodeGenerator
- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    return qrFilter.outputImage;
}


@end
