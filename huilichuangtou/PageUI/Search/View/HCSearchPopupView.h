//
//  HCSearchPopupView.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPopupMenu.h"

@interface HCSearchPopupView : UIView<YBPopupMenuDelegate>

@property (nonatomic, strong) UIButton *btnSelect;
@property (nonatomic, copy) void(^callBack)(NSInteger type,NSString *title);

@end
