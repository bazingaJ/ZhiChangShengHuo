//
//  HCMineTopView.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCMineTopView.h"

@interface HCMineTopView ()

@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *lblNickName;
@property (nonatomic, strong) UILabel *lblGroupName;
@property (nonatomic, strong) UILabel *lblMobile;

@end

@implementation HCMineTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //创建“背景层”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [imgView setContentMode:UIViewContentModeScaleAspectFill];
        [imgView setClipsToBounds:YES];
        imgView.userInteractionEnabled = YES;
        [imgView setImage:[UIImage imageNamed:@"mine_back"]];
        [self addSubview:imgView];
        
        //创建“头像背景层”
//        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-113)/2, 15, 113, 112)];
//        [imgView2 setImage:[UIImage imageNamed:@"mine-avatar-back"]];
//        [imgView2 setUserInteractionEnabled:YES];
//        [self addSubview:imgView2];
        
        //创建“头像”
        WS(weakSelf);
        NSString *imgURL = @"";
        self.avatarImg = [[UIImageView alloc] init];
        [self.avatarImg setContentMode:UIViewContentModeScaleAspectFill];
        [self.avatarImg setClipsToBounds:YES];
        [self.avatarImg.layer setCornerRadius:32.5];
        self.avatarImg.layer.borderColor = UIColor.whiteColor.CGColor;
        self.avatarImg.layer.borderWidth = 2;
        [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        [self.avatarImg setUserInteractionEnabled:YES];
        [self.avatarImg addTouch:^{
            if([weakSelf.delegate respondsToSelector:@selector(HCMineTopViewEditInfoClick:)]) {
                [weakSelf.delegate HCMineTopViewEditInfoClick:0];
            }
        }];
        [imgView addSubview:self.avatarImg];
        [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imgView.mas_left).mas_offset(20);
            make.centerY.mas_equalTo(imgView);
            make.width.height.mas_equalTo(65);
        }];
        
        //创建“编辑”按钮
        UIButton *btnFunc = [[UIButton alloc] init];
        [btnFunc setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [btnFunc addTouch:^{
            if([self.delegate respondsToSelector:@selector(HCMineTopViewEditInfoClick:)]) {
                [self.delegate HCMineTopViewEditInfoClick:1];
            }
        }];
        [imgView addSubview:btnFunc];
        [btnFunc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imgView.mas_right).mas_offset(-20);
            make.centerY.mas_equalTo(imgView.mas_centerY);
            make.width.height.mas_equalTo(30);
        }];
        
        
        
        //创建“用户名称”
        self.lblNickName = [[UILabel alloc] init];
        [self.lblNickName setText:@"请登录"];
        [self.lblNickName setTextColor:[UIColor whiteColor]];
        [self.lblNickName setTextAlignment:NSTextAlignmentCenter];
        [self.lblNickName setFont:FONT16];
        [self.lblNickName setUserInteractionEnabled:YES];
        [self.lblNickName addTouch:^{
            NSLog(@"请登录");
            if([weakSelf.delegate respondsToSelector:@selector(HCMineTopViewEditInfoClick:)]) {
                [weakSelf.delegate HCMineTopViewEditInfoClick:2];
            }
        }];
        [imgView addSubview:self.lblNickName];
        [self.lblNickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarImg.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(self.avatarImg.centerY).mas_equalTo(-15);
            
        }];
        
//        //创建“群名层”
//        self.lblGroupName = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, frame.size.width-20, 20)];
//        //[lbMsg2 setText:@"财富交流群 群主"];
//        [self.lblGroupName setTextColor:[UIColor whiteColor]];
//        [self.lblGroupName setTextAlignment:NSTextAlignmentCenter];
//        [self.lblGroupName setFont:FONT12];
//        [self addSubview:self.lblGroupName];
        
        //创建“手机号”
        self.lblMobile = [[UILabel alloc] init];
        [self.lblMobile setText:[HelperManager CreateInstance].mobile];
        [self.lblMobile setTextColor:[UIColor whiteColor]];
        [self.lblMobile setTextAlignment:NSTextAlignmentCenter];
        [self.lblMobile setFont:FONT12];
        [imgView addSubview:self.lblMobile];
        [self.lblMobile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarImg.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(self.avatarImg.centerY).mas_equalTo(15);
        }];
        
    }
    return self;
}

- (void)setMineTopModel:(HCUserModel *)model {
    //头像
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    //昵称
    [self.lblNickName setText:model.nickname];
//    //群组名称
//    [self.lblGroupName setText:[NSString stringWithFormat:@"%@ %@",model.group_name,model.position_name]];
    //手机号
    [self.lblMobile setText:[HelperManager CreateInstance].mobile];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
