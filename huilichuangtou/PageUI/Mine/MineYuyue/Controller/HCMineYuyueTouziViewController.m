//
//  HCMineYuyueTouziViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineYuyueTouziViewController.h"

@interface HCMineYuyueTouziViewController ()

@end

@implementation HCMineYuyueTouziViewController

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
    HCTouziOrderModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineYuyueTouziCell";
    HCMineYuyueTouziCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[HCMineYuyueTouziCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    HCTouziOrderModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setDelegate:self];
    [cell setTouziOrderModel:model indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HCTouziOrderModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    //项目详情
    HCWKWebViewController *webView = [[HCWKWebViewController alloc] init];
    [webView setTitle:@"项目详情"];
    [webView setUrl:model.detail_url];
    [self.navigationController pushViewController:webView animated:YES];
}

/**
 *  取消预约、修改金额委托代理
 */
- (void)HCMineYuyueTouziCellClick:(HCTouziOrderModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath {
    NSLog(@"取消预约、修改金额委托代理:%zd",tIndex);
    
    switch (tIndex) {
        case 0: {
            NSLog(@"取消预约");
            
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要取消预约吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了确定按钮");
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"cancelInvest" forKey:@"act"];
                [param setValue:model.order_id forKey:@"order_id"];
                [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *msg = [json objectForKey:@"msg"];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        [MBProgressHUD showError:@"取消预约成功" toView:self.view];
                        
                        //设置取消状态
                        model.status = @"7";
                        
                        [self.tableView beginUpdates];
                        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
                        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                    }else{
                        [MBProgressHUD showError:msg toView:self.view];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                }];
                
            }];
            [aler addAction:cancelAction];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
            
            break;
        }
        case 1: {
            NSLog(@"修改投资金额");
            
            HCUpdateYuyuePopupView *popupView = [[HCUpdateYuyuePopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, 0, 280, 220)
                                                                                        model:model
                                                                                    indexPath:indexPath];
            popupView.delegate = self;
            self.popup = [KLCPopup popupWithContentView:popupView
                                               showType:KLCPopupShowTypeGrowIn
                                            dismissType:KLCPopupDismissTypeGrowOut
                                               maskType:KLCPopupMaskTypeDimmed
                               dismissOnBackgroundTouch:YES
                                  dismissOnContentTouch:NO];
            [self.popup show];
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  修改预约金额的委托代理
 */
- (void)HCUpdateYuyuePopupViewClick:(HCTouziOrderModel *)model
                          indexPath:(NSIndexPath *)indexPath
                             tIndex:(NSInteger)tIndex
                           totalFee:(NSString *)totalFee {
    NSLog(@"修改预约金额的委托代理");
    
    [self.popup dismiss:YES];
    
    if(tIndex==1) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"editInvest" forKey:@"act"];
        [param setValue:model.order_id forKey:@"order_id"];
        [param setValue:totalFee forKey:@"total_fee"];
        [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *msg = [json objectForKey:@"msg"];
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS]) {
                [MBProgressHUD showSuccess:@"修改预约金额成功" toView:self.view];
                
                //设置新投资金额
                model.total_fee = totalFee;
                
                //刷新
                [self.tableView beginUpdates];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
                
            }else{
                [MBProgressHUD showError:msg toView:self.view];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",[error description]);
        }];
    }
    
}

- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getResListOfInvest" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[HCTouziOrderModel mj_objectWithKeyValues:itemDic]];
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
