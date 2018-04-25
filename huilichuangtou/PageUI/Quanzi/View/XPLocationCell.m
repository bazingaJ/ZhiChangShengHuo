//
//  XPLocationCell.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPLocationCell.h"

@implementation XPLocationCell

- (void)setLocationModel:(AMapPOI *)model uid:(NSString *)uid {
    if(!model) return;
    
    //创建“地址名称”
    NSString *city_name = model.name.length > 0 ? model.name : model.city;
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-40, 25)];
    [lbMsg setText:city_name];
    [lbMsg setTextColor:[UIColor blackColor]];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT18];
    [self.contentView addSubview:lbMsg];
    
    //创建“描述”
    NSString *addressStr = model.city;
    if(!IsStringEmpty(model.address)) {
        addressStr = [addressStr stringByAppendingString:[NSString stringWithFormat:@"·%@",model.address]];
    }
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-40, 20)];
    [lbMsg2 setText:addressStr];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT15];
    [self.contentView addSubview:lbMsg2];
    
    if ([uid isEqualToString:model.uid] && !IsStringEmpty(model.uid)) {
        //上次选中的标记
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-28, 31.5, 18, 18)];
        [imgView setImage:[UIImage imageNamed:@"quanzi_location_selected"]];
        [self.contentView addSubview:imgView];
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
