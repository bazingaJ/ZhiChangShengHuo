//
//  XPQuanziCommentView.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziCommentView.h"

@implementation XPQuanziCommentView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //创建“顶部”线条
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self addSubview:lineView];
        
        //创建“背景层”
        UIButton *btnComm = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 35)];
        [btnComm.layer setCornerRadius:17.5];
        [btnComm.layer setBorderWidth:0.5];
        [btnComm.layer setBorderColor:LINE_COLOR.CGColor];
        [btnComm setTitle:@"写评论..." forState:UIControlStateNormal];
        [btnComm setTitleColor:COLOR9 forState:UIControlStateNormal];
        [btnComm.titleLabel setFont:FONT15];
        [btnComm setImage:[UIImage imageNamed:@"news_icon_comment"] forState:UIControlStateNormal];
        [btnComm setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 10)];
        [btnComm setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [btnComm setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnComm setTag:0];
        [btnComm addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnComm];
    }
    return self;
}

/**
 *  功能按钮点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    if([self.delegate respondsToSelector:@selector(XPQuanziCommentViewBottomBarClick:)]) {
        [self.delegate XPQuanziCommentViewBottomBarClick:btnSender.tag];
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
