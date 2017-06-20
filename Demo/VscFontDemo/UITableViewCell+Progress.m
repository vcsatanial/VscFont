//
//  UITableViewCell+Progress.m
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/19.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "UITableViewCell+Progress.h"
#import <objc/runtime.h>

@implementation UITableViewCell (Progress)
-(UIProgressView *)progressView{
    static NSString *kAssociateKey = nil;
    UIProgressView *progressView = objc_getAssociatedObject(self, &kAssociateKey);
    if (!progressView) {
        progressView = [[UIProgressView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 150, 12, 130, 0)];
        progressView.transform = CGAffineTransformMakeScale(1, 15);
        progressView.progressViewStyle = UIProgressViewStyleDefault;
        progressView.progressTintColor = [UIColor greenColor];
        progressView.trackTintColor = [UIColor redColor];
        [self.contentView addSubview:progressView];
        objc_setAssociatedObject(self, &kAssociateKey, progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return progressView;
}
@end
