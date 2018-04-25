//
//  HCPagesControllerTopBar.h
//  XMPPV2.0
//
//  Created by 相约在冬季 on 2017/2/10.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCPagesControllerTopBar;
@protocol HCPagesControllerTopBarDelegate <NSObject>
- (void)itemAtIndex:(NSUInteger)index didSelectInPagesContainerTopBar:(HCPagesControllerTopBar *)bar;
@end

@interface HCPagesControllerTopBar : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *selectedItemTitleColor;
@property (nonatomic, strong) UIFont *itemTileFont;
@property (nonatomic, strong) UIFont *selectedItemTileFont;
@property (nonatomic, weak) id <HCPagesControllerTopBarDelegate> delegate;


@property (nonatomic, strong) UILabel *previosItemLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *itemLabels;

- (void)updateLineViewPosition;

@end
