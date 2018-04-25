//
//  HCMineIncomeViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/31.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineIncomeViewController.h"
#import "HCMineIncomeCell.h"
#import "HCMineIncomeTopView.h"

@interface HCMineIncomeViewController ()

@property (nonatomic, strong) HCMineIncomeTopView *topView;

@end

@implementation HCMineIncomeViewController

- (HCMineIncomeTopView *)topView {
    if(!_topView) {
        _topView = [[HCMineIncomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收益";
    
    self.tableView.tableHeaderView = [self topView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 45)];
    [backView2 setBackgroundColor:[UIColor whiteColor]];
    [backView addSubview:backView2];
    
    NSArray *titleArr = @[@"时间",@"项目名称",@"金额"];
    
    CGFloat tWidth = SCREEN_WIDTH/3;
    for (int i=0; i<3; i++) {
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(tWidth*i, 10, tWidth, 25)];
        [lbMsg setText:[titleArr objectAtIndex:i]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT15];
        [backView2 addSubview:lbMsg];
    }
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [backView2 addSubview:lineView];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineIncomeCell";
    HCMineIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[HCMineIncomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    HCMineIncomeModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setMineIncomeModel:model];
    
    return cell;
}

- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyProfit" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            
            //总收益
            NSString *total_fee = [dataDic objectForKey:@"total_fee"];
            [self.topView.lbMsgTotal setText:total_fee];
            
            //收益明细
            NSArray *dataList = [dataDic objectForKey:@"list"];
            self.dataArr = [HCMineIncomeModel mj_objectArrayWithKeyValuesArray:dataList];
            
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
