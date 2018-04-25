//
//  HCEquityCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCEquityCell.h"

@implementation HCEquityCell

- (void)setEquityModel:(HCEquityModel *)model {
    if(!model) return;
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
    [lbMsg setText:model.title];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“项目状态”：1预热中 2新品 3完成
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
    
    //创建”分割线“
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
    //创建“封面”
    NSString *imgURL = model.cover_url;
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 120, 60)];
    [imgView2 setContentMode:UIViewContentModeScaleAspectFill];
    [imgView2 setClipsToBounds:YES];
    [imgView2 sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_rectangle_list"]];
    [self.contentView addSubview:imgView2];
    
    //创建“描述”
    NSString *titleStr = model.short_content;
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(140, 50, SCREEN_WIDTH-215, model.textH)];
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
    
    //创建“进度”
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 50, 50, 50)];
    [imgView3 setImage:[UIImage imageNamed:@"xiangmu_icon_schedule"]];
    [self.contentView addSubview:imgView3];
    
    //创建“数字”
    NSString *percentStr = @"0%";
    if(!IsStringEmpty(model.percentum)) {
        percentStr = [model.percentum stringByAppendingString:@"%"];
    }
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(7.5, 15, 35, 20)];
    [lbMsg4 setText:percentStr];
    [lbMsg4 setTextColor:ORANGE_COLOR];
    [lbMsg4 setTextAlignment:NSTextAlignmentCenter];
    [lbMsg4 setFont:FONT10];
    [imgView3 addSubview:lbMsg4];
    
    //创建“目标、已募”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(140, 95, SCREEN_WIDTH-215, 15)];
    [lbMsg3 setText:[NSString stringWithFormat:@"目标：%@万 已募%@万",model.target,model.finish]];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT10];
    [self.contentView addSubview:lbMsg3];
    
    //创建“分割线”
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 119.5, SCREEN_WIDTH, 0.5)];
    [lineView2 setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView2];
    
    //创建“信息”
    
    //融资轮次
    NSString *vcStr = @"";
    if(!IsStringEmpty(model.vc_rate_name)) {
        vcStr = model.vc_rate_name;
    }
    //出让股权
    NSString *sellStr = @"0%";
    if(!IsStringEmpty(model.sell)) {
        sellStr = [model.sell stringByAppendingString:@"%"];
    }
    //截止日期
    NSString *endDate = @"";
    if(!IsStringEmpty(model.end_date)) {
        endDate = model.end_date;
    }
    
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[vcStr,@"融资轮次"]];
    [titleArr addObject:@[sellStr,@"出让股权"]];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.add_fee],@"起投金额"]];
    [titleArr addObject:@[endDate,@"截止时间"]];
    
    CGFloat tWidth = SCREEN_WIDTH/[titleArr count];
    for (int i=0; i<[titleArr count]; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 120, tWidth-1, 50)];
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
