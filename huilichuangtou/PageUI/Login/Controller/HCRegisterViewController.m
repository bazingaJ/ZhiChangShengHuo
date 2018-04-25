//
//  HCRegisterViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCRegisterViewController.h"
#import "UIButton+CountDown.h"
#import "HCGroupModel.h"
#import "LTPickerView.h"

@interface HCRegisterViewController () {
    NSMutableArray *titleArr;
    
    UITextField *tbxMobile;
    NSString *mobileStr;
    NSString *codeStr;
    NSString *introStr;
    NSString *passwordStr;
    NSString *passwordReStr;
}

@end

@implementation HCRegisterViewController

/**
 *  群名称数组
 */
- (NSMutableArray *)nameArr {
    if(!_nameArr) {
        _nameArr = [NSMutableArray array];
    }
    return _nameArr;
}

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"请输入手机号",@"0"]];
    [titleArr addObject:@[@"验证码",@"1"]];
    [titleArr addObject:@[@"介绍人",@"0"]];
    [titleArr addObject:@[@"请输入6～12位密码",@"0"]];
    [titleArr addObject:@[@"请再次输入密码",@"0"]];
    
//    //获取群
//    [self getQunList];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //默认定位到手机号码输入框
    [tbxMobile becomeFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //账号、密码
            return 65;
            
            break;
        case 1:
            //登录按钮
            return 55;
            
            break;
        case 2:
            //注册、找回密码
            return 45;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCRegisterViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“背景层”
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 40)];
            [backView.layer setCornerRadius:5.0];
            [backView.layer setBorderWidth:0.5];
            [backView.layer setBorderColor:UIColorFromRGBWith16HEX(0xC1C1C1).CGColor];
            [cell.contentView addSubview:backView];
            
            //创建"输入框"
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-20, 30)];
            [tbxContent setPlaceholder:itemArr[0]];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setFont:FONT16];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT16 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTag:100+indexPath.row];
            if(indexPath.row==0 || indexPath.row==1) {
                
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
                if(indexPath.row==0) {
                    //手机号码
                    tbxMobile = tbxContent;
                }else if(indexPath.row==1) {
                    //创建“发送验证码”按钮
                    backView.width = SCREEN_WIDTH-150;
                    
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 20, 120, 40)];
                    [btnFunc setTitle:@"发送验证码" forState:UIControlStateNormal];
                    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btnFunc.titleLabel setFont:FONT16];
                    [btnFunc setBackgroundColor:MAIN_COLOR];
                    [btnFunc.layer setCornerRadius:3.0];
                    [btnFunc addTarget:self action:@selector(btnFuncSendClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btnFunc];
                    
                }
                
            }
            if(indexPath.row==3 || indexPath.row==4) {
                //密码
                [tbxContent setSecureTextEntry:YES];
            }
            [tbxContent setDelegate:self];
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent setTag:indexPath.row+100];
            [backView addSubview:tbxContent];
            
            switch (indexPath.row) {
                case 0: {
                    //手机号码
                    [tbxContent setText:mobileStr];
                    
                    break;
                }
                case 1: {
                    //验证码
                    [tbxContent setText:codeStr];
                    
                    break;
                }
                case 2: {
                    //介绍人
                    [tbxContent setText:introStr];
                    
                    break;
                }
                case 3: {
                    //密码
                    [tbxContent setText:passwordStr];
                    
                    break;
                }
                case 4: {
                    //确认密码
                    [tbxContent setText:passwordReStr];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
        case 1: {
            //创建“注册”按钮
            UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 40)];
            [btnLogin setBackgroundColor:MAIN_COLOR];
            [btnLogin setTitle:@"注册" forState:UIControlStateNormal];
            [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnLogin.titleLabel setFont:FONT17];
            [btnLogin.layer setCornerRadius:3.0];
            [btnLogin addTarget:self action:@selector(btnRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnLogin];
            
            break;
        }
        case 2: {
            //用户使用协议
            NSString *titleStr = @"点击【注册】,代表您已阅读并同意《用户使用协议》";
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 20)];
            [btnFunc setTitle:titleStr forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR6 forState:UIControlStateNormal];
            [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btnFunc.titleLabel setFont:FONT14];
            [btnFunc addTarget:self action:@selector(btnFuncAgreeClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnFunc];
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
            //字体颜色
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:MAIN_COLOR
                            range:NSMakeRange(titleStr.length-8, 8)];
            //            //字体大小
            //            [attrStr addAttribute:NSFontAttributeName
            //                            value:FONT13
            //                            range:NSMakeRange(0, 1)];
            btnFunc.titleLabel.attributedText = attrStr;
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 100: {
            //手机号码
            if (textField.text.length > 11) {
                textField.text = [textField.text substringToIndex:11];
            }
            mobileStr = textField.text;
            
            break;
        }
        case 101: {
            //验证码
            if (textField.text.length > 6) {
                textField.text = [textField.text substringToIndex:6];
            }
            codeStr = textField.text;
            
            break;
        }
        case 102: {
            //介绍人
            introStr = textField.text;
            
            break;
        }
        case 103: {
            //密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordStr = textField.text;
            
            break;
        }
        case 104: {
            //确认密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordReStr = textField.text;
            
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

///**
// *  获取群列表
// */
//- (void)getQunList {
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"default" forKey:@"app"];
//    [param setValue:@"getGroupList" forKey:@"act"];
//    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
//        NSString *code = [json objectForKey:@"code"];
//        if([code isEqualToString:SUCCESS]) {
//            NSArray *dataList = json[@"data"];
//            self.dataArr = [HCGroupModel mj_objectArrayWithKeyValuesArray:dataList];
//            if(self.dataArr.count) {
//                for (int i=0; i<self.dataArr.count; i++) {
//                    HCGroupModel *model = [self.dataArr objectAtIndex:i];
//                    [self.nameArr addObject:model.group_name];
//                }
//            }
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"%@",[error description]);
//    }];
//}

