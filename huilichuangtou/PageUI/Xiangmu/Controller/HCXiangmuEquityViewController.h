//
//  HCXiangmuEquityViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSegmentTopView.h"

@interface HCXiangmuEquityViewController : BaseTableViewController<HCSegmentTopViewDelegate>

@property (nonatomic, strong) HCSegmentTopView *topView;

@property (nonatomic, assign) BOOL isHome;

@end
