//
//  XPQuanziBottomView.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/30.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XPQuanziBottomViewDelegate <NSObject>

- (void)XPQuanziBottomViewMoreDidSelectItemAtIndex;

@end

@interface XPQuanziBottomView : UIView

@property (assign) id<XPQuanziBottomViewDelegate> delegate;

@end
