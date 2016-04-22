//
//  DNActionSheetManager.m
//  DNAppDemo
//
//  Created by mainone on 16/4/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNActionSheetManager.h"
#import "DNActionSheet.h"

#define ImagePicker_Title @"选取图片"

@interface DNActionSheetManager () <DNActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) DNClickIndex indexBlock;
@property (nonatomic, strong) DNSelectImage imageBlock;

@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation DNActionSheetManager

+ (DNActionSheetManager *)shareActionSheet {
    static DNActionSheetManager *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[DNActionSheetManager alloc] init];
    });
    return manage;
}

- (void)showImagePickerWithVC:(UIViewController *)VC selectImage:(DNSelectImage)image {
    self.imageBlock = [image copy];
    self.currentVC = VC;
    DNActionSheet *sheet = [[DNActionSheet alloc] initWithTitle:ImagePicker_Title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选取", nil];
    [sheet show];
}

- (void)showLogoutWithIndex:(DNClickIndex)index {
    
    self.indexBlock = [index copy];
    DNActionSheet *sheet = [[DNActionSheet alloc] initWithTitle:@"是否退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出登录", nil];
    [sheet setButtonTitleColor:[UIColor redColor] bgColor:nil fontSize:0 atIndex:0];
    [sheet show];
}


#pragma mark - DNActionSheetDelegate
- (void)actionSheet:(DNActionSheet *)sheet clickedButtonIndex:(NSInteger)buttonIndex {
    if (_indexBlock) {
        _indexBlock(buttonIndex);
        _indexBlock = nil;
    }
    
    //选取图片的
    if ([sheet.title isEqualToString:ImagePicker_Title]) {
        [self selectImageWithIndex:buttonIndex];
    }
    
}

#pragma mark - 拍照，选相册
- (void)selectImageWithIndex:(NSInteger)index {
    switch (index) {
        case 0://拍照
        {
            BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            if(isCameraSupport){
                UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
                imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagepicker.allowsEditing = YES;
                imagepicker.delegate = self;
                [self.currentVC presentViewController:imagepicker animated:YES completion:nil];
            }
            
        }
            break;
        case 1://相册
        {
            BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
            if(isCameraSupport){
                UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
                imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagepicker.allowsEditing = YES;
                imagepicker.delegate = self;
                [self.currentVC presentViewController:imagepicker animated:YES completion:nil];
            }
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        if (_imageBlock) {
            _imageBlock(image);
            _imageBlock = nil;
        }
    }];
}



@end
