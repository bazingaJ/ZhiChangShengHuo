//
//  HCHomeViewController+Version.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/26.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCHomeViewController.h"
#import "HCVersionPopupView.h"

@interface HCHomeViewController (Version)<HCVersionPopupViewDelegate>

/**
 *  版本检测
 */
@property (nonatomic, copy) KLCPopup *popup;
/**
 *  苹果应用下载地址
 */
@property (nonatomic, copy) NSString *trackViewUrl;

/**
 * 检测系统版本
 */
- (void)checkSystemVersion;

@end
