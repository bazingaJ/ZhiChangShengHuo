//
//  HCMineMessageViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMineMessageCell.h"

@interface HCMineMessageViewController : BaseTableViewController<HCMineMessageCellDelegate>

//是否是推送跳过来的
@property (nonatomic, assign) BOOL isPush;

@end
