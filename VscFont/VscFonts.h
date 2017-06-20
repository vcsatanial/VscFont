//
//  VscFonts.h
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/16.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VscFonts : NSObject<UIAlertViewDelegate>
+(void)vsc_fontWithPostScriptName:(NSString *)fontName
                          chsName:(NSString *)chsName
                         fontSize:(CGFloat)fontSize
                         complete:(void (^)(UIFont *font))complete
                          failure:(void (^)(NSError *error))failure;
+(void)vsc_fontWithPostScriptName:(NSString *)fontName
                          chsName:(NSString *)chsName
                         fontSize:(CGFloat)fontSize
                         progress:(void (^)(CGFloat progress))progress
                         complete:(void (^)(UIFont *font))complete
                          failure:(void (^)(NSError *error))failure;
@end
