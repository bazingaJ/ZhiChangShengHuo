//
//  HCVersionPopupView.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/26.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCVersionPopupView;

@protocol HCVersionPopupViewDelegate <NSObject>

@optional

- (void)popupView:(HCVersionPopupView *)popupView withSender:(UIButton *)sender;
- (void)popupView:(HCVersionPopupView *)popupView dismissWithSender:(id)sender;

@end


@interface HCVersionPopupView : UIView

@property (assign, nonatomic) id <HCVersionPopupViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame param:(NSMutableDictionary *)param;

@end
