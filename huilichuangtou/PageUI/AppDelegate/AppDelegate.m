//
//  AppDelegate.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "AppDelegate.h"
#import "HCLoginViewController.h"
#import "AppDelegate+UMSoc.h"
#import "AppDelegate+JPUSH.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化友盟
    [self setupUMSocial];
    
    //初始化极光推送
    [self setupJPUSH:launchOptions];
    
    //配置定位
    [self configLocationManager];
    
    //设置根目录
    [self setWindowAndRootViewController];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)userLogin:(void (^)(BOOL isLogin))completion {
    
    dispatch_async(dispatch_get_main_queue(), ^
   {
       //界面条转
       HCLoginViewController *loginView = [HCLoginViewController  new];
       loginView.callback = ^(BOOL isLogin) {
           completion(isLogin);
       };
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
       [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
       
   });
    
}

//设置定位
- (void)configLocationManager {
    //设置APIKey
    if ([APIKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
    //[AMapLocationServices sharedServices].apiKey = (NSString *)APIKey;
    
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //设置允许在后台定位
    //[self.locationManager setAllowsBackgroundLocationUpdates:YES];
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    
    //开始进行连续定位
    [self.locationManager startUpdatingLocation];
    //    //停止定位
    //    [self.locationManager stopUpdatingLocation];
}

/**
 *  定位失败
 */
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

/**
 *  定位结果
 */
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
}


@end
