//
//  HCMineViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMineTopView.h"
#import "ZLPhotoPickerBrowserViewController.h"

@interface HCMineViewController : BaseTableViewController<HCMineTopViewDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, strong) HCMineTopView *topView;

@end
