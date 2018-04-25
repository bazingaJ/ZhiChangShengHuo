//
//  XPQuanziCommentModel.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziCommentModel.h"

static CGFloat const cellMargin = 15;
static CGFloat const cellTextY = 45;

@implementation XPQuanziCommentModel

- (CGFloat)textH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.content)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:8.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT16,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2*cellMargin-45, MAXFLOAT)
                                                    options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                                 attributes:attribute
                                                    context:nil].size;
        textH = retSize.height;
    }
    return textH;
}


-(CGFloat)cellH {
    
    CGFloat textH = [self textH];
    return cellTextY + textH + cellMargin*2;;
}

@end
