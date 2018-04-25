//
//  XPQuanziModel.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziModel.h"

static CGFloat const cellMargin = 10;
static CGFloat const cellTextY = 60;

@implementation XPQuanziModel

//图片数组
- (NSMutableArray *)imgs {
    if(_imgs == nil) {
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}

- (CGFloat)textH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.content)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:8.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT17,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2*cellMargin, MAXFLOAT)
                                                    options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                                 attributes:attribute
                                                    context:nil].size;
        textH = retSize.height+20;
    }
    return textH;
}

-(CGFloat)cellH {
    
    CGFloat textH = [self textH];
    
    //设置地址的高度
    CGFloat addressH = 0;
    if(!IsStringEmpty(self.address)) {
        addressH = 20;
    }
    
    //计算图片的高度
    CGFloat imageH = 0;
    if(self.imgs.count>0) {
        CGFloat imgWidth = (SCREEN_WIDTH-20-10)/3;
        NSInteger imgNum = self.imgs.count;
        if(imgNum==1) {
            imageH = 145 + 5;
        }else{
            NSInteger rowNum = imgNum/3;
            NSInteger colNum = imgNum%3;
            if(colNum>0) {
                rowNum += 1;
            }
            imageH = (imgWidth+5) * rowNum;
        }
    }
    
    return cellTextY + textH + imageH + addressH + 30 + 10;
}

@end
