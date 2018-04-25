//
//  XPQuanziCommentCell.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziCommentCell.h"

@implementation XPQuanziCommentCell

- (void)setQuanziCommentModel:(XPQuanziCommentModel *)model {
    if(!model) return;
    
    //创建“头像”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 35, 35)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView.layer setCornerRadius:17.5];
    [imgView.layer setMasksToBounds:YES];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    [self.contentView addSubview:imgView];
    
    //创建“用户名”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 120, 20)];
    [lbMsg setText:model.user_nickname];
    [lbMsg setTextColor:COLOR6];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“评论时间”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(55, 40, 120, 20)];
    [lbMsg2 setText:model.date];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT12];
    [self.contentView addSubview:lbMsg2];
    
    //创建“评论内容”
    NSString *content = model.content;
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(55, 65, SCREEN_WIDTH-65, model.textH)];
    [lbMsg3 setText:content];
    [lbMsg3 setTextColor:[UIColor blackColor]];
    [lbMsg3 setTextAlignment:NSTextAlignmentCenter];
    [lbMsg3 setNumberOfLines:0];
    [lbMsg3 setFont:FONT16];
    if(!IsStringEmpty(content)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:8.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
        [lbMsg3 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg3];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, model.cellH-0.5, SCREEN_WIDTH-10, 0.5)];
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
