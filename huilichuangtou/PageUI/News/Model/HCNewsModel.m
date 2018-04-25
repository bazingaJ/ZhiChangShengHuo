//
//  HCNewsModel.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCNewsModel.h"

@implementation HCNewsModel

/**
 *  标题高度
 */
- (CGFloat)textH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.news_title)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT16,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.news_title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 125, MAXFLOAT)
                                                    options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                                 attributes:attribute
                                                    context:nil].size;
        textH = retSize.height;
    }
    return textH < 40 ? textH : 40;
}

@end
