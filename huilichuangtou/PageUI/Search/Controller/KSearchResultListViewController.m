//
//  KSearchResultListViewController.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "KSearchResultListViewController.h"
#import "HCEquityCell.h"
#import "HCXiangmuEquityDetailViewController.h"
#import "HCTouziCell.h"
#import "HCXiangmuTouziDetailViewController.h"

@interface KSearchResultListViewController ()

@end

@implementation KSearchResultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.type==1) {
        self.title = @"股权众筹";
    }else if(self.type==2) {
        self.title = @"投资项目";
    }
    
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
    if(self.type==1) {
        //股权众筹
        return 170;
    }else if(self.type==2) {
        //投资项目
        return 120;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.type) {
        case 1: {
            //股权众筹
            static NSString *cellIndentifier = @"HCEquitySearchCellEx";
            HCEquityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[HCEquityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
            HCEquityModel *model;
            if(self.dataArr.count) {
                model = [self.dataArr objectAtIndex:indexPath.section];
            }
            [cell setEquityModel:model];
            
            return cell;
            
            break;
        }
        case 2: {
            //投资项目
            static NSString *cellIndentifier = @"HCTouziCellEx";
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
            
            break;
        }
            
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.type) {
        case 1: {
            //股权众筹
            HCEquityModel *model;
            if(self.dataArr.count) {
                model = [self.dataArr objectAtIndex:indexPath.section];
            }
            if(!model) return;
            
            //跳转至详情
            HCXiangmuEquityDetailViewController *webView = [[HCXiangmuEquityDetailViewController alloc] init];
            if([model.buy_status isEqualToString:@"1"]) {
                //预热中
                [webView setTabH:45];
            }
            [webView setUrl:model.detail_url];
            [webView setEquityModel:model];
            [self.navigationController pushViewController:webView animated:YES];
            
            break;
        }
        case 2: {
            //投资项目
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
            
            break;
        }
            
        default:
            break;
    }
}

- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"search" forKey:@"act"];
    [param setValue:@(self.type) forKey:@"type"];
    [param setValue:self.searchStr forKey:@"title"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    if(self.type==1) {
                        //股权众筹
                        [self.dataArr addObject:[HCEquityModel mj_objectWithKeyValues:itemDic]];
                    }else if(self.type==2) {
                        //投资项目
                        [self.dataArr addObject:[HCTouziModel mj_objectWithKeyValues:itemDic]];
                    }
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
    
    
    [self endDataRefresh];
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
