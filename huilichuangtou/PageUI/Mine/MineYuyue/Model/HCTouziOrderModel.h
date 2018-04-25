//
//  HCTouziOrderModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  投资项目-模型
 */
@interface HCTouziOrderModel : NSObject

/**
 *  订单ID
 */
@property (nonatomic, strong) NSString *order_id;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  预约金额 单位万元
 */
@property (nonatomic, strong) NSString *total_fee;
/**
 *  项目编号
 */
@property (nonatomic, strong) NSString *number;
/**
 *  分类ID
 */
@property (nonatomic, strong) NSString *cate_id;
/**
 *  分类名称
 */
@property (nonatomic, strong) NSString *cate_name;
/**
 *  银行名称
 */
@property (nonatomic, strong) NSString *bank_name;
/**
 *  户主
 */
@property (nonatomic, strong) NSString *account_name;
/**
 *  卡号
 */
@property (nonatomic, strong) NSString *bank_no;
/**
 *  投资总额度
 */
@property (nonatomic, strong) NSString *invest_total_fee;
/**
 *  投资期限
 */
@property (nonatomic, strong) NSString *deadline;
/**
 *  投资回报率
 */
@property (nonatomic, strong) NSString *income;
/**
 *  状态：1待处理 2已预约 3待打款 4成功 5失败 6已兑换 7已取消
 */
@property (nonatomic, strong) NSString *status;
/**
 *  状态名称
 */
@property (nonatomic, strong) NSString *status_name;
/**
 *  简介
 */
@property (nonatomic, strong) NSString *short_content;
/**
 *  详情URL
 */
@property (nonatomic, strong) NSString *detail_url;
/**
 *  单元区高度
 */
@property (nonatomic, assign) CGFloat cellH;

@end
