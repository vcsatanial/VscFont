//
//  VscFontDownloadNet.h
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/19.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NetWork2G,
    NetWork3G,
    NetWork4G,
    NetWorkWifi,
    NetWorkUnknown
}NetStatus;
@interface VscFontDownloadNet : NSObject
+(NetStatus)checkCurrentNetWork;
@end
