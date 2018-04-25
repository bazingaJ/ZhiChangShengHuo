//
//  HCWKWebExViewController.h
//  ethereum
//
//  Created by 相约在冬季 on 2017/12/28.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCWKWebExViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, strong) UIView *lineView;

/**
 *  内容
 */
@property (nonatomic, strong) NSString *contentStr;

@end
