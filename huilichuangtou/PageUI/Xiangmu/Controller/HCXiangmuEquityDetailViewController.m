//
//  HCXiangmuEquityDetailViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCXiangmuEquityDetailViewController.h"

@interface HCXiangmuEquityDetailViewController ()

@end

@implementation HCXiangmuEquityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"项目详情";
    
    if([self.equityModel.buy_status isEqualToString:@"1"]) {
        //创建“立即预约”按钮
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
    
    HCYuyuePopupView *popupView = [[HCYuyuePopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, 0, 280, 220) minFee:self.equityModel.add_fee maxFee:@""];
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
    NSLog(@"投资金额回调成功");
    [self.popup dismiss:YES];
    
    if(tindex<=0) return;
    
    [MBProgressHUD showMsg:@"预约中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"product" forKey:@"app"];
    [param setValue:@"setCrowdFunding" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [param setValue:self.equityModel.crowd_id forKey:@"crowd_id"];
    [param setValue:totalFee forKey:@"total_fee"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"预约成功" toView:self.view];
            
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
