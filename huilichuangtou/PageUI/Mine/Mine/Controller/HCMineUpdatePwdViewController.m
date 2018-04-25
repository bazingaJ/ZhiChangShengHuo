//
//  HCMineUpdatePwdViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineUpdatePwdViewController.h"
#import "UIButton+CountDown.h"
#import "HCChangeCodeCell.h"

static NSString *currentTitle = @"修改密码";

static NSString *cellIdentifier1 = @"HCChangeCodeCell1";

static NSString *cellIdentifier2 = @"HCChangeCodeCell2";

@interface HCMineUpdatePwdViewController () {
    NSArray *titleArr;
    
    NSArray *placeHolderArr;
    
    NSMutableArray *contentArr;
    
    UITextField *tbxCode;
    NSString *mobileStr;
    NSString *codeStr;
    NSString *passwordStr;
    NSString *passwordReStr;
}

@end

@implementation HCMineUpdatePwdViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    
    
    self.title = currentTitle;
    
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.tableFooterView = [UIView new];
    
    //当前用户手机号
    mobileStr = [HelperManager CreateInstance].mobile;
    codeStr = @"";
    passwordStr = @"";
    passwordReStr = @"";
    
    //设置数据源
    titleArr = @[@[@"手机号码",@"验 证 码"],@[@"请 输 入 密 码",@"请再次输入密码"]];
    placeHolderArr = @[@[@"请输入手机号码",@"请输入验证码"],@[@"请输入6~12位新密码",@"再次输入新密码"]];
    
    contentArr = [NSMutableArray array];
    [contentArr addObject:@[mobileStr,@""]];
    [contentArr addObject:@[@"",@""]];
    
    [self createIU];


}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)createIU
{
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(15, 220, SCREEN_WIDTH -30, 45);
    [bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:MAIN_COLOR];
    bottomBtn.titleLabel.font = FONT17;
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.cornerRadius = 5;
    [bottomBtn addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:bottomBtn];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HCChangeCodeCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    HCChangeCodeCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (!cell2) {
            cell2 = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([HCChangeCodeCell class]) owner:nil options:nil]objectAtIndex:1];
        }
        cell2.contentTF2.delegate = self;
        [cell2.contentTF2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cell2.contentTF2 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [cell2.contentTF2 setTag:10086];
        
        [cell2.getCodeBtn addTarget:self action:@selector(btnFuncSendClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell2;
    }else{
        if (!cell1) {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([HCChangeCodeCell class]) owner:nil options:nil]objectAtIndex:0];
        }
        
        cell1.contentTF1.delegate = self;
        [cell1.contentTF1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cell1.contentTF1 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [cell1.contentTF1 setTag:indexPath.section *10 + indexPath.row];
        cell1.contentTF1.placeholder = placeHolderArr[indexPath.section][indexPath.row];
        
        cell1.titleLab1.text = titleArr[indexPath.section][indexPath.row];
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell1.contentTF1.userInteractionEnabled = NO;
            cell1.contentTF1.text = contentArr[indexPath.section][indexPath.row];
        }else{
            cell1.contentTF1.secureTextEntry = YES;
        }
        
        return cell1;
    }
    
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

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 10086: {
            //验证码
            if (textField.text.length > 6) {
                textField.text = [textField.text substringToIndex:6];
            }
            codeStr = textField.text;
            [contentArr replaceObjectAtIndex:0 withObject:@[mobileStr,textField.text]];
            
            break;
        }
        case 10: {
            //密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordStr = textField.text;
            [contentArr replaceObjectAtIndex:1 withObject:@[passwordStr,passwordReStr]];
            
            break;
        }
        case 11: {
            //确认密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordReStr = textField.text;
            [contentArr replaceObjectAtIndex:1 withObject:@[passwordStr,passwordReStr]];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark---scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/**
 *  发送验证码事件
 */
- (void)btnFuncSendClick:(UIButton *)btnSender {
    NSLog(@"发送验证码");
    [self.view endEditing:YES];
    if (![mobileStr isPhoneNumber])
    {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"sendSms" forKey:@"act"];
    [param setValue:mobileStr forKey:@"mobile"];
    [param setValue:@"2" forKey:@"type"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
            [btnSender startWithTime:59 title:@"重新获取" countDownTitle:@"s" mainColor:MAIN_COLOR countColor:UIColorFromRGBWith16HEX(0xE5E5E5)];
            
//            NSDictionary *dataDic = [json objectForKey:@"data"];
//            NSString *code = [dataDic objectForKey:@"code"];
//            NSLog(@"验证码：%@",code);
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

/**
 *  提交按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"提交按钮事件");
    [self.view endEditing:YES];
    
    //手机号验证
    if (![mobileStr isPhoneNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    //验证码验证
    if (![codeStr isNumeric] || codeStr.length != 6) {
        [MBProgressHUD showError:@"请输入6位数字验证码" toView:self.view];
        return;
    }
    //密码验证
    if(IsStringEmpty(passwordStr)) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }else if (![passwordStr isMinLength:6 andMaxLength:12]) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }
    if(IsStringEmpty(passwordReStr)) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }else if (![passwordReStr isMinLength:6 andMaxLength:12]) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }
    if(![passwordStr isEqualToString:passwordReStr]) {
        [MBProgressHUD showError:@"两次输入的密码不一致" toView:self.view];
        return;
    }
    
    //广告号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];
    
    [MBProgressHUD showMsg:@"修改中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"resetPwd" forKey:@"act"];
    [param setValue:codeStr forKey:@"vcode"];
    [param setValue:passwordStr forKey:@"password"];
    [param setValue:idfaStr forKey:@"device_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"密码修改成功" toView:self.view];
            
//            //清除缓存信息
//            [[HelperManager CreateInstance] clearAcc];
//
//            //设置本地缓存信息
//            NSDictionary *dataDic = [json objectForKey:@"data"];
//            [self setUserDefaultInfo:dataDic];
            
            //停顿0.5秒后返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //跳转到APP首页
                [APP_DELEGATE enterMainVC];
                
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
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
