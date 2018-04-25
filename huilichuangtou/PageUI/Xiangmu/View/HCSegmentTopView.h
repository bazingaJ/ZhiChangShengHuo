//
//  HCSegmentTopView.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@protocol HCSegmentTopViewDelegate <NSObject>

- (void)HCSegmentTopViewSegmentClick:(NSInteger)tIndex;

@end

@interface HCSegmentTopView : UIView

@property (assign) id<HCSegmentTopViewDelegate> delegate;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end
