//
//  HCMineYuyueEquityCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineYuyueEquityCell.h"

@implementation HCMineYuyueEquityCell

- (void)setEquityModel:(HCEquityOrderModel *)model {
    if(!model) return;
    
    //创建“封面”
    NSString *imgURL = model.cover_url;
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 60)];
    [imgView2 setContentMode:UIViewContentModeScaleAspectFill];
    [imgView2 setClipsToBounds:YES];
    [imgView2 sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_rectangle_list"]];
    [self.contentView addSubview:imgView2];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, SCREEN_WIDTH-150, 20)];
    [lbMsg setText:model.title];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“描述”
    NSString *titleStr = model.short_content;
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, SCREEN_WIDTH-150, 40)];
    [lbMsg2 setText:titleStr];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setNumberOfLines:2];
    [lbMsg2 setFont:FONT13];
    if(!IsStringEmpty(titleStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, titleStr.length)];
        [lbMsg2 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
    //创建“信息”
    //预约状态
    NSString *statusStr = @"";
    if(!IsStringEmpty(model.status_name)) {
        statusStr = model.status_name;
    }
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.target],@"融资总金额"]];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.total_fee],@"预约金额"]];
    [titleArr addObject:@[statusStr,@"预约状态"]];
    
    CGFloat tWidth = SCREEN_WIDTH/[titleArr count];
    for (int i=0; i<[titleArr count]; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 80, tWidth-1, 50)];
        [self.contentView addSubview:backView];
        
        //创建“内容值”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tWidth, 20)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:ORANGE_COLOR];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT13];
        [backView addSubview:lbMsg];
        
        //创建“标题”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, tWidth, 20)];
        [lbMsg2 setText:itemArr[1]];
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg2 setFont:FONT12];
        [backView addSubview:lbMsg2];
        
        if(i<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tWidth-0.5, 0, 0.5, 50)];
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
