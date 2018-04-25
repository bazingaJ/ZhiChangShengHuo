//
//  HCVersionPopupView.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/26.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCVersionPopupView.h"

@implementation HCVersionPopupView

//初始化
- (id)initWithFrame:(CGRect)frame param:(NSMutableDictionary *)param {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.layer setCornerRadius:4.0];
        
        //参数
        NSString *content = @"";
        NSArray *itemArr = [param objectForKey:@"content"];
        if(itemArr && [itemArr count]>0) {
            content = [itemArr componentsJoinedByString:@"\r\n"];
        }
        
        NSString *version = [param objectForKey:@"version"];
        NSString *is_force = [param objectForKey:@"is_force"];
        
        //创建“头部背景色”
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backView setImage:[UIImage imageNamed:@"version_update"]];
        [self addSubview:backView];
        
        //创建“关闭按钮”
        if(![is_force isEqualToString:@"1"]) {
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-34, 65, 24, 24)];
            [btnFunc setImage:[UIImage imageNamed:@"version_close"] forState:UIControlStateNormal];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnFunc setTag:2];
            [self addSubview:btnFunc];
        }
        
        //创建“版本号”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-90)/2, 155, 90, 26)];
        [lbMsg.layer setCornerRadius:13];
        [lbMsg.layer setBorderWidth:1.5];
        [lbMsg.layer setBorderColor:[UIColor colorWithWhite:1 alpha:0.7].CGColor];
        [lbMsg.layer setMasksToBounds:YES];
        [lbMsg setText:[NSString stringWithFormat:@"V%@",version]];
        [lbMsg setTextColor:[UIColor whiteColor]];
        [lbMsg setFont:SYSTEM_FONT_SIZE(14.0)];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
        [backView addSubview:lbMsg];
        
        //创建“描述”
        UILabel *lblDesc = [[UILabel alloc] initWithFrame:CGRectMake(35, 220, frame.size.width-70, 100)];
        [lblDesc setTextAlignment:NSTextAlignmentLeft];
        [lblDesc setTextColor:[UIColor blackColor]];
        [lblDesc setFont:SYSTEM_FONT_SIZE(15.0)];
        [lblDesc setNumberOfLines:0];
        if(!IsStringEmpty(content)) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:8.0f];
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
            [lblDesc setAttributedText:attStr];
        }
        [backView addSubview:lblDesc];
        
        CGFloat itemH = 340;
        //创建“更新按钮”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@"立即升级"];
        if(![is_force isEqualToString:@"1"]) {
            [titleArr addObject:@"暂不升级"];
        }
        itemH = [titleArr count]==1 ? 380 : itemH;
        for(int i=0;i<[titleArr count];i++) {
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(35, itemH+40*i, frame.size.width-70, 30)];
            [btnFunc.layer setCornerRadius:3.0];
            [btnFunc setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:SYSTEM_FONT_SIZE(15.0)];
            [btnFunc setTag:i];
            if(i==0) {
                //立即升级
                [btnFunc setBackgroundColor:MAIN_COLOR];
            }else if(i==1) {
                //暂不升级
                [btnFunc setBackgroundColor:UIColorFromRGBWith16HEX(0xCDCDCD)];
            }
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnFunc];
        }
        
    }
    return self;
}

//关闭窗体
- (void)btnCloseClick:(UIButton *)btnSender {
    if([self.delegate respondsToSelector:@selector(popupView:dismissWithSender:)]) {
        [self.delegate popupView:self dismissWithSender:btnSender];
    }
}

//按钮点击事件
- (void)btnFuncClick:(UIButton *)btnSender {
    if([self.delegate respondsToSelector:@selector(popupView:withSender:)]) {
        [self.delegate popupView:self withSender:btnSender];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
