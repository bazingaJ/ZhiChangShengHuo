//
//  UIView+Empty.h
//  wulian_user
//
//  Created by 相约在冬季 on 2017/6/1.
//  Copyright © 2017年 wlqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReloadDataBlock)();

/**
 *  空白类型枚举
 */
typedef NS_ENUM(NSInteger, ViewDataType)
{
    ViewDataTypeLoadFail=0,     //web页加载失败
    ViewDataTypeMyMessage = 1,  //我的消息
};

@interface CustomerWarnView : UIView

/**
 *  提示图
 */
@property (nonatomic, strong) UIImageView *imgView;
/**
 *  提示文字
 */
@property (nonatomic, strong) UILabel *lblTip;
/**
 *  刷新按钮
 */
@property (nonatomic, strong) UIButton *btnFunc;
/**
 *  回调函数
 */
@property (nonatomic, copy) ReloadDataBlock reloadBlock;
/**
 *  初始化空白页面
 */
+ (CustomerWarnView *)initWithFrame:(CGRect)frame andType:(ViewDataType)type;

@end

@interface UIView (Empty)

@property (strong, nonatomic) CustomerWarnView *warningView;

/**
 *  空页面显示提醒图与文字并添加重新刷新
 *
 *  @param emptyType 页面的展示的数据类别（例如：我的订单或者web页）
 *  @param hasData  是否有数据
 *  @param reloadBlock     重新加载页面（不需要时赋空）
 */
- (void)emptyViewShowWithDataType:(ViewDataType)emptyType
          hasData:(BOOL)hasData
       reloadBlock:(ReloadDataBlock)reloadBlock;

@end
