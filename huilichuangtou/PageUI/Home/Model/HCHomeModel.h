//
//  HCHomeModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  首页-模型
 */
@interface HCHomeModel : NSObject

/**
 *  广告列表
 */
@property (nonatomic, strong) NSMutableArray *ad_list;
/**
 *  资讯列表
 */
@property (nonatomic, strong) NSMutableArray *news_list;
/**
 *  众筹列表
 */
@property (nonatomic, strong) NSMutableArray *crowd_list;
/**
 *  投资列表
 */
@property (nonatomic, strong) NSMutableArray *invest_list;

@end
