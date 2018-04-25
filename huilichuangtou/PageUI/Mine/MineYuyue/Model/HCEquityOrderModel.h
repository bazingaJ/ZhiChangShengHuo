//
//  HCEquityOrderModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCEquityOrderModel : NSObject

/**
 *  订单ID
 */
@property (nonatomic, strong) NSString *order_id;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  简介
 */
@property (nonatomic, strong) NSString *short_content;
/**
 *  封面
 */
@property (nonatomic, strong) NSString *cover_url;
/**
 *  筹款目标金额 单位万元
 */
@property (nonatomic, strong) NSString *target;
/**
 *  预约投资金额 单位万元
 */
@property (nonatomic, strong) NSString *total_fee;
/**
 *  状态：1待处理 2已预约 3待打款 4成功 5失败
 */
@property (nonatomic, strong) NSString *status;
/**
 *  状态名称
 */
@property (nonatomic, strong) NSString *status_name;
/**
 *  详情URL
 */
@property (nonatomic, strong) NSString *detail_url;
/**
 *  标题高度
 */
@property (nonatomic, assign) CGFloat textH;

@end
