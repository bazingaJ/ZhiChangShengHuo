//
//  HCMineTouziXiangmuCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineTouziXiangmuCell.h"

@implementation HCMineTouziXiangmuCell

- (void)setMineTouziXiangmuModel:(HCMineTouziXiangmuModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    //创建“标题”
    NSString *titleStr = [NSString stringWithFormat:@"%@  %@",model.title,model.cate_name];
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
    [lbMsg setText:titleStr];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    if(!IsStringEmpty(titleStr)) {
        NSArray *titleArr = [titleStr componentsSeparatedByString:@"  "];
        NSString *cateStr = titleArr[1];
        NSInteger len = [cateStr length];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
        //字体颜色
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:COLOR9
                        range:NSMakeRange([titleStr length]-len, len)];
        //字体大小
        [attrStr addAttribute:NSFontAttributeName
                        value:FONT12
                        range:NSMakeRange([titleStr length]-len, len)];
        lbMsg.attributedText = attrStr;
    }
    
    //创建“投资状态”
    if([model.status isEqualToString:@"6"]) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 40, 40)];
        [imgView setImage:[UIImage imageNamed:@"mine_icon_duixian"]];
        [self.contentView addSubview:imgView];
    }
    
    //创建“项目编号”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, SCREEN_WIDTH-60, 20)];
    [lbMsg2 setText:[NSString stringWithFormat:@"项目编号：%@",model.number]];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT13];
    [self.contentView addSubview:lbMsg2];
    
    //创建“投资日期”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-80, 20)];
    [lbMsg3 setText:[NSString stringWithFormat:@"投资日期：%@",model.add_date]];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT13];
    [self.contentView addSubview:lbMsg3];
    
    //创建“预计收益”
    NSString *totalStr = [NSString stringWithFormat:@"预计收益：%@元",model.income_money];
    UILabel *lbMsg7 = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, SCREEN_WIDTH-80, 20)];
    [lbMsg7 setText:totalStr];
    [lbMsg7 setTextColor:COLOR9];
    [lbMsg7 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg7 setFont:FONT13];
    [self.contentView addSubview:lbMsg7];
    if(!IsStringEmpty(totalStr)) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
        //字体颜色
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:ORANGE_COLOR
                        range:NSMakeRange(5, [totalStr length]-5)];
        //字体大小
        [attrStr addAttribute:NSFontAttributeName
                        value:FONT15
                        range:NSMakeRange(5, [totalStr length]-5)];
        lbMsg7.attributedText = attrStr;
    }
    
    //创建“查看合同”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 75, 60, 20)];
    [btnFunc setTitle:@"查看合同" forState:UIControlStateNormal];
    [btnFunc setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT13];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnFunc addTouch:^{
        if([self.delegate respondsToSelector:@selector(HCMineTouziXiangmuCellClick:indexPath:)]) {
            [self.delegate HCMineTouziXiangmuCellClick:model indexPath:indexPath];
        }
    }];
    [self.contentView addSubview:btnFunc];
    
    //创建”分割线“
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
    //创建“信息”
    //拟定年收益
    NSString *incomeStr = @"0%";
    if(!IsStringEmpty(model.income)) {
        incomeStr = [model.income stringByAppendingString:@"%"];
    }
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.invest_total_fee],@"总金额"]];
    [titleArr addObject:@[incomeStr,@"拟定年收益"]];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@天",model.deadline],@"投资期限"]];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.total_fee],@"已投金额"]];
    
    CGFloat tWidth = SCREEN_WIDTH/[titleArr count];
    for (int i=0; i<[titleArr count]; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 100, tWidth-1, 60)];
        [self.contentView addSubview:backView];
        
        //创建“内容值”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tWidth, 20)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:ORANGE_COLOR];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT13];
        [backView addSubview:lbMsg];
        
        //创建“标题”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, tWidth, 20)];
        [lbMsg2 setText:itemArr[1]];
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg2 setFont:FONT12];
        [backView addSubview:lbMsg2];
        
        if(i<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tWidth-0.5, 0, 0.5, 60)];
            [lineView setBackgroundColor:LINE_COLOR];
            [backView addSubview:lineView];
        }
    }
    
    //创建”分割线“
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 159.5, SCREEN_WIDTH, 0.5)];
    [lineView2 setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView2];
    
    //创建“打款银行”
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 165, SCREEN_WIDTH-20, 20)];
    [lbMsg4 setText:[NSString stringWithFormat:@"打款银行：%@",model.bank_name]];
    [lbMsg4 setTextColor:COLOR9];
    [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg4 setFont:FONT13];
    [self.contentView addSubview:lbMsg4];
    
    //创建“账户姓名”
    UILabel *lbMsg5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, SCREEN_WIDTH-20, 25)];
    [lbMsg5 setText:[NSString stringWithFormat:@"账户姓名：%@",model.account_name]];
    [lbMsg5 setTextColor:COLOR9];
    [lbMsg5 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg5 setFont:FONT13];
    [self.contentView addSubview:lbMsg5];
    
    //创建“打款指定账户”
    UILabel *lbMsg6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, 25)];
    [lbMsg6 setText:[NSString stringWithFormat:@"打款指定账户：%@",model.bank_no]];
    [lbMsg6 setTextColor:COLOR9];
    [lbMsg6 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg6 setFont:FONT13];
    [self.contentView addSubview:lbMsg6];
    
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
