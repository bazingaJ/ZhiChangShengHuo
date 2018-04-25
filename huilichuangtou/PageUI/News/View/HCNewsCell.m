//
//  HCNewsCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCNewsCell.h"

@implementation HCNewsCell

- (void)setNewsModel:(HCNewsModel *)model {
    if(!model) return;
    
    //创建“封面”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 95, 95)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
    [self.contentView addSubview:imgView];
    
    //创建“标题”
    NSString *titleStr = model.news_title;
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
    
    //创建“时间”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(115, 50, SCREEN_WIDTH-125, 20)];
    [lbMsg2 setText:model.add_time];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT11];
    [self.contentView addSubview:lbMsg2];
    
    //创建“内容”
    NSString *contentStr = model.short_content;
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(115, 70, SCREEN_WIDTH-125, 35)];
    [lbMsg3 setText:contentStr];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setNumberOfLines:2];
    [lbMsg3 setFont:FONT13];
    if(!IsStringEmpty(contentStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
        [lbMsg3 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg3];
    
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
