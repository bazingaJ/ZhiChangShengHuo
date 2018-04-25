//
//  HCChargesModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  提成-模型
 */
@interface HCChargesModel : NSObject

/**
 *  日期
 */
@property (nonatomic, strong) NSString *add_date;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  金额 单位元
 */
@property (nonatomic, strong) NSString *fee;

@end
