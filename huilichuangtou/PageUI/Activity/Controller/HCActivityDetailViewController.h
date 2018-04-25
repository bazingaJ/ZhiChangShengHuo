//
//  HCActivityDetailViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/11/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCActivityModel.h"

@interface HCActivityDetailViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) HCActivityModel *activityModel;

@end
