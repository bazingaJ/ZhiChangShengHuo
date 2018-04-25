//
//  HCXiangmuTouziViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCXiangmuTouziViewController.h"
#import "HCTouziCell.h"
#import "HCXiangmuTouziDetailViewController.h"

@interface HCXiangmuTouziViewController () {
    NSString *status;
}

@end

@implementation HCXiangmuTouziViewController

- (HCSegmentTopView *)topView {
    if(!_topView) {
        _topView = [[HCSegmentTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_topView setDelegate:self];
    }
    return _topView;
}

- (void)viewDidLoad {
    if(!self.isHome) {
        [self setBottomH:49];
    }
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置参数
    status = @"2";
    
    self.tableView.tableHeaderView = [self topView];
    
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
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCTouziCell";
    HCTouziCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[HCTouziCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    HCTouziModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setTouziModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HCTouziModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    //跳转至详情
    HCXiangmuTouziDetailViewController *webView = [[HCXiangmuTouziDetailViewController alloc] init];
    if([model.buy_status isEqualToString:@"1"]) {
        //预热中
        [webView setTabH:45];
    }
    [webView setUrl:model.detail_url];
    [webView setTouziModel:model];
    [self.navigationController pushViewController:webView animated:YES];
}

/**
 *  Tab委托代理
 */
- (void)HCSegmentTopViewSegmentClick:(NSInteger)tIndex {
    NSLog(@"索引：%zd",tIndex);
    //1预热中 2新品 3完成
    switch (tIndex) {
        case 0:
            //进行中
            status = @"2";
            
            break;
        case 1:
            //预热中
            status = @"1";
            
            break;
        case 2:
            //已完成
            status = @"3";
            
            break;
            
        default:
            break;
    }
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"product" forKey:@"app"];
    [param setValue:@"getInvestList" forKey:@"act"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [param setValue:status forKey:@"status"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[HCTouziModel mj_objectWithKeyValues:itemDic]];
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
