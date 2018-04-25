//
//  HCSearchPopupView.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCSearchPopupView.h"

#define TITLES @[@"股权众筹", @"投资项目"]
#define ICONS  @[@"motify",@"delete",@"saoyisao",@"pay"]

@implementation HCSearchPopupView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.btnSelect setImage:[UIImage imageNamed:@"down_icon-selected"] forState:UIControlStateNormal];
        [self.btnSelect setTitle:@"股权众筹" forState:UIControlStateNormal];
        [self.btnSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnSelect.titleLabel setFont:FONT15];
        self.btnSelect.imageEdgeInsets = UIEdgeInsetsMake(0, self.btnSelect.frame.size.width - self.btnSelect.imageView.frame.origin.x - self.btnSelect.imageView.frame.size.width, 0, 0);
        self.btnSelect.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
        [self.btnSelect setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.btnSelect addTarget:self action:@selector(btnCityClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSelect];
    }
    return self;
}

//城市点击事件
- (void)btnCityClick:(UIButton *)btnSender {
    [YBPopupMenu showRelyOnView:btnSender titles:TITLES icons:nil menuWidth:100 delegate:self];
    
}

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSLog(@"点击了 %@ 选项",TITLES[index]);
    
    NSString *titleStr = TITLES[index];
    [self.btnSelect setTitle:titleStr forState:UIControlStateNormal];
    
    if(self.callBack) {
        self.callBack(index, titleStr);
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
