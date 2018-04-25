//
//  HCLaunchProjectViewController.m
//  huilichuangtou
//
//  Created by yunduopu-ios-2 on 2018/4/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "HCLaunchProjectViewController.h"
#import "HCLaunchProjectCell.h"

static NSString *currentTitle = @"我发起的众筹";

static NSString *const cellIdentifier = @"";

@interface HCLaunchProjectViewController ()

@end

@implementation HCLaunchProjectViewController

- (void)viewDidLoad {
    
    self.rightButtonItemTitle = @"发起众筹";
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    
}

#pragma mark - UITable View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 230.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HCLaunchProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HCLaunchProjectCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
