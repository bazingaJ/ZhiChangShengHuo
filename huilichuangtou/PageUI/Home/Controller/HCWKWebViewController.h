//
//  HCWKWebViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface HCWKWebViewController : BaseViewController<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate,NSURLSessionDelegate,NSURLConnectionDelegate>

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign, getter=isPresent) BOOL present;

- (void)doJavaScript:(NSString *)js;

@property (nonatomic, strong) WKWebView *webView;
//处理https认证
@property (nonatomic, strong) NSURLRequest *webRequest;
@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, strong) NSURLSession* httpsSession;
@property (nonatomic, strong) NSURLConnection *httpsUrlConnection;

@property (nonatomic, assign) CGFloat tabH;

@property (nonatomic, strong) UIView *lineView;
@end
