//
//  HCMineTouziEquityModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  我的投资-股权众筹-模型
 */
@interface HCMineTouziEquityModel : NSObject

/**
 *  订单ID
 */
@property (nonatomic, strong) NSString *order_id;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
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
 *  是否已分配股权 1已分配 2未分配
 */
@property (nonatomic, strong) NSString *is_distribution;
/**
 *  股权百分比 单位 %
 */
@property (nonatomic, strong) NSString *distribution;
/**
 *  简介
 */
@property (nonatomic, strong) NSString *short_content;
/**
 *  详情URL
 */
@property (nonatomic, strong) NSString *detail_url;
/**
 *  合同URL
 */
@property (nonatomic, strong) NSString *contract_url;
/**
 *  标题高度
 */
@property (nonatomic, assign) CGFloat textH;


@end
