//
//  XPQuanziModel.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  圈子-模型
 */
@interface XPQuanziModel : NSObject

/**
 *  新鲜事ID
 */
@property (nonatomic, strong) NSString *dynamic_id;
/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  用户昵称
 */
@property (nonatomic, strong) NSString *user_nickname;
/**
 *  用户头像
 */
@property (nonatomic, strong) NSString *user_avatar;
/**
 *  发布的内容
 */
@property (nonatomic, strong) NSString *content;
/**
 *  定位地址
 */
@property (nonatomic, strong) NSString *address;
/**
 *  发布时间
 */
@property (nonatomic, strong) NSString *date;
/**
 *  点赞数
 */
@property (nonatomic, strong) NSString *praise_num;
/**
 *  是否点过赞:1是 2否
 */
@property (nonatomic, strong) NSString *is_praise;
/**
 *  评论数
 */
@property (nonatomic, strong) NSString *comment_num;
/**
 *  新鲜事图片数组
 */
@property (nonatomic, strong) NSMutableArray *imgs;
/**
 *  分享地址
 */
@property (nonatomic, strong) NSString *share_url;
/**
 *  内容文本高度
 */
@property (assign, nonatomic) CGFloat textH;
/**
 *  单元格高度
 */
@property (assign, nonatomic) CGFloat cellH;

@end
