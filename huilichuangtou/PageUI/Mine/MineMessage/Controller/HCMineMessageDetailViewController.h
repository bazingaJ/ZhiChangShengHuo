//
//  HCMineMessageDetailViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMineMessageModel.h"

@interface HCMineMessageDetailViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) HCMineMessageModel *messageInfo;
@property (nonatomic, copy) void(^callBack)();

@end
