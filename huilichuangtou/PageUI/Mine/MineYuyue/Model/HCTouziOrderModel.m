//
//  HCTouziOrderModel.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCTouziOrderModel.h"

@implementation HCTouziOrderModel

- (CGFloat)cellH {
    if([self.status isEqualToString:@"1"] ||
       [self.status isEqualToString:@"2"] ||
       [self.status isEqualToString:@"3"]) {
        return 205+45;
    }else{
        return 205;
    }
}

@end
