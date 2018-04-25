//
//  HCMineInfoViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCUserModel.h"

@interface HCMineInfoViewController : BaseTableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(HCUserModel *model);
/**
 *  用户模型
 */
@property (nonatomic, strong) HCUserModel *userModel;

@end
