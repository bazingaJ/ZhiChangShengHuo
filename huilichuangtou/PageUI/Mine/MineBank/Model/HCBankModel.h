//
//  HCBankModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  银行卡-模型
 */
@interface HCBankModel : NSObject

/**
 *  银行ID
 */
@property (nonatomic, strong) NSString *bank_id;
/**
 *  银行名称
 */
@property (nonatomic, strong) NSString *bank_name;
/**
 *  银行卡类型
 */
@property (nonatomic, strong) NSString *bank_type;
/**
 *  银行LOG地址
 */
@property (nonatomic, strong) NSString *logo;
/**
 *  银行卡号
 */
@property (nonatomic, strong) NSString *card_no;
@property (nonatomic, strong) NSString *card_no_old;

///阿里API接口返回数据模型

/**
 *  银行(招商银行)
 */
@property (nonatomic, strong) NSString *bank;
/**
 *  银行卡号(6214830254338725)
 */
@property (nonatomic, strong) NSString *bankcard;
/**
 *  银行卡号(03080000)
 */
@property (nonatomic, strong) NSString *bankno;
/**
 *  省份名称
 */
@property (nonatomic, strong) NSString *province;
/**
 *  城市名称
 */
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *iscorrect;
/**
 *  银行卡长度
 */
@property (nonatomic, strong) NSString *len;
/**
 *  名称(银联IC普卡)
 */
@property (nonatomic, strong) NSString *name;
/**
 *  客服电话
 */
@property (nonatomic, strong) NSString *tel;
/**
 *  类型(借记卡)
 */
@property (nonatomic, strong) NSString *type;
/**
 *  官方网址
 */
@property (nonatomic, strong) NSString *website;

@end
