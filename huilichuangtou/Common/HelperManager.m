//
//  HelperManager.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "HelperManager.h"

@implementation HelperManager

/**
 *  创建单例模式
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
static HelperManager *_createInstance;
+ (HelperManager *)CreateInstance{
    if (!_createInstance){
        _createInstance = [[super allocWithZone:NULL] init];
    }
    return _createInstance;
}

/**
 *  是否已登录
 */
- (BOOL)isLogin {
    if(IsStringEmpty(self.user_id)) {
        return NO;
    }
    return YES;
}

/**
 *  是否登录
 */
- (BOOL)isLogin:(BOOL)isAuth completion:(void (^)(NSInteger tIndex))completion {
    if(![self isLogin]) {
        
        //用户登录
        [APP_DELEGATE userLogin:^(BOOL isLogin) {
            if(completion) {
                completion(isLogin);
            }
        }];
        
        return NO;
    }
    if(isAuth) {
        //认证处理
        
        if(IsStringEmpty(self.realname) ||
           IsStringEmpty(self.idcard_no)) {
            
            [MBProgressHUD showError:@"您的信息未完善,请完善信息" toView:nil];
            
            return NO;
        }
        
        return YES;
    }
    return YES;
}

/**
 *  获取用户信息
 */
- (NSDictionary *)getUserDefaultInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefaults objectForKey:@"userInfo"];
    return userDic;
}

/**
 *  Token验证
 */
- (NSString *)token {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *token = [userDic objectForKey:@"token"];
    return token;
}

/**
 *  用户ID
 */
- (NSString *)user_id {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *user_id = [userDic objectForKey:@"user_id"];
    return user_id;
}

/**
 *  昵称
 */
- (NSString *)nickname {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *nickname = [userDic objectForKey:@"nickname"];
    return nickname;
}

/**
 *  真实姓名
 */
- (NSString *)realname {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *realname = [userDic objectForKey:@"realname"];
    return realname;
}

/**
 *  用户头像
 */
- (NSString *)avatar {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *icon_src = [userDic objectForKey:@"avatar"];
    return icon_src;
}

/**
 *  手机号码
 */
- (NSString *)mobile {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *mobile = [userDic objectForKey:@"mobile"];
    return mobile;
}

/**
 *  身份证号
 */
- (NSString *)idcard_no {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *idcard_no = [userDic objectForKey:@"idcard_no"];
    return idcard_no;
}

/**
 *  清除账号
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
- (void)clearAcc {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"userInfo"];
    [userDefault synchronize];
}

/**
 *  获取APP版本号
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
- (NSString *)getAppVersion {
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

/**
 *  获取APP名称
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
- (NSString *)getAppName {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return appName;
}

/**
 *  获取IDFA
 */
- (NSString *)getIDFA {
    //广告表示ID
    NSString *idfaStr = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    idfaStr = [idfaStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return idfaStr;
}

//支付支付穿处理
- (NSDictionary *)dictionaryFromURLParameters:(NSString *)str
{
    NSArray *pairs = [str componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        val = [val stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}

@end
