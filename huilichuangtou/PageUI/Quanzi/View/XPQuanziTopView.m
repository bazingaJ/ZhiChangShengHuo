//
//  XPQuanziTopView.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziTopView.h"

@implementation XPQuanziTopView

- (SDCycleScrollView *)cycleScrollView {
    if(!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190) delegate:self placeholderImage:[UIImage imageNamed:@"default_img_banner_list"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
        _cycleScrollView.hidesForSinglePage = YES;
        [_cycleScrollView setContentMode:UIViewContentModeScaleAspectFill];
        [_cycleScrollView setClipsToBounds:YES];
        _cycleScrollView.autoScrollTimeInterval = 3.0;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [_cycleScrollView setClipsToBounds:YES];
        [self addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

-(void)setImageArr:(NSMutableArray *)imageArr
{
    _cycleScrollView.imageURLStringsGroup = imageArr;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //创建“轮播广告”
        [self cycleScrollView];
        
    }
    return self;
}

- (void)setCateArr:(NSArray *)cateArr {
    
    NSInteger cateNum = [cateArr count];
    if(cateNum>4) {
        cateNum = 4;
    }
    CGFloat tWidth = self.frame.size.width/cateNum;
    for (int i=0; i<cateNum; i++) {
        XPCateModel *model = [cateArr objectAtIndex:i];
        
        //创建“背景层”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*i, 200, tWidth, 90)];
        [btnFunc setBackgroundColor:[UIColor whiteColor]];
        [btnFunc addTouch:^{
            if([self.delegate respondsToSelector:@selector(XPQuanziTagViewDidSelectItemAtIndex:)]) {
                [self.delegate XPQuanziTagViewDidSelectItemAtIndex:model];
            }
        }];
        [self addSubview:btnFunc];
        
        //创建“图片”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
        [imgView.layer setCornerRadius:25];
        [imgView.layer setMasksToBounds:YES];
        [imgView setContentMode:UIViewContentModeScaleAspectFill];
        [imgView setClipsToBounds:YES];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.logo_url] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        [btnFunc addSubview:imgView];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, tWidth, 20)];
        [lbMsg setText:model.cate_name];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setFont:FONT14];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [btnFunc addSubview:lbMsg];
        
    }
    
    //创建“最新热贴”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:backView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
    [lbMsg setText:@"最新热贴"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [backView addSubview:lbMsg];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [backView addSubview:lineView];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if([self.delegate respondsToSelector:@selector(XPQuanziTopAdViewDidSelectItemAtIndex:)]) {
        [self.delegate XPQuanziTopAdViewDidSelectItemAtIndex:index];
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
