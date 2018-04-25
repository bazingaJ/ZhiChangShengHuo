//
//  HCMineTouziEquityCell.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMineTouziEquityModel.h"

@protocol HCMineTouziEquityCellDelegate <NSObject>

- (void)HCMineTouziEquityCellClick:(HCMineTouziEquityModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface HCMineTouziEquityCell : UITableViewCell

@property (assign) id<HCMineTouziEquityCellDelegate> delegate;
- (void)setMineTouziEquityModel:(HCMineTouziEquityModel *)model indexPath:(NSIndexPath *)indexPath;

@end
