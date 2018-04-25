//
//  HCMineYuyueTouziViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMineYuyueTouziCell.h"
#import "HCUpdateYuyuePopupView.h"

@interface HCMineYuyueTouziViewController : BaseTableViewController<HCMineYuyueTouziCellDelegate,HCUpdateYuyuePopupViewDelegate>

@property (strong, nonatomic) KLCPopup *popup;

@end
