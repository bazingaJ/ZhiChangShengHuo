//
//  HCMineYuyueTouziCell.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTouziOrderModel.h"

@protocol HCMineYuyueTouziCellDelegate <NSObject>

- (void)HCMineYuyueTouziCellClick:(HCTouziOrderModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath;

@end

@interface HCMineYuyueTouziCell : UITableViewCell

@property (assign) id<HCMineYuyueTouziCellDelegate> delegate;
- (void)setTouziOrderModel:(HCTouziOrderModel *)model indexPath:(NSIndexPath *)indexPath;

@end
