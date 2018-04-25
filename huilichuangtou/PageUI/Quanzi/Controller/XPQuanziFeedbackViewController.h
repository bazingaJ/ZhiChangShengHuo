//
//  XPQuanziFeedbackViewController.h
//  zteiwh
//
//  Created by 相约在冬季 on 2017/11/7.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZTELimitTextView.h"

@interface XPQuanziFeedbackViewController : BaseTableViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

/**
 *  imagePicker队列
 */
@property (nonatomic, strong) NSMutableArray *imagePickerArray;
/**
 *  添加图片按钮
 */
@property (nonatomic, strong) UIButton *btnAdd;
/**
 *  <#name#>
 */
@property (nonatomic, strong) NSMutableArray *assetsArr;
/**
 *  图片数组集合
 */
@property (nonatomic, strong) NSMutableArray *photosArr;
/**
 *  多行输入控件
 */
@property (nonatomic, strong) ZTELimitTextView *textView;


@end
