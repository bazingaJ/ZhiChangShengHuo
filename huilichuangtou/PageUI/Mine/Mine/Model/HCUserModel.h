//
//  HCUserModel.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  个人信息-模型
 */
@interface HCUserModel : NSObject

/**
 *  用户编号
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  手机号码
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  昵称
 */
@property (nonatomic, strong) NSString *nickname;
/**
 *  姓名
 */
@property (nonatomic, strong) NSString *realname;
/**
 *  头像
 */
@property (nonatomic, strong) NSString *avatar;
/**
 *  群组名称
 */
@property (nonatomic, strong) NSString *group_name;
/**
 *  职位名称
 */
@property (nonatomic, strong) NSString *position_name;
/**
 *  生日
 */
@property (nonatomic, strong) NSString *birthday;
/**
 *  联系电话
 */
@property (nonatomic, strong) NSString *tel;
/**
 *  信用等级
 */
@property (nonatomic, strong) NSString *level;
/**
 *  信用等级名称
 */
@property (nonatomic, strong) NSString *level_name;
/**
 *  省份ID
 */
@property (nonatomic, strong) NSString *province_id;
/**
 *  城市ID
 */
@property (nonatomic, strong) NSString *city_id;
/**
 *  区域ID
 */
@property (nonatomic, strong) NSString *area_id;
/**
 *  区域名称
 */
@property (nonatomic, strong) NSString *area_name;
/**
 *  详细地址
 */
@property (nonatomic, strong) NSString *address;
/**
 *  身份证号
 */
@property (nonatomic, strong) NSString *idcard_no;
/**
 *  手持身份证图片
 */
@property (nonatomic, strong) NSString *idcard_hand_img;
/**
 *  身份证正面图片
 */
@property (nonatomic, strong) NSString *idcard_face_img;
/**
 *  身份证反面图片
 */
@property (nonatomic, strong) NSString *idcard_opposite_img;

@end
