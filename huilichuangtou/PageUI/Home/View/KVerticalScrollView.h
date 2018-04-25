//
//  KVerticalScrollView.h
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KVerticalScrollView;

/** delegate */
@protocol SGAdvertScrollViewDelegate <NSObject>

- (void)advertScrollView:(KVerticalScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface KVerticalScrollView : UIView

/** 左边提示图片 */
@property (nonatomic, strong) UIImage *image;
/** 右边标题数组（要么是NSString，要么NSMutableAttributedString，不可混用）*/
@property (nonatomic, strong) NSArray *titleArray;
/** 设置滚动时间间隔(默认 3s) */
@property (nonatomic, assign) CGFloat timeInterval;
/** 标题字体大小(默认 12) */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题字体颜色(默认 黑色) */
@property (nonatomic, strong) UIColor *titleColor;
/** titleArray 是否包含 NSMutableAttributedString 默认为NO，如果包含必须设置为 YES */
@property (nonatomic, assign) BOOL isHaveMutableAttributedString;

/** delegate_SG */
@property (nonatomic, weak) id<SGAdvertScrollViewDelegate> advertScrollViewDelegate;


@end
