//
//  HCURLManager.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCURLManager : NSObject

/**
 *  创建单例模式
 */
+ (instancetype)manager;

/**
 *  开机图
 */
@property (nonatomic, strong) NSString *open_img;
/**
 *  关于我们
 */
@property (nonatomic, strong) NSString *about_url;
/**
 *  帮助
 */
@property (nonatomic, strong) NSString *help_url;
/**
 *  用户使用协议
 */
@property (nonatomic, strong) NSString *user_url;
/**
 *  电话
 */
@property (nonatomic, strong) NSString *hotline;
/**
 *  审核版本号
 */
@property (nonatomic, strong) NSString *audit_version;

@end
