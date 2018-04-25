//
//  HCVerticalScrollView.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCVerticalScrollView.h"

@implementation ItemAdModel

@end

@implementation HintView

- (void)setItem:(ItemAdModel *)item {
    _item = item;
    
    for (int i=0; i<2; i++) {
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 5+20*i, self.frame.size.width-10, 20)];
        [lbMsg setUserInteractionEnabled:YES];
        if(i==0) {
            [lbMsg setText:self.item.title1];
            [lbMsg addTouch:^{
                if(self.callBack) {
                    self.callBack(self.item.tag1);
                }
            }];
        }else if(i==1){
            [lbMsg setText:self.item.title2];
            [lbMsg addTouch:^{
                if(self.callBack) {
                    self.callBack(self.item.tag2);
                }
            }];
        }
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT13];
        
        [self addSubview:lbMsg];
        
    }
    
}

@end

static int hintViewHeight = 50;

@interface HCVerticalScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HCVerticalScrollView

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(60, 0, self.frame.size.width-60, self.frame.size.height)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollEnabled = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //创建“图片”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 37.5, 36)];
        [imgView setImage:[UIImage imageNamed:@"topic_icon_news"]];
        [self addSubview:imgView];
        
        //创建“滚动视图”
        [self scrollView];
        
        _autoscroll = YES;
        _timeInterval = 2;
        
    }
    return self;
}

- (void)setItems:(NSArray *)items {
    if (items.count == 0) return;
    
    NSMutableArray *mutableItems = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 3; i++) {
        [mutableItems addObjectsFromArray:items];
    }
    
    _items = mutableItems.copy;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initSelf];
    });
}

- (void)initSelf
{
    //预先清除之前的页面
    for (UIView *view in self.scrollView.subviews) {
        if([view isKindOfClass:[HintView class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSInteger itemNum = [self.items count];
    
    self.scrollView.contentSize = CGSizeMake(0, hintViewHeight * itemNum);
    
    for (int i = 0; i < itemNum; i ++) {
        CGRect frame = CGRectMake(0,hintViewHeight * i,self.frame.size.width - 60,hintViewHeight);
        HintView * hintView = [[HintView alloc] initWithFrame:frame];
        hintView.item = [self.items objectAtIndex:i];
        hintView.userInteractionEnabled = YES;
        hintView.callBack = ^(NSInteger tIndex) {
            if(self.didSelectItemAtIndex) {
                self.didSelectItemAtIndex(tIndex);
            }
        };
        [self.scrollView addSubview:hintView];
    }

    [self setUpTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageHeight = hintViewHeight;
    CGFloat periodOffset = pageHeight * (self.items.count / 3);
    CGFloat offsetActivatingMoveToBeginning = pageHeight * ((self.items.count / 3) * 2);
    CGFloat offsetActivatingMoveToEnd = pageHeight * ((self.items.count / 3) * 1);
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > offsetActivatingMoveToBeginning) {
        scrollView.contentOffset = CGPointMake(0, (offsetY - periodOffset));
    } else if (offsetY < offsetActivatingMoveToEnd) {
        scrollView.contentOffset = CGPointMake(0, (offsetY + periodOffset));
    }
}

- (void)setUpTimer {
    [self tearDownTimer];
    
    if (!self.autoscroll) return;
    
    if(APP_DELEGATE.isOK) {
        self.timer = [NSTimer timerWithTimeInterval:self.timeInterval
                                             target:self
                                           selector:@selector(timerFire:)
                                           userInfo:nil
                                            repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)tearDownTimer {
    [self.timer invalidate];
}

- (void)timerFire:(NSTimer *)timer {
    CGFloat currentOffset = self.scrollView.contentOffset.y;
    CGFloat targetOffset  = currentOffset + hintViewHeight;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, targetOffset) animated:YES];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    [self setUpTimer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
