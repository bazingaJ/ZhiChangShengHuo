//
//  HCXiangmuEquityDetailViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCYuyuePopupView.h"
#import "HCEquityModel.h"

@interface HCXiangmuEquityDetailViewController : HCWKWebViewController<HCYuyuePopupViewDelegate>

/**
 *  众筹项目
 */
@property (nonatomic, strong) HCEquityModel *equityModel;

@property (strong, nonatomic) KLCPopup *popup;

@end
