//
//  JXAppTool.m
//  BZWKuaiYun
//
//  Created by Jessey Young on 2017/5/19.
//  Copyright © 2017年 ISU. All rights reserved.
//

#import "JXAppTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JXAppTool

//获取当前正在显示的视图控制器
+ (UIViewController*)currentViewController
{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController)
        {
            vc = vc.presentedViewController;
        }
        else
        {
            break;
        }
    }
    return vc;
}


+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
+ (NSString *)transformServerFormatStringByAnydate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}
+ (NSString *)transformLocalStringByAnydate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}
+ (NSDate *)getCurrentTime
{
    return [NSDate date];
}
+ (NSDate *)getYesterdayTimeByRandomTime:(NSDate *)date
{
    NSDate *lastDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
    return lastDate;
}
+ (NSDate *)getTomorrowTimeByRandomTime:(NSDate *)date
{
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
    return nextDate;
}
+ (NSInteger)getNowYearStr
{
    NSDate *date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY"];
    NSString *dateStr = [format stringFromDate:date];
    return [dateStr integerValue];
}

+ (NSString *)getNowMonthStr
{
    NSDate *date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}

+ (NSString *)getWholeStrYMDHMS
{
    NSDate *date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    format.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
}

+ (NSString *)MD5EncryptionWithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    NSString *MD5String = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
    return MD5String;
}

// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil)
    {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];
    
    if(err)
    {
//        JXLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (BOOL)verifyIsNullString:(NSString *)string
{
    NSString *str = @"";
    if ([string isKindOfClass:[NSNumber class]])
    {
        str = [NSString stringWithFormat:@"%@",string];
    }
    else
    {
        str = string;
    }
    
    return (str == nil || [str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] ||str.length <= 0);
}

+ (void)showAlertViewNeedShowViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)msg SurebuttonTitle:(NSString *)btnTitle cancelButtonTitle:(NSString *)cancelTitle
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [viewController presentViewController:alert animated:YES completion:nil];
}


@end
