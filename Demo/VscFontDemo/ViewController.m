//
//  ViewController.m
//  VscFontDemo
//
//  Created by VincentChou on 2017/6/13.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "ViewController.h"
#import "ShowFontViewController.h"
#import "VscFonts.h"
#import "UITableViewCell+Progress.h"

static NSString *cellID= @"tableViewID";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    [self initializeData];
    [self createTableView];
}
-(void)initializeData{
    fontArray = @[
                  @[@"STSongti-SC-Regular"  ,   @"宋体"],
                  @[@"STSong"               ,   @"华文宋体"],
                  @[@"STFangsong"           ,   @"华文仿宋"],
                  @[@"STHeitiSC-Medium"     ,   @"黑体"],
                  @[@"STHeiti"              ,   @"华文黑体"],
                  @[@"HiraginoSansGB-W3"    ,   @"冬青黑体"],
                  @[@"STKaiti-SC-Regular"   ,   @"楷体"],
                  @[@"STKaiti"              ,   @"华文楷体"],
                  @[@"STXingkai-SC-Regular" ,   @"行楷"],
                  @[@"STLibian-SC-Regular"  ,   @"隶变"],
                  @[@"STBaoli-SC-Regular"   ,   @"华文报隶"],
                  @[@"HanziPenSC-W3"        ,   @"翩翩体"],
                  @[@"DFWaWaSC-W5"          ,   @"娃娃体"],
                  @[@"FZLTXHK--GBK1-0"      ,   @"兰亭"],
                  @[@"HannotateSC-W5"       ,   @"手札体"],
                  @[@"STYuanti-SC-Regular"  ,   @"圆体"],
                  @[@"Weibei-SC-Regular"    ,   @"魏碑"],
                  @[@"YuppySC-Regular"      ,   @"雅痞"],
                  @[@"LiHeiPro"             ,   @"丽黑Pro"],
                  ];
    doneImage = [UIImage imageNamed:@"apple.png"];
    undoneImage = [UIImage imageNamed:@"second.png"];
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:_tableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return fontArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSString *fontName = fontArray[indexPath.row][0];
    cell.textLabel.text = fontArray[indexPath.row][1];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [VscFonts vsc_fontWithPostScriptName:fontName
                                 chsName:fontArray[indexPath.row][1]
                                fontSize:18
                                progress:^(CGFloat progress) {
                                    cell.progressView.progress = progress / 100.f;
                                } complete:^(UIFont *font) {
                                    cell.textLabel.font = font;
                                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                                    cell.progressView.hidden = YES;
                                } failure:^(NSError *error) {
                                }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowFontViewController *showViewCtrl = [[ShowFontViewController alloc] init];
    showViewCtrl.fontName = fontArray[indexPath.row][0];
    showViewCtrl.title = fontArray[indexPath.row][1];
    [self.navigationController pushViewController:showViewCtrl animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
