//
//  VscFonts.m
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/16.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "VscFonts.h"
#import "VscFontDownloadNet.h"
#import <CoreText/CoreText.h>
dispatch_semaphore_t semaphore;
BOOL needToReask = NO;
@implementation VscFonts
+(UIFont *)existFontWithPostScriptName:(NSString *)fontName
                              fontSize:(CGFloat)fontSize{
    UIFont *aFont = [UIFont fontWithName:fontName size:fontSize];
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        return aFont;
    }
    return nil;
}
+(void)vsc_fontWithPostScriptName:(NSString *)fontName
                          chsName:(NSString *)chsName
                         fontSize:(CGFloat)fontSize
                         complete:(void (^)(UIFont *font))complete
                          failure:(void (^)(NSError *error))failure{
    [self vsc_fontWithPostScriptName:fontName chsName:chsName fontSize:fontSize progress:nil complete:complete failure:failure];
}
+(void)vsc_fontWithPostScriptName:(NSString *)fontName
                          chsName:(NSString *)chsName
                         fontSize:(CGFloat)fontSize
                         progress:(void (^)(CGFloat progress))progress
                         complete:(void (^)(UIFont *font))complete
                          failure:(void (^)(NSError *error))failure{
    if (!complete) {
        return;
    }
    UIFont *existFont = [self existFontWithPostScriptName:fontName fontSize:fontSize];
    if (existFont) {
        complete(existFont);
        return;
    }
    //用字体的PostScript名字创建一个Dictionary
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    // 创建一个字体描述对象CTFontDescriptorRef
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    //将字体描述对象放到一个NSMutableArray中
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    //开始对字体进行下载
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        CGFloat progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] floatValue];
        
        switch (state) {
            case kCTFontDescriptorMatchingDidBegin:{//字体已经匹配
                
            }
                break;
            case kCTFontDescriptorMatchingDidFinish:{//字体下载完成
                if (!errorDuringDownload) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
                        complete(font);
                    });
                }
            }
                break;
            case kCTFontDescriptorMatchingWillBeginDownloading:{//字体开始下载
                if ([VscFontDownloadNet checkCurrentNetWork] != NetWorkWifi) {
                    [self downloadAlertWithPostScriptName:fontName chsName:chsName];
                    if (needToReask) {
                        needToReask = NO;
                        errorDuringDownload = YES;
                        return NO;
                    }
                }
            }
                break;
            case kCTFontDescriptorMatchingDidFinishDownloading:{//字体下载完成
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
                    complete(font);
                });
            }
                break;
            case kCTFontDescriptorMatchingDownloading:{//下载进度
                if (progress) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        progress(progressValue);
                    });
                }
            }
                break;
            case kCTFontDescriptorMatchingDidFailWithError:{//下载失败
                NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
                if (!error) {
                    error = [NSError errorWithDomain:@"ERROR MESSAGE IS NOT AVAILABLE" code:102 userInfo:nil];
                }
                errorDuringDownload = YES;
                if (failure) {
                    failure(error);
                }
            }
                break;
            default:
                break;
        }
        return (bool)YES;
    });
}
+(void)downloadAlertWithPostScriptName:(NSString *)fontName chsName:(NSString *)chsName{
    semaphore = dispatch_semaphore_create(0);
    NSString *title = @"下载字体";
    NSMutableString *message = [[NSMutableString alloc] initWithCapacity:0];
    if (chsName) {
        [message appendString:chsName];
        if (fontName) {
            [message appendFormat:@"(%@)",fontName];
        }
    }
    [message appendFormat:@"字体要在非WIFI状态下载么?"];
    if ([[UIDevice currentDevice].systemVersion integerValue] >= 8.0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_semaphore_signal(semaphore);
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_semaphore_signal(semaphore);
            needToReask = YES;
        }];
        [alertCtrl addAction:confirm];
        [alertCtrl addAction:cancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertCtrl animated:YES completion:nil];
        });
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        dispatch_semaphore_signal(semaphore);
    }else{
        dispatch_semaphore_signal(semaphore);
        needToReask = YES;
    }
}

@end
