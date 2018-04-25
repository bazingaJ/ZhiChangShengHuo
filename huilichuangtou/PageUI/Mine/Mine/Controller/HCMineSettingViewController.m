//
//  HCMineSettingViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineSettingViewController.h"
#import "HCMineUpdatePwdViewController.h"

static NSString *const currentTitle = @"设置";

@interface HCMineSettingViewController () {
    NSMutableArray *titleArr;
}

@end

@implementation HCMineSettingViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    
    self.navigationItem.title = currentTitle;
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"帮助",@"帮助"]];
    [titleArr addObject:@[@"关于",@"关于汇力创投"]];
    [titleArr addObject:@[@"修改密码",@"修改密码"]];
    
    //创建“退出登录”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, SCREEN_WIDTH - 30, 45)];
    [btnFunc setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnLoginOutClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineSettingViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
    
    //创建“标题”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-40, 25)];
    [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT16];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [btnFunc setUserInteractionEnabled:NO];
    [cell.contentView addSubview:btnFunc];
    
    //创建“右侧尖头”
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
    [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
    [cell.contentView addSubview:imgView2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            //帮助
            NSString *helpURL = [HCURLManager manager].help_url;
            if(IsStringEmpty(helpURL)) {
                [MBProgressHUD showError:@"帮助地址不能为空" toView:self.view];
                return;
            }
            HCWKWebViewController *webView = [[HCWKWebViewController alloc] init];
            [webView setTitle:@"帮助"];
            [webView setUrl:helpURL];
            [self.navigationController pushViewController:webView animated:YES];
            
            break;
        }
        case 1: {
            //关于汇力创投
            NSString *aboutURL = [HCURLManager manager].about_url;
            if(IsStringEmpty(aboutURL)) {
                [MBProgressHUD showError:@"关于汇力创投地址不能为空" toView:self.view];
                return;
            }
            HCWKWebViewController *webView = [[HCWKWebViewController alloc] init];
            [webView setTitle:@"关于汇力创投"];
            [webView setUrl:aboutURL];
            [self.navigationController pushViewController:webView animated:YES];
            
            break;
        }
        case 2: {
            //修改密码
            HCMineUpdatePwdViewController *updateView = [[HCMineUpdatePwdViewController alloc] init];
            [self.navigationController pushViewController:updateView animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  退出登录
 */
- (void)btnLoginOutClick:(UIButton *)btnSender {
    NSLog(@"退出登录");
    
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //清除用户本地账号信息
        [[HelperManager CreateInstance] clearAcc];
        
        //推送,用户退出,别名去掉
        [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            NSLog(@"结果：%zd",iResCode);//0表示成功
        } seq:0];
        
        //退出后跳转至首页
        [APP_DELEGATE enterMainVC];
    }];
    [aler addAction:cancelAction];
    [aler addAction:okAction];
    [self presentViewController:aler animated:YES completion:nil];
    
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
