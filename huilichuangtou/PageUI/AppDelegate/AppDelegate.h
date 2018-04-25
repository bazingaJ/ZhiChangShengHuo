//
//  AppDelegate.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "APIKey.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,AMapLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) AMapLocationManager *locationManager;

/**
 *  纬度
 */
@property (nonatomic, assign) CGFloat latitude;
/**
 *  经度
 */
@property (nonatomic, assign) CGFloat longitude;
/**
 *  地理编码
 */
@property (nonatomic, strong) NSString *adcode;
/**
 *  是否使用
 */
@property (nonatomic, assign) BOOL isOK;
/**
 *  用户登录
 */
- (void)userLogin:(void (^)(BOOL isLogin))completion;

@end

