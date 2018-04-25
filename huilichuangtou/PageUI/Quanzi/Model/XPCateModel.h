//
//  XPCateModel.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  资讯分类-模型
 */
@interface XPCateModel : NSObject

/**
 *  分类ID
 */
@property (nonatomic, strong) NSString *cate_id;
/**
 *  分类名称
 */
@property (nonatomic, strong) NSString *cate_name;
/**
 *  分类LOGO
 */
@property (nonatomic, strong) NSString *logo_url;

@end
