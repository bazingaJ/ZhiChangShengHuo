//
//  HCMineBankAddViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBankModel.h"

@interface HCMineBankAddViewController : BaseTableViewController<UITextFieldDelegate>

/**
 *  回调函数
 */
@property (nonatomic, strong) void(^callBack)(HCBankModel *model);

@end
