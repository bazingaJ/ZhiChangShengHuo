//
//  HCMineMessageCell.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMineMessageModel.h"

@protocol HCMineMessageCellDelegate <NSObject>

- (void)HCMineMessageCellClick:(HCMineMessageModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface HCMineMessageCell : UITableViewCell

@property (assign) id<HCMineMessageCellDelegate> delegate;
- (void)setMineMessageModel:(HCMineMessageModel *)model indexPath:(NSIndexPath *)indexPath;

@end
