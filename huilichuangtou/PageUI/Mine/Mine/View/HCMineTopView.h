//
//  HCMineTopView.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCUserModel.h"

@protocol HCMineTopViewDelegate <NSObject>

- (void)HCMineTopViewEditInfoClick:(NSInteger)tIndex;

@end

@interface HCMineTopView : UIView

@property (assign) id<HCMineTopViewDelegate> delegate;

- (void)setMineTopModel:(HCUserModel *)model;

@end
