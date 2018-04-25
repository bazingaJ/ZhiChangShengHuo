//
//  HCMineBankCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineBankCell.h"

@implementation HCMineBankCell

- (void)setMineBankModel:(HCBankModel *)model {
    if(!model) return;
    
    self.backgroundColor = MAIN_COLOR;
    
    //创建“LOGO”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView.layer setCornerRadius:15.0];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    [self.contentView addSubview:imgView];
    
    //创建“银行名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, SCREEN_WIDTH-60, 20)];
    [lbMsg setText:model.bank_name];
    [lbMsg setTextColor:[UIColor whiteColor]];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT18];
    [self.contentView addSubview:lbMsg];
    
    //创建“银行卡类型”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 35, SCREEN_WIDTH-60, 20)];
    [lbMsg2 setText:model.bank_type];
    [lbMsg2 setTextColor:[UIColor whiteColor]];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT13];
    [self.contentView addSubview:lbMsg2];
    
    //创建“银行卡号”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 25)];
    [lbMsg3 setText:model.card_no];
    [lbMsg3 setTextColor:[UIColor whiteColor]];
    [lbMsg3 setTextAlignment:NSTextAlignmentRight];
    [lbMsg3 setFont:FONT16];
    [self.contentView addSubview:lbMsg3];
    
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
