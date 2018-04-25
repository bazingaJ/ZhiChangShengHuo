//
//  HCCommissionModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCommissionModel : NSObject

/**
 *  群身份
 */
@property (nonatomic, strong) NSString *identity;
/**
 *  总佣金 单位元
 */
@property (nonatomic, strong) NSString *charges_total_fee;
/**
 *  已领取佣金 单位元
 */
@property (nonatomic, strong) NSString *charges_deal_fee;
/**
 *  未领取佣金 单位元
 */
@property (nonatomic, strong) NSString *charges_yet_fee;

@end
