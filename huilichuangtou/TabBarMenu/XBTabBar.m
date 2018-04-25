//
//  XBTabBarEx.m
//  XianBai
//
//  Created by 相约在冬季 on 16/10/15.
//  Copyright © 2016年 aiyishu. All rights reserved.
//

#import "XBTabBar.h"

@implementation XBTabBar

- (instancetype)init {
    self = [super init];
    if(self) {
        UIButton *btnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCenter setImage:[UIImage imageNamed:@"tabbar-icon-more"] forState:UIControlStateNormal];
        btnCenter.bounds = CGRectMake(0, 0, 64, 64);
        self.btnCenter = btnCenter;
        [self addSubview:btnCenter];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.btnCenter.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.3+4);
    
    int index = 0;
    CGFloat wigth = self.bounds.size.width / 5;
    for (UIView* sub in self.subviews) {
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height - 2);
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.btnCenter];
        
        if ( [self.btnCenter pointInside:newPoint withEvent:event]) {
            return self.btnCenter;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
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
