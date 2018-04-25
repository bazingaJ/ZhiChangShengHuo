//
//  HCXiangmuTouziDetailViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCXiangmuTouziDetailViewController.h"

@interface HCXiangmuTouziDetailViewController ()

@end

@implementation HCXiangmuTouziDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"项目详情";
    
    //创建“立即预约”按钮
    if([self.touziModel.buy_status isEqualToString:@"1"]) {
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
        [btnFunc setTitle:@"立即预约" forState:UIControlStateNormal];
        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT17];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnFunc];
    }
    
}

/**
 *  立即预约按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"立即预约");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:YES completion:nil]) return;
    
    //判断可投金额是否<=0
    CGFloat canFee = 0;
    if(!IsStringEmpty(self.touziModel.can_fee)) {
        canFee = [self.touziModel.can_fee floatValue];
    }
    if(canFee<=0) {
        [MBProgressHUD showError:@"手慢了！该项目已无额度" toView:self.view];
        return;
    }
    
    HCYuyuePopupView *popupView = [[HCYuyuePopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, 0, 280, 220) minFee:self.touziModel.min_fee maxFee:self.touziModel.max_fee];
    popupView.delegate = self;
    self.popup = [KLCPopup popupWithContentView:popupView
                                       showType:KLCPopupShowTypeGrowIn
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:YES
                          dismissOnContentTouch:NO];
    [self.popup show];
    
}

/**
 *  设置投资金额委托代理
 */
- (void)HCYuyuePopupViewClick:(NSInteger)tindex totalFee:(NSString *)totalFee {
    [self.popup dismiss:YES];
    
    if(tindex<=0) return;
    
    //当前输入金额
    CGFloat talFee = [totalFee floatValue];
    
    //最大投资额判断
    CGFloat maxFee = 0;
    if(!IsStringEmpty(self.touziModel.max_fee)) {
        maxFee = [self.touziModel.max_fee floatValue];
    }
    
    if(talFee>maxFee) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最高投资金额不能高于%.f万",maxFee] toView:self.view];
        return;
    }

    //可投额度判断
    CGFloat canFee = 0;
    if(!IsStringEmpty(self.touziModel.can_fee)) {
        canFee = [self.touziModel.can_fee floatValue];
    }
    if([totalFee floatValue]>canFee) {
        [MBProgressHUD showError:@"预约失败，可预约额度为“当前剩余额度”" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"预约中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"product" forKey:@"app"];
    [param setValue:@"setInvest" forKey:@"act"];
    [param setValue:self.touziModel.invest_id forKey:@"invest_id"];
    [param setValue:totalFee forKey:@"total_fee"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:msg toView:self.view];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
