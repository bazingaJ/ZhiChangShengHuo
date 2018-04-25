//
//  XPQuanziCommentView.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XPQuanziCommentViewDelegate <NSObject>

- (void)XPQuanziCommentViewBottomBarClick:(NSInteger)tIndex;

@end

@interface XPQuanziCommentView : UIView

@property (assign) id<XPQuanziCommentViewDelegate> delegate;

@end
