//
//  HCMineIncomeCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/31.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineIncomeCell.h"

@implementation HCMineIncomeCell

- (void)setMineIncomeModel:(HCMineIncomeModel *)model {
    if(!model) return;
    
    CGFloat tWidth = SCREEN_WIDTH/3;
    
    //创建“时间”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tWidth-20, 25)];
    [lbMsg setText:model.add_date];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT15];
    [self.contentView addSubview:lbMsg];
    
    //创建“项目名称”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(tWidth+10, 10, tWidth-20, 25)];
    [lbMsg2 setText:model.title];
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
    [lbMsg2 setFont:FONT15];
    [self.contentView addSubview:lbMsg2];
    
    //创建“提成金额”
    NSString *totalFee = @"0";
    if(!IsStringEmpty(model.fee)) {
        totalFee = model.fee;
    }
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(tWidth*2+10, 10, tWidth-20, 25)];
    [lbMsg3 setText:[NSString stringWithFormat:@"%.2f",[totalFee floatValue]]];
    [lbMsg3 setTextColor:ORANGE_COLOR];
    [lbMsg3 setTextAlignment:NSTextAlignmentCenter];
    [lbMsg3 setFont:FONT15];
    [self.contentView addSubview:lbMsg3];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
