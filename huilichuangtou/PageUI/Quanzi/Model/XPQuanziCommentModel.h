//
//  XPQuanziCommentModel.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  圈子评论-模型
 */
@interface XPQuanziCommentModel : NSObject

/**
 *  评论编号
 */
@property (strong, nonatomic) NSString *comment_id;
/**
 *  用户ID
 */
@property (strong, nonatomic) NSString *user_id;
/**
 *  评论内容
 */
@property (strong, nonatomic) NSString *content;
/**
 *  用户昵称
 */
@property (strong, nonatomic) NSString *user_nickname;
/**
 *  用户头像
 */
@property (strong, nonatomic) NSString *user_avatar;
/**
 *  评论事件
 */
@property (strong, nonatomic) NSString *date;

@property (assign, nonatomic) CGFloat textH;
@property (assign, nonatomic) CGFloat cellH;

@end
