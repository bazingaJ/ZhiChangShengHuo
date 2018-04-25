//
//  UIView+Empty.m
//  wulian_user
//
//  Created by 相约在冬季 on 2017/6/1.
//  Copyright © 2017年 wlqq. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>

static char WarningViewKey;

@implementation UIView (Empty)

//利用runtime给类别添加属性
- (void)setWarningView:(CustomerWarnView *)warningView{
    [self willChangeValueForKey:@"WarningViewKey"];
    objc_setAssociatedObject(self, &WarningViewKey, warningView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"WarningViewKey"];
}

- (CustomerWarnView *)warningView{
    return objc_getAssociatedObject(self, &WarningViewKey);
}

/**
 *  显示页面
 */
- (void)emptyViewShowWithDataType:(ViewDataType)emptyType
                          hasData:(BOOL)hasData
                      reloadBlock:(ReloadDataBlock)reloadBlock {
    
    if (self.warningView) {
        [self.warningView removeFromSuperview];
    }
    if (!hasData) {
        self.warningView = [CustomerWarnView initWithFrame:self.bounds andType:emptyType];
        if (!reloadBlock) {
            self.warningView.btnFunc.hidden = YES;
        }
        self.warningView.reloadBlock = reloadBlock;
        [self addSubview:self.warningView];
    }
}

@end

@implementation CustomerWarnView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        CGFloat topH = (frame.size.height-140-140)/2;
        
        //创建“提示图”
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-140)/2, topH, 140, 120)];
        [self addSubview:self.imgView];
        
        //创建“提示语”
        self.lblTip = [[UILabel alloc] initWithFrame:CGRectMake(10, topH+120+30, frame.size.width-20, 20)];
        [self.lblTip setText:@"暂无数据～"];
        [self.lblTip setTextColor:COLOR9];
        [self.lblTip setTextAlignment:NSTextAlignmentCenter];
        [self.lblTip setFont:FONT16];
        [self addSubview:self.lblTip];
        
        //创建“刷新按钮”
        self.btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width-120)/2, topH+120+50+30, 120, 40)];
        [self.btnFunc setTitle:@"重新加载" forState:UIControlStateNormal];
        [self.btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnFunc.titleLabel setFont:FONT17];
        [self.btnFunc.layer setCornerRadius:3.0];
        [self.btnFunc setBackgroundColor:MAIN_COLOR];
        [self.btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnFunc];
        
    }
    return self;
}

//功能按钮点击事件
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"功能按钮");
    
    if (_reloadBlock) {
        _reloadBlock();
    }
    
    //移除提示
    //设置动画让空白页面消失
    [UIView animateWithDuration:0.5 animations:^{
        //self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

+ (CustomerWarnView *)initWithFrame:(CGRect)frame andType:(ViewDataType)type{
    CustomerWarnView *warningView = [[CustomerWarnView alloc]initWithFrame:frame];
    NSString *imageName,*tip;
    switch (type) {
        case ViewDataTypeMyMessage:
            imageName = @"empty-icon-show";
            tip = @"您还没有消息哦~";
            break;
        case ViewDataTypeLoadFail:
            imageName = @"empty-icon-show";
            tip = @"暂无数据～";
            break;
            
        default:
            break;
    }
    [warningView.imgView setImage:[UIImage imageNamed:imageName]];
    warningView.lblTip.text = tip;
    return warningView;
}

@end

