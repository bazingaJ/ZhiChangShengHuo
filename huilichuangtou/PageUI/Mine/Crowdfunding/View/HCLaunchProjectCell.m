//
//  HCLaunchProjectCell.m
//  huilichuangtou
//
//  Created by yunduopu-ios-2 on 2018/4/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "HCLaunchProjectCell.h"
#import "HCPPTWebViewController.h"

@implementation HCLaunchProjectCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:
                                        _seePPTBtn.currentTitle];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName
                  value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                  range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName
                  value:MAIN_COLOR
                  range:titleRange];
    
    [self.seePPTBtn setAttributedTitle:title
                      forState:UIControlStateNormal];
    
    
}

- (IBAction)lookBtnClick:(UIButton *)sender {
    
    UIViewController *vc = [JXAppTool currentViewController];
    HCPPTWebViewController *webView = [[HCPPTWebViewController alloc] init];
    webView.urlString = @"jxPPT.pptx";
    [vc.navigationController pushViewController:webView animated:YES];
    
}


@end
