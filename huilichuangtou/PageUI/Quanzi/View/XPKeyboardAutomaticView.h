//
//  XPKeyboardAutomaticView.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTELimitTextView.h"

@protocol XPKeyboardAutomaticViewDelegate <NSObject>

- (void)XPKeyboardAutomaticViewClick:(NSString *)content withTag:(NSInteger)tag index:(NSInteger)index;

@end

@interface XPKeyboardAutomaticView : UIView

@property (assign,nonatomic)id<XPKeyboardAutomaticViewDelegate> delegate;
@property (strong, nonatomic) UIView *view;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnPulish;
@property (nonatomic, strong) ZTELimitTextView *tbxComment;

//标题
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeHolder;
/**
 *  字数限制
 */
@property (nonatomic, assign) NSInteger limitNum;

//初始frame
@property(assign,nonatomic)CGRect originalFrame;
@property (nonatomic, assign) BOOL is_QuanZi;

//隐藏键盘
-(BOOL)resignFirstResponder;

@end
