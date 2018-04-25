//
//  HCRegisterViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCRegisterViewController : BaseTableViewController<UITextFieldDelegate>

/**
 *  群名称数组
 */
@property (nonatomic, strong) NSMutableArray *nameArr;

@end
