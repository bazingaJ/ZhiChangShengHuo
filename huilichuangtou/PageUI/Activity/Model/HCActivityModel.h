//
//  HCActivityModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/11/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  活动-模型
 */
@interface HCActivityModel : NSObject

/**
 *  ID
 */
@property (nonatomic, strong) NSString *activity_id;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  内容
 */
@property (nonatomic, strong) NSString *content;
/**
 *  封面
 */
@property (nonatomic, strong) NSString *cover_url;
/**
 *  图添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 *  地址
 */
@property (nonatomic, strong) NSString *address;
/**
 *  活动日期
 */
@property (nonatomic, strong) NSString *date;
/**
 *  标题高度
 */
@property (nonatomic, assign) CGFloat textH;

@end
