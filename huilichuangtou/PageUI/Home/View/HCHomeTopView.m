//
//  HCHomeTopView.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCHomeTopView.h"
#import "HCNewsModel.h"

@implementation HCHomeTopView

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

- (HCVerticalScrollView *)advertScrollView {
    if(!_advertScrollView) {
        WS(weakSelf);
        _advertScrollView = [[HCVerticalScrollView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, 50)];
        _advertScrollView.didSelectItemAtIndex = ^(NSUInteger index) {
            NSLog(@"tap index: %ld", index);
            if([weakSelf.delegate respondsToSelector:@selector(HCHomeTopViewNewsDidSelectItemAtIndex:)]) {
                [weakSelf.delegate HCHomeTopViewNewsDidSelectItemAtIndex:index];
            }
        };
        [self addSubview:_advertScrollView];
    }
    return _advertScrollView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //创建“轮播广告”
        [self cycleScrollView];
        
        //创建“资讯区”
        [self advertScrollView];
        
    }
    return self;
}

- (void)setNewsArr:(NSMutableArray *)newsArr {
    NSArray *newsList = [self splitArr:newsArr withSubSize:2];
    
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i=0; i<newsList.count; i++) {
        ItemAdModel *item = [ItemAdModel new];
        
        //设置第一行数据
        HCNewsModel *newsModel1 = newsList[i][0];
        if(newsModel1) {
            item.tag1 = i*2;
            item.title1 = newsModel1.news_title;
        }
        
        if([newsList[i] count]==2) {
            //设置第二行数据
            HCNewsModel *newsModel2 = newsList[i][1];
            if(newsModel2) {
                item.tag2 = i*2+1;
                item.title2 = newsModel2.news_title;
            }
        }
        
        [itemArr addObject:item];
    }
    _advertScrollView.items = [itemArr copy];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if([self.delegate respondsToSelector:@selector(HCHomeTopViewAdDidSelectItemAtIndex:)]) {
        [self.delegate HCHomeTopViewAdDidSelectItemAtIndex:index];
    }
}

- (NSArray *)splitArr:(NSArray *)dataArr withSubSize:(NSInteger)size {
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = dataArr.count % size == 0 ? (dataArr.count / size) : (dataArr.count / size + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        NSInteger index = i * size;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        NSInteger j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < size*(i + 1) && j < dataArr.count) {
            [arr1 addObject:[dataArr objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    
    return [arr copy];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
