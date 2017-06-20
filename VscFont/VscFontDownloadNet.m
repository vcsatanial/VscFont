//
//  VscFontDownloadNet.m
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/19.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "VscFontDownloadNet.h"
#import <UIKit/UIKit.h>
@implementation VscFontDownloadNet
+(NetStatus)checkCurrentNetWork{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *children = [[[application valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    NSInteger netType = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            netType = [[child valueForKeyPath:@"dataNetworkType"] integerValue];
            break;
        }
    }
    switch (netType) {
        case 1:
            return NetWork2G;
            break;
        case 2:
            return NetWork3G;
            break;
        case 3:
            return NetWork4G;
            break;
        case 5:
            return NetWorkWifi;
            break;
            
        default:
            return NetWorkUnknown;
            break;
    }
}
@end