/**
 *  发送验证码事件
 */
- (void)btnFuncSendClick:(UIButton *)btnSender {
    NSLog(@"发送验证码事件");
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
    [param setValue:@"1" forKey:@"type"];
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
 *  注册按钮事件
 */
- (void)btnRegisterClick:(UIButton *)btnSender {
    NSLog(@"注册按钮事件");
    [self.view endEditing:YES];
    
    //手机号码验证
    if (![mobileStr isPhoneNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    
    //验证码验证
    if (![codeStr isNumeric] || codeStr.length != 6) {
        [MBProgressHUD showError:@"请输入6位数字验证码" toView:self.view];
        return;
    }
    
    //介绍人验证
    if(IsStringEmpty(introStr)) {
        [MBProgressHUD showError:@"请输入介绍人" toView:self.view];
        return;
    }
    
    //密码验证
    if (![passwordStr isMinLength:6 andMaxLength:12]) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }else if (![passwordStr isEqualToString:passwordReStr]) {
        [MBProgressHUD showError:@"两次密码输入不一致" toView:self.view];
        return;
    }
    
    //广告号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];
    
    [MBProgressHUD showMsg:@"注册中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"register" forKey:@"act"];
    [param setValue:mobileStr forKey:@"mobile"];
    [param setValue:codeStr forKey:@"vcode"];
    [param setValue:@"1" forKey:@"group_id"];
    [param setValue:introStr forKey:@"introducer"];
    [param setValue:passwordStr forKey:@"password"];
    [param setValue:idfaStr forKey:@"device_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
//            NSDictionary *dataDic = [json objectForKey:@"data"];
            
            //预先清除
            [[HelperManager CreateInstance] clearAcc];
            
//            //设置本地缓存
//            [self setUserDefaultInfo:dataDic];
//
//            //发送通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGIN_SUCCESS object:nil userInfo:nil];
//
//            //延迟1秒退出
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self dismissViewControllerAnimated:YES completion:nil];
//            });
            
            //延迟1秒退出
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //注册成功后返回登录界面
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
}

/**
 *  用户使用协议
 */
- (void)btnFuncAgreeClick:(UIButton *)btnSender {
    NSLog(@"用户使用协议");
    
    NSString *userURL = [HCURLManager manager].user_url;
    if(IsStringEmpty(userURL)) {
        [MBProgressHUD showError:@"用户协议不能为空" toView:self.view];
        return ;
    }
    
    HCWKWebViewController *webView = [[HCWKWebViewController alloc] init];
    [webView setTitle:@"用户使用协议"];
    [webView setUrl:userURL];
    [self.navigationController pushViewController:webView animated:YES];

    
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
