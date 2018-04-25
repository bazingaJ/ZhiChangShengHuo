//
//  HCMineTouziEquityViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineTouziEquityViewController.h"

@interface HCMineTouziEquityViewController ()

@end

@implementation HCMineTouziEquityViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineTouziEquityCell";
    HCMineTouziEquityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[HCMineTouziEquityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    HCMineTouziEquityModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setDelegate:self];
    [cell setMineTouziEquityModel:model indexPath:indexPath];
    
    return cell;
}

/**
 *  股权投资-委托代理
 */
- (void)HCMineTouziEquityCellClick:(HCMineTouziEquityModel *)model indexPath:(NSIndexPath *)indexPath {
    NSLog(@"股权投资-委托代理");
    
    if(IsStringEmpty(model.contract_url)) {
        [MBProgressHUD showError:@"暂无合同" toView:self.view];
        return;
    }
    
    //查看合同
    HCWKWebViewController *webView = [[HCWKWebViewController alloc] init];
    [webView setTitle:@"合同详情"];
    [webView setUrl:model.contract_url];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyCrowdFundingList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[HCMineTouziEquityModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];

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
