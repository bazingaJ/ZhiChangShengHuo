//
//  HCEquityModel.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCEquityModel.h"

@implementation HCEquityModel

/**
 *  标题高度
 */
- (CGFloat)textH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.short_content)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT13,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.short_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 215, MAXFLOAT)
                                                  options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                               attributes:attribute
                                                  context:nil].size;
        textH = retSize.height;
    }
    return textH < 35 ? textH : 35;
}


@end
