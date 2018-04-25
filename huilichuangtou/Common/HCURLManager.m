//
//  XPURLManager.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCURLManager.h"

@implementation HCURLManager

/**
 *  创建单例模式
 */
+ (instancetype)manager {
    //单例
    static HCURLManager *entity = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        entity = [[HCURLManager alloc] init];
    });
    return entity;
}

@end
