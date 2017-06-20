//
//  UITableViewCell+Progress.h
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/19.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Progress)
@property (nonatomic,strong,readonly) UIProgressView *progressView;
-(UIProgressView *)progressView;
@end
