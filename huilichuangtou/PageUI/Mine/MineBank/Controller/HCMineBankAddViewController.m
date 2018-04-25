//
//  HCMineBankAddViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineBankAddViewController.h"

@interface HCMineBankAddViewController () {
    NSString *bankNoStr;

    HCBankModel *bankModel;

}

//@property (nonatomic, strong) UIButton *btnFuncBank;
@property (nonatomic, strong) UILabel *lbMsg;

@end

@implementation HCMineBankAddViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加银行卡";
    
    self.tableView.scrollEnabled = NO;
    
    //创建“添加”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"添加" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
    //添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesClick:)];
    [tapGes setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGes];
    
}

//手势点击事件
- (void)tapGesClick:(UITapGestureRecognizer *)recognizer {
    NSLog(@"您点击了手势");
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"HCMineBankAddViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 25)];
    if(indexPath.row==0) {
        [lbMsg setText:@"银行卡号"];
    }else if(indexPath.row==1) {
        [lbMsg setText:@"银行"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    switch (indexPath.row) {
        case 0: {
            //银行卡号
            UITextField *tbxBankNo = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-100, 25)];
            [tbxBankNo setPlaceholder:@"请输入您的银行卡号"];
            [tbxBankNo setTextColor:COLOR3];
            [tbxBankNo setTextAlignment:NSTextAlignmentRight];
            [tbxBankNo setFont:FONT16];
            [tbxBankNo setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxBankNo setValue:FONT16 forKeyPath:@"_placeholderLabel.font"];
            [tbxBankNo setKeyboardType:UIKeyboardTypeNumberPad];
            [tbxBankNo setDelegate:self];
            [tbxBankNo addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [tbxBankNo setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxBankNo setTag:100];
            [cell.contentView addSubview:tbxBankNo];
            
            break;
        }
        case 1: {
            //银行
//            _btnFuncBank = [[UIButton alloc] initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-100, 25)];
//            [_btnFuncBank setTitle:@"请选择银行" forState:UIControlStateNormal];
//            [_btnFuncBank setTitleColor:COLOR9 forState:UIControlStateNormal];
//            [_btnFuncBank.titleLabel setFont:FONT16];
//            [_btnFuncBank setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//            [_btnFuncBank setImage:[UIImage imageNamed:@"mine_arrow_right"] forState:UIControlStateNormal];
//            [_btnFuncBank setTitleEdgeInsets:UIEdgeInsetsMake(0, -_btnFuncBank.imageView.image.size.width, 0, _btnFuncBank.imageView.image.size.width+10)];
//            [_btnFuncBank setImageEdgeInsets:UIEdgeInsetsMake(0, _btnFuncBank.titleLabel.bounds.size.width+10, 0, -_btnFuncBank.titleLabel.bounds.size.width)];
//            [_btnFuncBank addTarget:self action:@selector(btnFuncSelectClick:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:_btnFuncBank];
            
            self.lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-100, 25)];
            [self.lbMsg setTextColor:COLOR3];
            [self.lbMsg setTextAlignment:NSTextAlignmentRight];
            [self.lbMsg setFont:FONT16];
            [cell.contentView addSubview:self.lbMsg];
            
            break;
        }
            
        default:
            break;
    }
    
    //创建“分割线“
    if(indexPath.row==0) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
    }
    
    return cell;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if(textField.tag==100) {
        if (textField.text.length > 19) {
            textField.text = [textField.text substringToIndex:19];
        }
        bankNoStr = textField.text;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"编辑结束");
    
    if(textField.text.length<16) {
        return;
    }
    
    NSString *urlStr = @"http://jisuyhkgsd.market.alicloudapi.com/bankcard/query";
    NSString *appcode = @"aff9b2bc697f4ec6b26a7525caf2c07e";
    NSString *host = @"http://jisuyhkgsd.market.alicloudapi.com";
    NSString *path = @"/bankcard/query";
    NSString *method = @"GET";
    NSString *querys = [NSString stringWithFormat:@"?bankcard=%@",bankNoStr];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"";
    
    WS(weakSelf);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       
                                                       //打印应答中的body
                                                       NSLog(@"Response body: %@" , bodyString);
                                                       
                                                       NSDictionary *resultDic = [bodyString mj_JSONObject];
                                                       NSString *status = [resultDic objectForKey:@"status"];
                                                       if([status isEqualToString:@"0"]) {
                                                           NSDictionary *dataDic = [resultDic objectForKey:@"result"];
                                                           bankModel = [HCBankModel mj_objectWithKeyValues:dataDic];
                                                           
                                                           //主线程执行
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               //设置银行名称
                                                               [weakSelf.lbMsg setText:bankModel.bank];
                                                           });
                                                           
                                                       }
                                                   }];
    
    [task resume];
}

/**
 *  选择银行卡
 */
- (void)btnFuncSelectClick:(UIButton *)btnSender {
    NSLog(@"选择银行卡");
    [self.view endEditing:YES];
    
}

/**
 *  添加银行卡事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"添加银行卡事件");
    [self.view endEditing:YES];
    
    //银行卡验证
    if(IsStringEmpty(bankNoStr)) {
        [MBProgressHUD showError:@"银行卡号不能为空" toView:self.view];
        return;
    }
    if(IsStringEmpty(bankModel.bank)) {
        [MBProgressHUD showError:@"请选择银行" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"处理中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"addBankCard" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [param setValue:bankModel.bank forKey:@"bank_name"];
    [param setValue:bankModel.type forKey:@"bank_type"];
    [param setValue:bankModel.logo forKey:@"logo"];
    [param setValue:bankNoStr forKey:@"card_no"];
    [param setValue:bankModel.province forKey:@"province"];
    [param setValue:bankModel.city forKey:@"city"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"银行卡添加成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            HCBankModel *bankInfo = [HCBankModel mj_objectWithKeyValues:dataDic];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callBack) {
                    self.callBack(bankInfo);
                }
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
