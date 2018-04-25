//
//  HCTouziCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCTouziCell.h"

@implementation HCTouziCell

- (void)setTouziModel:(HCTouziModel *)model {
    if(!model) return;
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
    [lbMsg setText:model.title];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“状态” 1预热中 2新品 3完成
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 40, 40)];
    if([model.status isEqualToString:@"1"]) {
        //预热中
        [imgView setImage:[UIImage imageNamed:@"xiangmu_icon_yure"]];
    }else if([model.status isEqualToString:@"2"]) {
        //新品
        [imgView setImage:[UIImage imageNamed:@"xiangmu_icon_new"]];
    }else if([model.status isEqualToString:@"3"]) {
        //完成
        [imgView setImage:[UIImage imageNamed:@"xiangmu_icon_finished"]];
    }
    [self.contentView addSubview:imgView];
    
    //创建“截止日期”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, SCREEN_WIDTH-60, 15)];
    if([model.status isEqualToString:@"1"]) {
        //预热中
        [lbMsg2 setText:[NSString stringWithFormat:@"预约开始时间：%@",model.end_date]];
    }else {
        [lbMsg2 setText:[NSString stringWithFormat:@"截止时间：%@",model.end_date]];
    }
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT10];
    [self.contentView addSubview:lbMsg2];
    
    //创建”分割线“
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
    //创建“信息”
    
    //出让股权
    NSString *incomeStr = @"0%";
    if(!IsStringEmpty(model.income)) {
        incomeStr = [model.income stringByAppendingString:@"%"];
    }
    
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.invest_total_fee],@"总额度"]];
    [titleArr addObject:@[incomeStr,@"拟定年收益"]];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@天",model.deadline],@"投资期限"]];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.can_fee],@"可投金额"]];
    
    CGFloat tWidth = SCREEN_WIDTH/[titleArr count];
    for (int i=0; i<[titleArr count]; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 60, tWidth-1, 60)];
        [self.contentView addSubview:backView];
        
        //创建“内容值”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tWidth, 20)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:ORANGE_COLOR];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT15];
        [backView addSubview:lbMsg];
        
        //创建“标题”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, tWidth, 20)];
        [lbMsg2 setText:itemArr[1]];
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg2 setFont:FONT11];
        [backView addSubview:lbMsg2];
        
        if(i<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tWidth-0.5, 0, 0.5, 60)];
            [lineView setBackgroundColor:LINE_COLOR];
            [backView addSubview:lineView];
        }
    }
    
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
