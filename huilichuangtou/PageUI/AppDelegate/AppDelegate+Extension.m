//
//  AppDelegate+Extension.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/1/12.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "KTabBarController.h"
#import <objc/runtime.h>
#import "HcdGuideView.h"
#import "AppDelegate+XHLaunchAd.h"
#import "AppDelegate+Data.h"

static const void *strLaunchSrcKey = &strLaunchSrcKey;

@implementation AppDelegate (Extension)

- (void)setLaunchSrc:(NSString *)launchSrc {
    objc_setAssociatedObject(self, & strLaunchSrcKey, launchSrc, OBJC_ASSOCIATION_COPY);
}

- (NSString *)launchSrc {
    return objc_getAssociatedObject(self, &strLaunchSrcKey);
}

/**
 *  设置Window和rootViewController
 */
- (void)setWindowAndRootViewController {
    //设置全局变量
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:MAIN_COLOR];
    [[UINavigationBar appearance] setTintColor:WHITE_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                                          NSForegroundColorAttributeName, nil]];
    
    //获取系统参数
    HCURLManager *entity = [self getSystemInfo];
    if(!entity) {
        entity = [HCURLManager new];
        entity.audit_version = APP_Version;
    }
    self.isOK = [entity.audit_version isEqualToString:APP_Version];
    
    //进入主界面
    [self enterMainVC];
    
    BOOL isShow = [HcdGuideView isShow];
    if(isShow && self.isOK) {
        //显示引导页
        NSMutableArray *imgArr = [NSMutableArray new];
        [imgArr addObject:[UIImage imageNamed:@"guide01"]];
        [imgArr addObject:[UIImage imageNamed:@"guide02"]];
        [imgArr addObject:[UIImage imageNamed:@"guide03"]];

        HcdGuideView *guideView = [HcdGuideView sharedInstance];
        guideView.window = self.window;
        [guideView showGuideViewWithImages:imgArr
                            andButtonTitle:@"立即体验"
                       andButtonTitleColor:[UIColor whiteColor]
                          andButtonBGColor:MAIN_COLOR
                      andButtonBorderColor:MAIN_COLOR];
    }else{
        //显示启动页
        //获取系统参数
        NSString *openSrc = [HCURLManager manager].open_img;
        [self setupXHLaunchAd:openSrc];
    }
    
}

//进入App主界面
- (void)enterMainVC {
    //进入主页入口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //创建“底部菜单”
    KTabBarController *tabBar = [[KTabBarController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:tabBar];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
}

@end
