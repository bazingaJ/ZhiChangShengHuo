//
//  HCAdModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  广告-模型
 */
@interface HCAdModel : NSObject

/**
 *  广告ID
 */
@property (nonatomic, strong) NSString *ad_id;
/**
 *  广告位：1首页 2其他
 */
@property (nonatomic, strong) NSString *ad_position;
/**
 *  广告标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  类型：1条转APP内容 2H5
 */
@property (nonatomic, strong) NSString *type;
/**
 *  平台类型：1商户 2课程
 */
@property (nonatomic, strong) NSString *plate;
/**
 *  平台类型对应的ID
 */
@property (nonatomic, strong) NSString *plate_id;
/**
 *  广告封面
 */
@property (nonatomic, strong) NSString *cover_url;
/**
 *  广告URL地址
 */
@property (nonatomic, strong) NSString *url;

@end
