//
//  HCMineViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineViewController.h"
#import "HCMineMessageViewController.h"
#import "HCMineInfoViewController.h"
#import "HCMineYuyueViewController.h"
#import "HCMineTouziViewController.h"
#import "HCMineBankViewController.h"
#import "HCMineSettingViewController.h"
#import "HCMineCommissionViewController.h"
#import "HCMineIncomeViewController.h"
#import "HCUserModel.h"
#import "HCJoinFundingViewController.h"
#import "HCLaunchProjectViewController.h"

@interface HCMineViewController () {
    HCUserModel *userModel;
}

@end

@implementation HCMineViewController

- (HCMineTopView *)topView {
    if(!_topView) {
        _topView = [[HCMineTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _topView.delegate = self;
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setLeftButtonItemHidden:YES];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.navigationItem.title = @"";
    
    //去除导航分割线
    
    [self setupUI];
    //菜单数据
    if(APP_DELEGATE.isOK) {
        
        [self.dataArr addObject:@[@[@"投资人00",@"我参与的众筹",@"0"],
                                  @[@"组10拷贝",@"我发起的众筹",@"1"]]];
        
        [self.dataArr addObject:@[@[@"消息",@"我的消息",@"2"]]];
        
//        [self.dataArr addObject:@[@"mine_icon_yuyue",@"我的预约",@"0"]];
//        [self.dataArr addObject:@[@"mine_icon_touzi",@"我的投资",@"1"]];
//        [self.dataArr addObject:@[@"mine_icon_ticheng",@"我的提成佣金",@"2"]];
//        [self.dataArr addObject:@[@"mine_icon_income",@"我的收益",@"6"]];
//        [self.dataArr addObject:@[@"mine_icon_bank",@"我的银行卡",@"3"]];
    }
    
    [self.dataArr addObject:@[@[@"设置",@"设置",@"3"]]];
    
    self.tableView.tableHeaderView = [self topView];
    self.tableView.bounces = NO;

}
- (void)setupUI
{
    self.tableView.frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = UIColor.clearColor;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    //获取个人信息
    [self getUserInfo];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.dataArr[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *itemArr = [self.dataArr objectAtIndex:indexPath.section];
    
    //创建“图标”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10.5, 22, 24)];
    [imgView setImage:[UIImage imageNamed:itemArr[indexPath.row][0]]];
    [imgView sizeToFit];
    imgView.centerY = 22.5;
    [cell.contentView addSubview:imgView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-60, 25)];
    [lbMsg setText:itemArr[indexPath.row][1]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    //创建“右侧尖头”
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
    [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
    [cell.contentView addSubview:imgView2];
    
    //创建“分割线”
    if(indexPath.row<[self.dataArr count]-1) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:^(NSInteger tIndex) {
        NSLog(@"回调成功");
        [self getUserInfo];
    }]) return;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HCJoinFundingViewController *vc = [[HCJoinFundingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            HCLaunchProjectViewController *touziView = [[HCLaunchProjectViewController alloc] init];
            [self.navigationController pushViewController:touziView animated:YES];
        }
    }else if (indexPath.section == 1){
        // 我的消息
        HCMineMessageViewController *messageView = [[HCMineMessageViewController alloc] init];
        [self.navigationController pushViewController:messageView animated:YES];
    }else{
        // 设置
        HCMineSettingViewController *settingView = [[HCMineSettingViewController alloc] init];
        [self.navigationController pushViewController:settingView animated:YES];
    }
    
//    NSArray *itemArr = [self.dataArr objectAtIndex:indexPath.row];
    
//    switch ([itemArr[indexPath.row][2] integerValue]) {
//        case 0: {
////            NSLog(@"我的预约");
////            HCMineYuyueViewController *yuyueView = [[HCMineYuyueViewController alloc] init];
////            [self.navigationController pushViewController:yuyueView animated:YES];
//            // 我参与的众筹
//
//
//            break;
//        }
//        case 1: {
////            NSLog(@"我的投资");
////            HCMineTouziViewController *touziView = [[HCMineTouziViewController alloc] init];
////            [self.navigationController pushViewController:touziView animated:YES];
//
//            // 我发起的众筹
//
//
//            break;
//        }
//        case 2: {
////            NSLog(@"我的提成佣金");
////            HCMineCommissionViewController *cissView = [[HCMineCommissionViewController alloc] init];
////            [self.navigationController pushViewController:cissView animated:YES];
//
//
//
//            break;
//        }
//        case 3: {
////            NSLog(@"我的银行卡");
////            HCMineBankViewController *bankView = [[HCMineBankViewController alloc] init];
////            [self.navigationController pushViewController:bankView animated:YES];
//
//
//            break;
//        }
//    }
}

/**
 *  委托代理
 */
- (void)HCMineTopViewEditInfoClick:(NSInteger)tIndex {
    NSLog(@"委托代理");
    
    if(![[HelperManager CreateInstance] isLogin:NO completion:^(NSInteger tIndex) {
        NSLog(@"回调成功");
        [self getUserInfo];
    }]) return;
    
    switch (tIndex) {
        case 0: {
            //点击头像
            
            NSMutableArray *imgArr = [NSMutableArray array];
            [imgArr removeAllObjects];
            ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
            photo.photoURL = [NSURL URLWithString:userModel.avatar];
            [imgArr addObject:photo];
            
            // 图片游览器
            ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
            // 淡入淡出效果
            pickerBrowser.status = UIViewAnimationAnimationStatusFade;
            // 数据源/delegate
            pickerBrowser.photos = imgArr;
            // 能够删除
            pickerBrowser.delegate = self;
            // 当前选中的值
            pickerBrowser.currentIndex = 0;
            // 展示控制器
            [pickerBrowser showPickerVc:self];
            
            break;
        }
        case 1: {
            //编辑资料
            HCMineInfoViewController *infoView = [[HCMineInfoViewController alloc] init];
            infoView.userModel = userModel;
            infoView.callBack = ^(HCUserModel *model) {
                userModel = model;
                
                //设置头部信息
                [_topView setMineTopModel:userModel];
            };
            [self.navigationController pushViewController:infoView animated:YES];
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  获取个人信息
 */
- (void)getUserInfo {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            userModel = [HCUserModel mj_objectWithKeyValues:dataDic];
            [_topView setMineTopModel:userModel];
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
