//
//  KSearchSuggestionCell.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "KSearchSuggestionCell.h"

@implementation KSearchSuggestionCell

- (void)setSearchSuggestion:(KSearchSuggestionModel *)model {
    //if(!model) return;
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
    [lbMsg setText:@"美丽中国"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT14];
    [self addSubview:lbMsg];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self addSubview:lineView];
    
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
