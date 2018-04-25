//
//  HCEquityModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCEquityModel : NSObject

/**
 *  众筹项目ID
 */
@property (nonatomic, strong) NSString *crowd_id;
/**
 *  封面
 */
@property (nonatomic, strong) NSString *cover_url;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  简介
 */
@property (nonatomic, strong) NSString *short_content;
/**
 *  完成度百分比 单位%
 */
@property (nonatomic, strong) NSString *percentum;
/**
 *  目标金额 单位万元
 */
@property (nonatomic, strong) NSString *target;
/**
 *  已众筹金额 单位万元
 */
@property (nonatomic, strong) NSString *finish;
/**
 *  融资轮次
 */
@property (nonatomic, strong) NSString *vc_rate_name;
/**
 *  出让股权比例 单位%
 */
@property (nonatomic, strong) NSString *sell;
/**
 *  起投金额 单位万元
 */
@property (nonatomic, strong) NSString *add_fee;
/**
 *  截止日期
 */
@property (nonatomic, strong) NSString *end_date;
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
 *  标题高度
 */
@property (nonatomic, assign) CGFloat textH;

@end
