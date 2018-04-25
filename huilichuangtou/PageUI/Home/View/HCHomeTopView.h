//
//  HCHomeTopView.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "HCVerticalScrollView.h"

@protocol HCHomeTopViewDelegate <NSObject>

- (void)HCHomeTopViewAdDidSelectItemAtIndex:(NSInteger)tIndex;

- (void)HCHomeTopViewNewsDidSelectItemAtIndex:(NSInteger)tIndex;

@end

@interface HCHomeTopView : UIView

@property (assign) id<HCHomeTopViewDelegate> delegate;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) HCVerticalScrollView *advertScrollView;
@property (nonatomic, strong) NSMutableArray *newsArr;

@end
