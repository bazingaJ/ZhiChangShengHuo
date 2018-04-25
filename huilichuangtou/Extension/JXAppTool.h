//
//  JXAppTool.h
//  BZWKuaiYun
//
//  Created by Jessey Young on 2017/5/19.
//  Copyright © 2017年 ISU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JXAppTool : NSObject

//获取当前正在显示的视图控制器
+ (UIViewController*)currentViewController;


/**
 @brief 把color变成image
 @param color 传来的color
 @return 返回iamge
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;


/**
 转换日期类型成为发请求的服务器要求格式字符串

 @param date 转换前的日期类型
 @return 转换后的字符串类型
 */
+ (NSString *)transformServerFormatStringByAnydate:(NSDate *)date;
/**
 转换日期类型成为字符串类型

 @param date 转换前的日期类型
 @return 转换后的字符串类型
 */
+ (NSString *)transformLocalStringByAnydate:(NSDate *)date;
/**
 @brief 获取当前的年月
 @return 返回的年月字符串 格式是YYYY-MM-DD
 */
+ (NSDate *)getCurrentTime;

+ (NSDate *)getYesterdayTimeByRandomTime:(NSDate *)date;
+ (NSDate *)getTomorrowTimeByRandomTime:(NSDate *)date;



/**
 @brief 获取当前的年

 @return 返回当前的年
 */
+ (NSInteger)getNowYearStr;

/**
 @brief 获取当前的年月

 @return 返回当前的年月
 */
+ (NSString *)getNowMonthStr;

/**
 @brief 获取当前所有时间日期
 
 @return 返回当前的所有时间日期
 */
+ (NSString *)getWholeStrYMDHMS;

/**
 @brief 获取MD5加密数据
 @param string 加密前的数据
 @return 加密后的数据
 */
+ (NSString *)MD5EncryptionWithString:(NSString *)string;

/**
 字典转json字符串方法

 @param dict 需要转换的字典
 @return 返回的JSON字符串
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//判断是否 版本相同
+ (BOOL)isSameVersion;


/**
 @brief 把分转换成元

 @param penny 分
 @return 元
 */
+ (NSString *)transforMoneyGetPenny:(NSString *)penny;



/**
 @brief 验证字符串的有效性

 @param string 待验证字符串
 @return 返回是否有效
 */
+ (BOOL)verifyIsNullString:(NSString *)string;

/**
 @brief 系统弹窗

 @param viewController 展示的控制器
 @param title 弹窗的标题
 @param msg 弹窗信息
 @param btnTitle 确定按钮的标题
 @param cancelTitle 取消按钮的标题
 */
+ (void)showAlertViewNeedShowViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)msg SurebuttonTitle:(NSString *)btnTitle cancelButtonTitle:(NSString *)cancelTitle;

/**
 @brief 获取存储到沙盒的路径

 @param fileName 自定义文件名称
 @return 返回完整文件路径
 */
+ (NSString *)getFilePathWithFileName:(NSString *)fileName;





@end
