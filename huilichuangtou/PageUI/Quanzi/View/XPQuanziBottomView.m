//
//  XPQuanziBottomView.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/30.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziBottomView.h"

@implementation XPQuanziBottomView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 55)];
        [backView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:backView];
        
        //创建“更多热贴”
        UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
        [backView2 setBackgroundColor:[UIColor whiteColor]];
        [backView addSubview:backView2];
        
        //创建“按钮”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
        [btnFunc setTitle:@"更多热帖>>" forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT16];
        [btnFunc addTouch:^{
            if([self.delegate respondsToSelector:@selector(XPQuanziBottomViewMoreDidSelectItemAtIndex)]) {
                [self.delegate XPQuanziBottomViewMoreDidSelectItemAtIndex];
            }
        }];
        [backView2 addSubview:btnFunc];

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
