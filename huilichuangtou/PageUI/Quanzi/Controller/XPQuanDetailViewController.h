//
//  XPQuanDetailViewController.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPQuanziCell.h"
#import "XPQuanziCommentView.h"
#import "XPKeyboardAutomaticView.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "XPQuanziCommentCell.h"

@interface XPQuanDetailViewController : BaseTableViewController<XPQuanziDynamicDelegate,ZLPhotoPickerBrowserViewControllerDelegate,XPQuanziCommentViewDelegate,XPKeyboardAutomaticViewDelegate>

/**
 *  圈子ID
 */
@property (nonatomic, strong) NSString *dynamic_id;
/**
 *  评论数
 */
@property (nonatomic, strong) UILabel *lblCommentNum;
/**
 *  评论键盘
 */
@property (strong, nonatomic) XPKeyboardAutomaticView *keyboardView;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBlock)(XPQuanziModel *model);


@end
