//
//  DNPlaySound.h
//  DNAppDemo
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface DNPlaySound : NSObject

+ (void)playSound:(NSString *)soundName callback:(void (^)())callback;

+ (void)playSound:(NSString *)soundName extension:(NSString *)extension callback:(void (^)())callback;

@end
