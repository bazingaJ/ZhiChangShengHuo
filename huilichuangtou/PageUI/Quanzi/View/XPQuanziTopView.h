//
//  XPQuanziTopView.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "XPCateModel.h"

@protocol XPQuanziTopViewDelegate <NSObject>

- (void)XPQuanziTopAdViewDidSelectItemAtIndex:(NSInteger)tIndex;
- (void)XPQuanziTagViewDidSelectItemAtIndex:(XPCateModel *)model;

@end

@interface XPQuanziTopView : UIView

@property (assign) id<XPQuanziTopViewDelegate> delegate;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, strong) NSArray *cateArr;

@end
