//
//  ViewController.h
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/13.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIImage *doneImage;
    UIImage *undoneImage;
    NSArray *fontArray;
    UITableView *_tableView;
}
@end

