//
//  HCYuyuePopupView.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCYuyuePopupViewDelegate <NSObject>

- (void)HCYuyuePopupViewClick:(NSInteger)tindex totalFee:(NSString *)totalFee;

@end

@interface HCYuyuePopupView : UIView

@property (assign) id<HCYuyuePopupViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame minFee:(NSString *)minFee maxFee:(NSString *)maxFee;

@end
