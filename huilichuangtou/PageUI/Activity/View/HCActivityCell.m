//
//  HCActivityCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/11/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCActivityCell.h"

@implementation HCActivityCell

- (void)setActivityModel:(HCActivityModel *)model {
    if(!model) return;
    
    //创建“封面”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 95, 95)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
    [self.contentView addSubview:imgView];
    
    //创建“标题”
    NSString *titleStr = model.title;
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(115, 10, SCREEN_WIDTH-125, model.textH)];
    [lbMsg setText:titleStr];
    [lbMsg setTextColor:[UIColor blackColor]];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setNumberOfLines:2];
    [lbMsg setFont:FONT16];
    if(!IsStringEmpty(titleStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, titleStr.length)];
        [lbMsg setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg];
    
    //创建“活动时间”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(115, 85, SCREEN_WIDTH-125, 20)];
    [lbMsg2 setText:[NSString stringWithFormat:@"活动时间：%@",model.date]];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT11];
    [self.contentView addSubview:lbMsg2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 114.5, SCREEN_WIDTH, 0.5)];
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
