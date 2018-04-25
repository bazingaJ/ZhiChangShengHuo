//
//  HCJoinFundingViewController.m
//  huilichuangtou
//
//  Created by yunduopu-ios-2 on 2018/4/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "HCJoinFundingViewController.h"
#import "HCJoinFundingCell.h"
#import "HCJoinDetailViewController.h"

static NSString *currentTitle = @"我参与的众筹";

static NSString *const cellIdentifier = @"HCJoinFundingCell1";

@interface HCJoinFundingViewController ()

@end

@implementation HCJoinFundingViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.navigationItem.title = currentTitle;
    
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
#pragma mark - UITable View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HCJoinFundingCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //跳转至详情
    HCJoinDetailViewController *webView = [[HCJoinDetailViewController alloc] init];
    [webView setUrl:@"https://www.baidu.com"];
//    [webView setTouziModel:model];
    [self.navigationController pushViewController:webView animated:YES];
}

// 获取我参与的众筹列表
- (void)getDataList:(BOOL)isMore{
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"app"] = @"";
//    param[@"act"] = @"";
//    param[@""] = @"";
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
