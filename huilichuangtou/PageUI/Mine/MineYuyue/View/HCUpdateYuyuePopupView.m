//
//  HCUpdateYuyuePopupView.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCUpdateYuyuePopupView.h"

@interface HCUpdateYuyuePopupView () {
    UITextField *tbxFee;
}

@end

@implementation HCUpdateYuyuePopupView

- (id)initWithFrame:(CGRect)frame model:(HCTouziOrderModel *)model indexPath:(NSIndexPath *)indexPath {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setCornerRadius:5.0];
        [self.layer setMasksToBounds:YES];
        
        //创建“您当前的创业豆不足”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
        [lbMsg setText:@"修改预约金额"];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT16];
        [lbMsg setBackgroundColor:UIColorFromRGBWith16HEX(0xE5E5E5)];
        [self addSubview:lbMsg];
        
        //创建“最低投资金额5万元”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 90, 40)];
        [lbMsg2 setText:@"原预约金额"];
        [lbMsg2 setTextColor:MAIN_COLOR];
        [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
        [lbMsg2 setFont:FONT15];
        [self addSubview:lbMsg2];
        
        //创建“原预约金额”
        UILabel *lbMsg5 = [[UILabel alloc] initWithFrame:CGRectMake(100, 45, frame.size.width-110, 40)];
        [lbMsg5 setText:[NSString stringWithFormat:@"%@ 万元",model.total_fee]];
        [lbMsg5 setTextColor:COLOR3];
        [lbMsg5 setTextAlignment:NSTextAlignmentRight];
        [lbMsg5 setFont:FONT15];
        [self addSubview:lbMsg5];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 85, frame.size.width-20, 40)];
        [backView.layer setCornerRadius:3.0];
        [backView.layer setBorderWidth:1];
        [backView.layer setBorderColor:LINE_COLOR.CGColor];
        [self addSubview:backView];
        
        //创建“金额输入框”
        tbxFee = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-55, 30)];
        [tbxFee setPlaceholder:@"请输入现预约金额"];
        [tbxFee setTextColor:COLOR3];
        [tbxFee setTextAlignment:NSTextAlignmentLeft];
        [tbxFee setFont:FONT14];
        [tbxFee setKeyboardType:UIKeyboardTypeDecimalPad];
        [backView addSubview:tbxFee];
        
        //创建“万元”
        UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width-45, 10, 35, 20)];
        [lbMsg3 setText:@"万元"];
        [lbMsg3 setTextColor:COLOR3];
        [lbMsg3 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg3 setFont:FONT16];
        [backView addSubview:lbMsg3];
        
        //创建“描述”
        NSString *titleStr = @"修改预约金额将影响您在平台的个人信用点数，请您谨慎操作！";
        UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, frame.size.width-20, 45)];
        [lbMsg4 setText:titleStr];
        [lbMsg4 setTextColor:COLOR9];
        [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
        [lbMsg4 setNumberOfLines:2];
        [lbMsg4 setFont:FONT13];
        if(!IsStringEmpty(titleStr)) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:5.0f];
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, titleStr.length)];
            [lbMsg4 setAttributedText:attStr];
        }
        [self addSubview:lbMsg4];
        
        //创建“按钮”
        CGFloat tWidth = frame.size.width/2;
        for (int i=0; i<2; i++) {
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth *i, 180, tWidth, 45)];
            if(i==0) {
                [btnFunc setTitle:@"取消" forState:UIControlStateNormal];
                [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                [btnFunc setBackgroundColor:LINE_COLOR];
            }else if(i==1) {
                [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc setBackgroundColor:MAIN_COLOR];
            }
            [btnFunc.titleLabel setFont:FONT16];
            [btnFunc setTag:i];
            [btnFunc addTouch:^{
                NSLog(@"点击按钮");
                if(i==1 && IsStringEmpty(tbxFee.text)) {
                    [MBProgressHUD showError:@"请输入投资金额" toView:nil];
                    return ;
                }
                
                [self endEditing:YES];
                
                if([self.delegate respondsToSelector:@selector(HCUpdateYuyuePopupViewClick:indexPath:tIndex:totalFee:)]) {
                    [self.delegate HCUpdateYuyuePopupViewClick:model indexPath:indexPath tIndex:i totalFee:tbxFee.text];
                }
            }];
            [self addSubview:btnFunc];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
