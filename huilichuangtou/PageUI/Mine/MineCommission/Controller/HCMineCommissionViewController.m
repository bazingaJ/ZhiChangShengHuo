//
//  HCMineCommissionViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineCommissionViewController.h"
#import "HCTotalCommissionViewController.h"
#import "HCReceivedCommissionViewController.h"
#import "HCCommissionModel.h"

@interface HCMineCommissionViewController () {
    HCCommissionModel *comsModel;
}

@end

@implementation HCMineCommissionViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的提成佣金";
    
    //获取我的佣金
    [self getMineCommission];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==1) {
        return 110;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineCommissionViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.row) {
        case 0: {
            //身份
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
            [lbMsg setText:[NSString stringWithFormat:@"身份：%@",comsModel.identity]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT15];
            [cell.contentView addSubview:lbMsg];
            
            //创建“分割线”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
            
            break;
        }
        case 1: {
            //创建“提成”
            for (int i=0; i<2; i++) {
                CGFloat tWidth = SCREEN_WIDTH/2;
            
                //创建“背景层”
                UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth, 110)];
                [cell.contentView addSubview:backView];
                
                if(i==0) {
                    //创建“总提成”
                    NSString *totalFee = @"0";
                    if(!IsStringEmpty(comsModel.charges_total_fee)) {
                        totalFee = comsModel.charges_total_fee;
                    }
                    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, tWidth-20, 20)];
                    [lbMsg setText:[NSString stringWithFormat:@"%.2f",[totalFee floatValue]]];
                    [lbMsg setTextColor:ORANGE_COLOR];
                    [lbMsg setTextAlignment:NSTextAlignmentCenter];
                    [lbMsg setFont:FONT17];
                    [backView addSubview:lbMsg];
                    
                    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, tWidth-20, 20)];
                    [lbMsg2 setText:@"总提成(元)"];
                    [lbMsg2 setTextColor:COLOR3];
                    [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
                    [lbMsg2 setFont:FONT13];
                    [backView addSubview:lbMsg2];
                    
                    //创建“查看明细”
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((tWidth-65)/2, 70, 65, 20)];
                    [btnFunc setTitle:@"查看明细" forState:UIControlStateNormal];
                    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btnFunc.titleLabel setFont:FONT12];
                    [btnFunc setBackgroundColor:ORANGE_COLOR];
                    [btnFunc.layer setCornerRadius:3.0];
                    [btnFunc setTag:100];
                    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                    [backView addSubview:btnFunc];
                    
                    //创建“分割线”
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tWidth-0.5, 0, 0.5, 110)];
                    [lineView setBackgroundColor:LINE_COLOR];
                    [backView addSubview:lineView];
                }else if(i==1) {
                    
                    for (int k=0; k<2; k++) {
                        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth, 55*k, tWidth, 55)];
                        [cell.contentView addSubview:backView];
                        
                        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
                        //[lbMsg setText:[NSString stringWithFormat:@"%.2f",[dealFee floatValue]]];
                        [lbMsg setTextColor:ORANGE_COLOR];
                        [lbMsg setTextAlignment:NSTextAlignmentCenter];
                        [lbMsg setFont:FONT15];
                        [backView addSubview:lbMsg];
                        
                        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 100, 15)];
                        if(k==0) {
                            [lbMsg2 setText:@"总领取(元)"];
                            
                            NSString *dealFee = @"0";
                            if(!IsStringEmpty(comsModel.charges_deal_fee)) {
                                dealFee = comsModel.charges_deal_fee;
                            }
                            [lbMsg setText:[NSString stringWithFormat:@"%.2f",[dealFee floatValue]]];
                            
                        }else if(k==1) {
                            [lbMsg2 setText:@"待领取(元)"];
                            
                            NSString *yetFee = @"0";
                            if(!IsStringEmpty(comsModel.charges_yet_fee)) {
                                yetFee = comsModel.charges_yet_fee;
                            }
                            [lbMsg setText:[NSString stringWithFormat:@"%.2f",[yetFee floatValue]]];
                        }
                        [lbMsg2 setTextColor:COLOR3];
                        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
                        [lbMsg2 setFont:FONT11];
                        [backView addSubview:lbMsg2];
                        
                        
                        if(k==0) {
                            //创建“查看明细”
                            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(100, 17.5, 65, 20)];
                            [btnFunc setTitle:@"查看明细" forState:UIControlStateNormal];
                            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            [btnFunc.titleLabel setFont:FONT12];
                            [btnFunc setBackgroundColor:ORANGE_COLOR];
                            [btnFunc.layer setCornerRadius:3.0];
                            [btnFunc setTag:101];
                            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                            [backView addSubview:btnFunc];
                            
                            //创建“分割线”
                            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, tWidth, 0.5)];
                            [lineView setBackgroundColor:LINE_COLOR];
                            [backView addSubview:lineView];
                        }
                    }
                    
                }
            }
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

/**
 *  功能按钮点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"功能按钮点击事件");
    if(btnSender.tag==100) {
        //总提成
        HCTotalCommissionViewController *totalView = [[HCTotalCommissionViewController alloc] init];
        [self.navigationController pushViewController:totalView animated:YES];
    }else if(btnSender.tag==101) {
        //已领取
        HCReceivedCommissionViewController *receivedView = [[HCReceivedCommissionViewController alloc] init];
        [self.navigationController pushViewController:receivedView animated:YES];
    }
}

/**
 *  获取我的佣金
 */
- (void)getMineCommission {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyCharges" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            comsModel = [HCCommissionModel mj_objectWithKeyValues:dataDic];
            
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
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
