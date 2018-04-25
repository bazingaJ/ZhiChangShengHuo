//
//  HCMineYuyueTouziCell.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/10.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineYuyueTouziCell.h"

@implementation HCMineYuyueTouziCell

- (void)setTouziOrderModel:(HCTouziOrderModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
    [lbMsg setText:model.title];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //预约金额
    NSString *priceStr = [NSString stringWithFormat:@"预约金额：%@万元",model.total_fee];
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-160, 10, 150, 20)];
    [lbMsg3 setText:priceStr];
    [lbMsg3 setTextColor:ORANGE_COLOR];
    [lbMsg3 setTextAlignment:NSTextAlignmentRight];
    [lbMsg3 setFont:FONT16];
    [self.contentView addSubview:lbMsg3];
    if(!IsStringEmpty(priceStr)) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
        //字体颜色
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:COLOR3
                        range:NSMakeRange(0, 5)];
        //字体大小
        [attrStr addAttribute:NSFontAttributeName
                        value:FONT13
                        range:NSMakeRange(0, 5)];
        lbMsg3.attributedText = attrStr;
    }
    
    //创建“截止日期”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, SCREEN_WIDTH-60, 15)];
    [lbMsg2 setText:[NSString stringWithFormat:@"项目编号：%@  类别：%@",model.number,model.cate_name]];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT12];
    [self.contentView addSubview:lbMsg2];
    
    //创建”分割线“
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
    //创建“打款银行”
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, SCREEN_WIDTH-20, 25)];
    [lbMsg4 setText:[NSString stringWithFormat:@"打款银行：%@",model.bank_name]];
    [lbMsg4 setTextColor:COLOR9];
    [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg4 setFont:FONT13];
    [self.contentView addSubview:lbMsg4];
    
    //创建“账户姓名”
    UILabel *lbMsg5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH-20, 25)];
    [lbMsg5 setText:[NSString stringWithFormat:@"账户姓名：%@",model.account_name]];
    [lbMsg5 setTextColor:COLOR9];
    [lbMsg5 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg5 setFont:FONT13];
    [self.contentView addSubview:lbMsg5];
    
    //创建“打款指定账户”
    UILabel *lbMsg6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, SCREEN_WIDTH-20, 25)];
    [lbMsg6 setText:[NSString stringWithFormat:@"打款指定账户：%@",model.bank_no]];
    [lbMsg6 setTextColor:COLOR9];
    [lbMsg6 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg6 setFont:FONT13];
    [self.contentView addSubview:lbMsg6];
    
    //创建“分割线”
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 144.5, SCREEN_WIDTH, 0.5)];
    [lineView2 setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView2];
    
    //创建“信息”
    //拟定年收益
    NSString *incomeStr = @"0%";
    if(!IsStringEmpty(model.income)) {
        incomeStr = [model.income stringByAppendingString:@"%"];
    }
    //预约状态
    NSString *statusStr = @"";
    if(!IsStringEmpty(model.status_name)) {
        statusStr = model.status_name;
    }
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@万元",model.invest_total_fee],@"投资金额"]];
    [titleArr addObject:@[[NSString stringWithFormat:@"%@天",model.deadline],@"投资期限"]];
    [titleArr addObject:@[incomeStr,@"拟定年收益"]];
    [titleArr addObject:@[statusStr,@"预约状态"]];
    
    CGFloat tWidth = SCREEN_WIDTH/[titleArr count];
    for (int i=0; i<[titleArr count]; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 140, tWidth-1, 60)];
        [self.contentView addSubview:backView];
        
        //创建“内容值”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, tWidth, 20)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:ORANGE_COLOR];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT13];
        [backView addSubview:lbMsg];
        
        //创建“标题”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, tWidth, 20)];
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
    
    //创建“分割线”
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 204.5, SCREEN_WIDTH, 0.5)];
    [lineView3 setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView3];
    
    //创建“功能”按钮
    if([model.status isEqualToString:@"1"] ||
       [model.status isEqualToString:@"2"] ||
       [model.status isEqualToString:@"3"])
    for (int i=0; i<2; i++) {
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180+90*i, 215, 80, 25)];
        if(i==0) {
            [btnFunc setTitle:@"取消预约" forState:UIControlStateNormal];
        }else if(i==1) {
            [btnFunc setTitle:@"修改预约金额" forState:UIControlStateNormal];
        }
        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT12];
        [btnFunc setBackgroundColor:ORANGE_COLOR];
        [btnFunc.layer setCornerRadius:3.0];
        [btnFunc setTag:i];
        [btnFunc addTouch:^{
            
            if([self.delegate respondsToSelector:@selector(HCMineYuyueTouziCellClick:tIndex:indexPath:)]) {
                [self.delegate HCMineYuyueTouziCellClick:model tIndex:i indexPath:indexPath];
            }
            
        }];
        [self.contentView addSubview:btnFunc];
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
