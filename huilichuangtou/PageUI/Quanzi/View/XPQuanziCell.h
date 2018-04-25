//
//  XPQuanziCell.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPQuanziModel.h"

@protocol XPQuanziDynamicDelegate <NSObject>

/**
 *  大图预览
 */
- (void)XPQuanziDynamicImageClick:(NSMutableArray *)imgArr tIndex:(NSInteger)tIndex;
/**
 *  举报
 */
- (void)XPQuanziDynamicJuBaoClick:(XPQuanziModel *)model;

@end

@interface XPQuanziCell : UITableViewCell

@property (assign) id<XPQuanziDynamicDelegate> delegate;
- (void)setQuanziModel:(XPQuanziModel *)model;

@property (nonatomic, strong) UIButton *btnFunc;

/**
 *  图片临时存储器
 */
@property (nonatomic, strong) NSMutableArray *imgArr;

/**
 *  设置点赞评论数
 */
- (void)setCommNum:(NSInteger)commNum;

@end
