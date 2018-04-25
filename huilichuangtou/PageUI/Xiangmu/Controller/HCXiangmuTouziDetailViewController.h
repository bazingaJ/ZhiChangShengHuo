//
//  HCXiangmuTouziDetailViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCYuyuePopupView.h"
#import "HCTouziModel.h"

@interface HCXiangmuTouziDetailViewController : HCWKWebViewController<HCYuyuePopupViewDelegate>

/**
 *  投资项目
 */
@property (nonatomic, strong) HCTouziModel *touziModel;

@property (strong, nonatomic) KLCPopup *popup;

@end
