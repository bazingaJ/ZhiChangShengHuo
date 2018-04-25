//
//  HCPPTWebViewController.m
//  huilichuangtou
//
//  Created by yunduopu-ios-2 on 2018/4/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "HCPPTWebViewController.h"


static NSString *currentTitle = @"众筹文件";

@interface HCPPTWebViewController ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation HCPPTWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = currentTitle;
    
    self.navigationController.navigationBar.hidden = NO;
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
    [self.view addSubview:self.webView];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.urlString ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}

- (void)leftButtonItemClick {
    if ([self.navigationController isEqual:kWindow.rootViewController]) {
        self.navigationController.navigationBar.hidden = YES;
    }
    [super leftButtonItemClick];
}





- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



@end
