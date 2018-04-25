//
//  XPAdModel.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/25.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 广告-模型
 */
@interface XPAdModel : NSObject

/**
 * 广告ID
 */
@property (nonatomic, strong) NSString *ad_id;
/**
 * 广告位置：1首页 2其他
 */
@property (nonatomic, strong) NSString *ad_position;
/**
 * 广告标题
 */
@property (nonatomic, strong) NSString *title;
/**
 * 类型：1条转APP内容 2H5
 */
@property (nonatomic, strong) NSString *type;
/**
 * 内容版块：1商户 2课程
 */
@property (nonatomic, strong) NSString *plate;
/**
 * 内容版块ID
 */
@property (nonatomic, strong) NSString *plate_id;
/**
 * 广告封面
 */
@property (nonatomic, strong) NSString *cover_src;
/**
 * 外链地址
 */
@property (nonatomic, strong) NSString *url;

@end
