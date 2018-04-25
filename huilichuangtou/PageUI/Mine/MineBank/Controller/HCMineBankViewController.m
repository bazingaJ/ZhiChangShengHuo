//
//  HCMineBankViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineBankViewController.h"
#import "HCMineBankCell.h"
#import "HCMineBankAddViewController.h"

@interface HCMineBankViewController ()

@end

@implementation HCMineBankViewController

- (void)viewDidLoad {
    [self setRightButtonItemImageName:@"mine_icon_bankadd"];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"银行卡";
    
}

/**
 *  添加银行卡事件
 */
- (void)rightButtonItemClick {
    NSLog(@"添加银行卡事件");
    HCMineBankAddViewController *addView = [[HCMineBankAddViewController alloc] init];
    addView.callBack = ^(HCBankModel *model) {
        [self.dataArr insertObject:model atIndex:0];
        
        if(self.dataArr.count==1) {
            [self.tableView.mj_header beginRefreshing];
        }else{
            //插入到第一行
            [self.tableView beginUpdates];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
            [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationRight];
            [self.tableView endUpdates];
        }
        
    };
    [self.navigationController pushViewController:addView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 10;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineBankCell";
    HCMineBankCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[HCMineBankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    HCBankModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setMineBankModel:model];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSLog(@"删除");
        
        HCBankModel *model;
        if(self.dataArr.count) {
            model = [self.dataArr objectAtIndex:indexPath.row];
        }
        if(!model) return;

        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"dropBankCard" forKey:@"act"];
        [param setValue:model.bank_id forKey:@"bank_id"];
        [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *msg = [json objectForKey:@"msg"];
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS]) {
                [MBProgressHUD showSuccess:@"删除成功" toView:self.view];

                [self.dataArr removeObject:model];

                //[self.dataArr removeObjectAtIndex:indexPath.section];
                
                //从界面上移除
                [self.tableView beginUpdates];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
                [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];

            }else{
                [MBProgressHUD showError:msg toView:self.view];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",[error description]);
        }];
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}

- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyBankList" forKey:@"act"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[HCBankModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
            
            //设置空白页面
            [self.tableView emptyViewShowWithDataType:ViewDataTypeLoadFail
                                              hasData:self.dataArr.count
                                          reloadBlock:nil];
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
