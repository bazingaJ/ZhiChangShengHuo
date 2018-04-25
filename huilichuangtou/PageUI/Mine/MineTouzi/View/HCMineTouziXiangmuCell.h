//
//  HCMineTouziXiangmuCell.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMineTouziXiangmuModel.h"

@protocol HCMineTouziXiangmuCellDelegate <NSObject>

- (void)HCMineTouziXiangmuCellClick:(HCMineTouziXiangmuModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface HCMineTouziXiangmuCell : UITableViewCell

@property (assign) id<HCMineTouziXiangmuCellDelegate> delegate;
- (void)setMineTouziXiangmuModel:(HCMineTouziXiangmuModel *)model indexPath:(NSIndexPath *)indexPath;

@end
