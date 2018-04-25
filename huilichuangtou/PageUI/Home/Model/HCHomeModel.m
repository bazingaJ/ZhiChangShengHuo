//
//  HCHomeModel.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCHomeModel.h"
#import "HCAdModel.h"
#import "HCNewsModel.h"
#import "HCEquityModel.h"
#import "HCTouziModel.h"

@implementation HCHomeModel

/**
 *  广告列表
 */
- (void)setAd_list:(NSMutableArray *)ad_list {
    _ad_list = [HCAdModel mj_objectArrayWithKeyValuesArray:ad_list];
}

/**
 *  广告列表
 */
- (void)setNews_list:(NSMutableArray *)news_list {
    _news_list = [HCNewsModel mj_objectArrayWithKeyValuesArray:news_list];
}

/**
 *  众筹列表
 */
- (void)setCrowd_list:(NSMutableArray *)crowd_list {
    _crowd_list = [HCEquityModel mj_objectArrayWithKeyValuesArray:crowd_list];
}

/**
 *  投资列表
 */
- (void)setInvest_list:(NSMutableArray *)invest_list {
    _invest_list = [HCTouziModel mj_objectArrayWithKeyValuesArray:invest_list];
}

@end
