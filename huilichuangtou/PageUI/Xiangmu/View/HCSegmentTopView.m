//
//  HCSegmentTopView.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCSegmentTopView.h"

@implementation HCSegmentTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        WS(weakSelf);
        self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height)];
        [self.segmentedControl setSectionTitles:@[@"进行中", @"预热中", @"已完成"]];
        [self.segmentedControl setSelectedSegmentIndex:0];
        [self.segmentedControl setTextColor:[UIColor blackColor]];
        [self.segmentedControl setFont:FONT16];
        [self.segmentedControl setSelectedTextColor:ORANGE_COLOR];
        [self.segmentedControl setSelectionIndicatorColor:MAIN_COLOR];
        //[self.segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleBox];
        //[self.segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationUp];
        [self.segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
        [self.segmentedControl setSelectionIndicatorHeight:2.0];
        [self.segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
        [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
            if([weakSelf.delegate respondsToSelector:@selector(HCSegmentTopViewSegmentClick:)]) {
                [weakSelf.delegate HCSegmentTopViewSegmentClick:index];
            }
        }];
        [self addSubview:self.segmentedControl];
        
        //创建“下划线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self.segmentedControl addSubview:lineView];
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
