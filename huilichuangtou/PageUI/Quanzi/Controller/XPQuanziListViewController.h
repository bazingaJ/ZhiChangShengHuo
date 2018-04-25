//
//  XPQuanziListViewController.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPQuanziCell.h"
#import "ZLPhotoPickerBrowserViewController.h"

@interface XPQuanziListViewController : BaseTableViewController<XPQuanziDynamicDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

/**
 *  圈子分类ID
 */
@property (nonatomic, strong) NSString *cate_id;

@end
