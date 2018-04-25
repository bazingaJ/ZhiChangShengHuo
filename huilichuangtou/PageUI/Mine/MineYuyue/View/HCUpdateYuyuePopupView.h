//
//  HCUpdateYuyuePopupView.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTouziOrderModel.h"

@protocol HCUpdateYuyuePopupViewDelegate <NSObject>

- (void)HCUpdateYuyuePopupViewClick:(HCTouziOrderModel *)model indexPath:(NSIndexPath *)indexPath tIndex:(NSInteger)tIndex totalFee:(NSString *)totalFee;

@end

@interface HCUpdateYuyuePopupView : UIView

@property (assign) id<HCUpdateYuyuePopupViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame model:(HCTouziOrderModel *)model indexPath:(NSIndexPath *)indexPath;

@end
