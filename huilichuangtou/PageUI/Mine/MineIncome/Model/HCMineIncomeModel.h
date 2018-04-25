//
//  HCMineIncomeModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/31.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  我的收益
 */
@interface HCMineIncomeModel : NSObject

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
