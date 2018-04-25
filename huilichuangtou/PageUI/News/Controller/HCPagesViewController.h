//
//  HCPagesViewController.h
//  XMPPV2.0
//
//  Created by 相约在冬季 on 2017/2/10.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCPagesControllerTopBar.h"

@interface HCPagesViewController : BaseViewController <UIScrollViewDelegate, HCPagesControllerTopBarDelegate>

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) HCPagesControllerTopBar *topBar;
@property (nonatomic, assign) BOOL showToNavigationBar;
@property (nonatomic, assign) CGFloat topBarHeight;

@property (nonatomic, strong) UIScrollView *pageScrollView;

@property (nonatomic, copy) void(^callBack)(NSInteger tIndex);

@end
