//
//  HCTouziModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  投资-模型
 */
@interface HCTouziModel : NSObject

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *invest_id;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  截止日期
 */
@property (nonatomic, strong) NSString *end_date;
/**
 *  投资总金额 单位万元
 */
@property (nonatomic, strong) NSString *invest_total_fee;
/**
 *  投资回报率 单位%
 */
@property (nonatomic, strong) NSString *income;
/**
 *  投资期限
 */
@property (nonatomic, strong) NSString *deadline;
/**
 *  可投资金额 单位万元
 */
@property (nonatomic, strong) NSString *can_fee;
/**
 *  项目状态：1预热中 2新品 3完成
 */
@property (nonatomic, strong) NSString *status;
/**
 *  项目状态名称
 */
@property (nonatomic, strong) NSString *status_name;
/**
 *  详情URL地址
 */
@property (nonatomic, strong) NSString *detail_url;
/**
 *  可购买状态 1可购买 2不可购买
 */
@property (nonatomic, strong) NSString *buy_status;
/**
 *  最小投资金额 单位万元
 */
@property (nonatomic, strong) NSString *min_fee;
/**
 *  最大投资金额 单位万元
 */
@property (nonatomic, strong) NSString *max_fee;

@end
