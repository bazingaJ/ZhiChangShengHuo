//
//  HCNewsModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  资讯-模型
 */
@interface HCNewsModel : NSObject

/**
 *  资讯ID
 */
@property (nonatomic, strong) NSString *news_id;
/**
 *  资讯标题
 */
@property (nonatomic, strong) NSString *news_title;
/**
 *  简介
 */
@property (nonatomic, strong) NSString *short_content;
/**
 *  封面
 */
@property (nonatomic, strong) NSString *cover;
/**
 *  图添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 *  图添加时间
 */
@property (nonatomic, strong) NSString *url;
/**
 *  标题高度
 */
@property (nonatomic, assign) CGFloat textH;

@end
