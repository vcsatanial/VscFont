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

/**
 根据PostScriptName在Block中获取到Font
 
 @param fontName 字体的PostScriptName
 @param chsName 中文名称(如果有的话  出现alert时会展示,也会展示上面的fontName)
 @param fontSize 字体大小
 @param complete 得到font的block
 @param failure 未能得到font的block
 */
+(void)vsc_fontWithPostScriptName:(NSString *)fontName
                          chsName:(NSString *)chsName
                         fontSize:(CGFloat)fontSize
                         complete:(void (^)(UIFont *font))complete
                          failure:(void (^)(NSError *error))failure;

/**
 根据PostScriptName在Block中获取到Font

 @param fontName 字体的PostScriptName
 @param chsName 中文名称(如果有的话  出现alert时会展示,也会展示上面的fontName)
 @param fontSize 字体大小
 @param progress 如果需要下载的话,返回下载进度
 @param complete 得到font的block
 @param failure 未能得到font的block
 */
+(void)vsc_fontWithPostScriptName:(NSString *)fontName
                          chsName:(NSString *)chsName
                         fontSize:(CGFloat)fontSize
                         progress:(void (^)(CGFloat progress))progress
                         complete:(void (^)(UIFont *font))complete
                          failure:(void (^)(NSError *error))failure;
@end
