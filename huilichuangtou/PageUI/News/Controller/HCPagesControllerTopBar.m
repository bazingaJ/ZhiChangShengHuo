//
//  HCPagesControllerTopBar.m
//  XMPPV2.0
//
//  Created by 相约在冬季 on 2017/2/10.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "HCPagesControllerTopBar.h"

@implementation HCPagesControllerTopBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsVerticalScrollIndicator  =NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        [self addSubview:self.scrollView];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:self.lineView];
    }
    return self;
}

- (void)setItemTitles:(NSArray *)itemTitles {
    if (_itemTitles != itemTitles) {
        _itemTitles = itemTitles;
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:itemTitles.count];
        for (NSInteger i = 0; i < itemTitles.count; i++) {
            UILabel *itemLabel = [[UILabel alloc] init];
            itemLabel.tag = i;
            itemLabel.text = itemTitles[i];
            itemLabel.textColor = [UIColor whiteColor];
            itemLabel.font = SYSTEM_FONT_SIZE(17.0);
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.userInteractionEnabled = YES;
            [self.scrollView addSubview:itemLabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
            [itemLabel addGestureRecognizer:tap];
            
            [temp addObject:itemLabel];
        }
        self.itemLabels = [temp copy];
        [self updateItemLabelTextColor];
        [self updateLineViewPosition];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [self updateItemLabelTextColor];
        [self updateLineViewPosition];
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    _itemTitleColor = itemTitleColor;
    [self updateItemLabelTextColor];
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor {
    _selectedItemTitleColor = selectedItemTitleColor;
    [self updateItemLabelTextColor];
}

// 设置字体颜色
- (void)updateItemLabelTextColor {
    UILabel *selectedItemLabel = self.itemLabels[self.selectedIndex];
    
    for (UILabel *itemLabel in self.itemLabels) {
        if (itemLabel != selectedItemLabel) {
            itemLabel.textColor = self.itemTitleColor ? self.itemTitleColor : [UIColor whiteColor];
            itemLabel.font = self.itemTileFont ? self.itemTileFont : [UIFont systemFontOfSize:17.0];
        }else {
            selectedItemLabel.textColor = self.selectedItemTitleColor ? self.selectedItemTitleColor : [UIColor whiteColor];
            itemLabel.font = self.selectedItemTileFont ? self.selectedItemTileFont : [UIFont systemFontOfSize:18.0];
            _previosItemLabel = selectedItemLabel;
        }
        
    }
}

// 改变下划线的位置
- (void)updateLineViewPosition {
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    UILabel *selectedItemLabel = self.itemLabels[self.selectedIndex];
    CGFloat selectedItemLabelX = selectedItemLabel.frame.origin.x;
    if (selectedItemLabelX > scrollViewWidth * 0.5 && self.scrollView.contentSize.width - selectedItemLabelX > scrollViewWidth * 0.5) {
        CGFloat offsetX = selectedItemLabelX - scrollViewWidth * 0.5;
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    if (selectedItemLabelX <= scrollViewWidth * 0.5) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (self.scrollView.contentSize.width - selectedItemLabelX <= scrollViewWidth * 0.5) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - scrollViewWidth, 0) animated:YES];
    }
    
    
    CGFloat x = selectedItemLabel.frame.origin.x;
    CGFloat y = self.scrollView.frame.size.height - 2;
    CGFloat w = selectedItemLabel.frame.size.width;
    CGFloat h = 2;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.frame = CGRectMake(x, y, w, h);
    }];
}

- (void)itemTapped:(UITapGestureRecognizer *)tap {
    _previosItemLabel.textColor = self.itemTitleColor ? self.itemTitleColor : [UIColor whiteColor];
    UILabel *selectedItemLabel = (UILabel *)tap.view;
    _previosItemLabel = selectedItemLabel;
    selectedItemLabel.textColor = self.selectedItemTitleColor ? self.selectedItemTitleColor : [UIColor whiteColor];
    if ([self.delegate respondsToSelector:@selector(itemAtIndex:didSelectInPagesContainerTopBar:)]) {
        [self.delegate itemAtIndex:selectedItemLabel.tag didSelectInPagesContainerTopBar:self];
    }
    self.selectedIndex = selectedItemLabel.tag;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    CGFloat margin = 10;
    CGFloat totalWidth = 0;
    for (NSInteger i = 0; i < self.itemLabels.count; i++) {
        
        UILabel *itemLabel = self.itemLabels[i];
        CGSize textSize = [itemLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:itemLabel.font} context:nil].size;
        CGFloat itemLabelWidth = textSize.width + 2 * margin;
        CGFloat itemLabelHeight = self.scrollView.frame.size.height;
        itemLabel.frame = CGRectMake(totalWidth, 0, itemLabelWidth, itemLabelHeight);
        totalWidth += itemLabelWidth;
    }
    UILabel *selectedItemLabel = self.itemLabels[self.selectedIndex];
    self.lineView.frame = CGRectMake(selectedItemLabel.frame.origin.x, CGRectGetHeight(self.scrollView.frame) - 2, selectedItemLabel.frame.size.width, 2);
    if(totalWidth<=SCREEN_WIDTH) {
        totalWidth = SCREEN_WIDTH;
    }
    self.scrollView.contentSize = CGSizeMake(totalWidth, self.scrollView.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
