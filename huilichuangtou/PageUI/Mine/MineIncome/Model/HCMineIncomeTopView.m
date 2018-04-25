//
//  HCMineIncomeTopView.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/31.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineIncomeTopView.h"

@implementation HCMineIncomeTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = MAIN_COLOR;
        
        //创建“图标”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-38)/2, 30, 38, 40)];
        [imgView setImage:[UIImage imageNamed:@"mine_icon_shouyi"]];
        [self addSubview:imgView];
        
        //创建“收益总金额”
        self.lbMsgTotal = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, frame.size.width-20, 30)];
        [self.lbMsgTotal setText:@"0"];
        [self.lbMsgTotal setTextColor:[UIColor whiteColor]];
        [self.lbMsgTotal setTextAlignment:NSTextAlignmentCenter];
        [self.lbMsgTotal setFont:FONT24];
        [self addSubview:self.lbMsgTotal];
        
        //创建“总收益(元)”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, frame.size.width-20, 15)];
        [lbMsg2 setText:@"总收益(元)"];
        [lbMsg2 setTextColor:[UIColor whiteColor]];
        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg2 setFont:FONT13];
        [self addSubview:lbMsg2];

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
