//
//  DNPlaySound.m
//  DNAppDemo
//
//  Created by mainone on 16/5/30.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNPlaySound.h"

@implementation DNPlaySound

static void(^_callback)();

static void SoundFinished(SystemSoundID soundID, void *sample) {
    /*播放全部结束，因此释放所有资源 */
    AudioServicesDisposeSystemSoundID(soundID);
    CFRelease(sample);
    CFRunLoopStop(CFRunLoopGetCurrent());
    if (_callback) {
        _callback();
    }
    NSLog(@"callback");
}

+ (void)playSound:(NSString *)soundName extension:(NSString *)extension callback:(void (^)())callback {
    NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:extension];
    _callback = callback;
    SystemSoundID soundID;
    
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef) (url), &soundID);
    if (err) {
        if (_callback) {
            _callback();
        }
        NSLog(@"Error occurred assigning system sound!");
    } else {
        /*添加音频结束时的回调*/
        AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SoundFinished, (__bridge void *) (url));
        /*开始播放*/
        AudioServicesPlaySystemSound(soundID);
        CFRunLoopRun();
    }
}

+ (void)playSound:(NSString *)soundName callback:(void (^)())callback {
    [DNPlaySound playSound:soundName extension:@"mp3" callback:callback];
    
}

@end
