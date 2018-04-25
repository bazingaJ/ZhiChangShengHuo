//
//  HCMineYuyueViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineYuyueViewController.h"
#import "RCSegmentView.h"
#import "HCMineYuyueEquityViewController.h"
#import "HCMineYuyueTouziViewController.h"

@interface HCMineYuyueViewController ()

@end

@implementation HCMineYuyueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的预约";
    
    //股权众筹
    HCMineYuyueEquityViewController *equityView =[[HCMineYuyueEquityViewController alloc] init];
    
    //投资项目
    HCMineYuyueTouziViewController *touziView = [[HCMineYuyueTouziViewController alloc] init];
    
    NSArray *controllers = @[touziView,equityView];
    
    NSArray *titleArr =@[@"投资项目",@"股权众筹"];
    RCSegmentView *segment = [[RCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) controllers:controllers titleArray:titleArr ParentController:self with:0];
    segment.segmentScrollV.scrollEnabled = NO;
    [self.view addSubview:segment];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
