//
//  KSearchView.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "KSearchView.h"

#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]

@interface KSearchView ()

@property (nonatomic, strong) NSMutableArray *hotArr;
@property (nonatomic, strong) NSMutableArray *historyArr;
@property (nonatomic, strong) UIView *historySearchView;
@property (nonatomic, strong) UIView *hotSearchView;

@end

@implementation KSearchView

- (UIView *)hotSearchView {
    if (!_hotSearchView) {
        _hotSearchView = [[UIView alloc] init];//[self setViewWithOriginY:CGRectGetHeight(_historySearchView.frame) title:@"热门搜索" textArr:self.hotArr];
    }
    return _hotSearchView;
}


- (UIView *)historySearchView {
    if (!_historySearchView) {
        if (_historyArr.count > 0) {
            _historySearchView = [self setViewWithOriginY:0 title:@"历史记录" textArr:self.historyArr];
        } else {
            _historySearchView = [self setNoHistoryView];
        }
    }
    return _historySearchView;
}

- (id)initWithFrame:(CGRect)frame hotArr:(NSMutableArray *)hotArr historyArr:(NSMutableArray *)historyArr {
    
    self = [super initWithFrame:frame];
    if(self) {
        self.historyArr = historyArr;
        self.hotArr = hotArr;
        [self addSubview:self.historySearchView];
        [self addSubview:self.hotSearchView];
    }
    return self;
}

- (UIView *)setViewWithOriginY:(CGFloat)riginY title:(NSString *)title textArr:(NSMutableArray *)textArr {
    UIView *backView = [[UIView alloc] init];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30 - 45, 30)];
    [lbMsg setText:title];
    [lbMsg setTextColor:[UIColor blackColor]];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    if ([title isEqualToString:@"历史记录"]) {
        UIButton *btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
        btnClear.frame = CGRectMake(SCREEN_WIDTH - 45, 10, 28, 30);
        [btnClear setImage:[UIImage imageNamed:@"sort_recycle"] forState:UIControlStateNormal];
        [btnClear addTarget:self action:@selector(btnClearSearchHistory:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btnClear];
    }
    
    //创建“循环标签”
    CGFloat y = 10 + 40;
    CGFloat letfWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *tagStr = textArr[i];
        CGFloat width = [self getWidthWithStr:tagStr] + 30;
        if (letfWidth + width + 15 > SCREEN_WIDTH) {
            if (y >= 130 && [title isEqualToString:@"历史记录"]) {
                [self removeTestDataWithTextArr:textArr index:i];
                break;
            }
            y += 40;
            letfWidth = 15;
        }
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(letfWidth, y, width, 30)];
        [lbMsg setText:tagStr];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT12];
        [lbMsg.layer setCornerRadius:5.0];
        [lbMsg.layer setBorderWidth:0.5];
        [lbMsg setUserInteractionEnabled:YES];
        lbMsg.textColor = kRGB(111, 111, 111);
        lbMsg.layer.borderColor = kRGB(227, 227, 227).CGColor;
        [lbMsg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [backView addSubview:lbMsg];
        
        
        letfWidth += width + 10;
    }
    backView.frame = CGRectMake(0, riginY, SCREEN_WIDTH, y + 40);
    return backView;
}

//创建“空数据”
- (UIView *)setNoHistoryView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    //创建“最新搜索”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30)];
    [lbMsg setText:@"历史记录"];
    [lbMsg setTextColor:[UIColor blackColor]];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    //创建“无搜索历史”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lbMsg.frame) + 10, 100, 20)];
    [lbMsg2 setText:@"无搜索历史"];
    [lbMsg2 setTextColor:[UIColor blackColor]];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT12];
    [backView addSubview:lbMsg2];
    
    return backView;
}

- (void)tagDidCLick:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    if (self.tapAction) {
        self.tapAction(label.text);
    }
}

- (CGFloat)getWidthWithStr:(NSString *)text
{
    CGFloat width = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.width;
    return width;
}


- (void)btnClearSearchHistory:(UIButton *)sender
{
    [self.historySearchView removeFromSuperview];
    self.historySearchView = [self setNoHistoryView];
    [_historyArr removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_historyArr toFile:KHistorySearchPath];
    [self addSubview:self.historySearchView];
    CGRect frame = _hotSearchView.frame;
    frame.origin.y = CGRectGetHeight(_historySearchView.frame);
    _hotSearchView.frame = frame;
}

- (void)removeTestDataWithTextArr:(NSMutableArray *)testArr index:(int)index
{
    NSRange range = {index, testArr.count - index - 1};
    [testArr removeObjectsInRange:range];
    [NSKeyedArchiver archiveRootObject:testArr toFile:KHistorySearchPath];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
