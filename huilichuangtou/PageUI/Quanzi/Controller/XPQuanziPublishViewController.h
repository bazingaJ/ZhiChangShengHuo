//
//  XPQuanziPublishViewController.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZTELimitTextView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface XPQuanziPublishViewController : BaseTableViewController<ZLPhotoPickerBrowserViewControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy) void(^callBack)(NSDictionary *dataDic);

/**
 *  描述输入框
 */
@property (nonatomic, strong)  ZTELimitTextView *tbxContent;
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
@property (nonatomic , strong) NSMutableArray *assetsArr;
/**
 *  图片数组集合
 */
@property (strong, nonatomic) NSMutableArray *photosArr;
/**
 *  定位图标
 */
@property (nonatomic, strong) UIImageView *imgLocation;
/**
 *  选择的定位地址
 */
@property (nonatomic, strong) UILabel *lbLocation;
/**
 *  选择的标签
 */
@property (nonatomic, strong) UILabel *lblTag;
/**
 *  地图搜索
 */
@property (nonatomic, strong) AMapPOI *poi;

@end
