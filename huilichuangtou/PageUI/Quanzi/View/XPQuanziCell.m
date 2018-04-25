//
//  XPQuanziCell.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziCell.h"

@implementation XPQuanziCell

- (void)setQuanziModel:(XPQuanziModel *)model {
    if(!model) return;
    
    //动态图片存储器
    self.imgArr = model.imgs;
    
    //创建“头像”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView.layer setCornerRadius:20.0];
    [imgView.layer setMasksToBounds:YES];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    [self.contentView addSubview:imgView];
    
    //创建“用户名”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, SCREEN_WIDTH-70, 20)];
    [lbMsg setText:model.user_nickname];
    [lbMsg setTextColor:COLOR6];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT17];
    [self.contentView addSubview:lbMsg];
    
    //创建“发布时间”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, SCREEN_WIDTH-70, 20)];
    [lbMsg3 setText:model.date];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT12];
    [self.contentView addSubview:lbMsg3];
    
    //举报
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 70, 25)];
    [btnFunc setTitle:@"举报" forState:UIControlStateNormal];
    [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc.layer setCornerRadius:4.0];
    [btnFunc.layer setBorderWidth:0.5];
    [btnFunc.layer setBorderColor:MAIN_COLOR.CGColor];
    [btnFunc addTouch:^{
        NSLog(@"举报");
        
        if([self.delegate respondsToSelector:@selector(XPQuanziDynamicJuBaoClick:)]) {
            [self.delegate XPQuanziDynamicJuBaoClick:model];
        }
        
    }];
    [self.contentView addSubview:btnFunc];
    
    //创建“发布内容”
    NSString *content = model.content;
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, model.textH)];
    [lbMsg2 setText:content];
    [lbMsg2 setTextColor:[UIColor blackColor]];
    [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
    [lbMsg2 setNumberOfLines:0];
    [lbMsg2 setFont:FONT17];
    if(!IsStringEmpty(content)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:content];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:8.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
        [lbMsg2 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg2];
    
    //创建“图片”
    NSInteger imgNum = model.imgs.count;
    if(imgNum) {
        if(imgNum==1) {
            //1张图片
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, lbMsg2.bottom, 200, 145)];
            [btnFunc.imageView setContentMode:UIViewContentModeScaleAspectFill];
            [btnFunc.imageView setClipsToBounds:YES];
            [btnFunc sd_setImageWithURL:[NSURL URLWithString:model.imgs[0]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_banner_list"]];
            [btnFunc setTag:0];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btnFunc];
            
        }else {
            //多张图片
            NSInteger rowNum = imgNum/3;
            NSInteger ysNum = imgNum%3;
            if(ysNum>0) {
                rowNum += 1;
            }
            if(rowNum>3) {
                rowNum = 3;
            }
            CGFloat imgWidth = (SCREEN_WIDTH-20-10)/3;
            for (int i=0; i<rowNum; i++) {
                for (int k=0; k<3; k++) {
                    int tIndex = 3*i+k;
                    if(tIndex>imgNum-1) continue;
                    NSString *imgURL = [model.imgs objectAtIndex:tIndex];
                    
                    //创建“图片”
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+(imgWidth+5)*k, CGRectGetMaxY(lbMsg2.frame)+(imgWidth+5)*i, imgWidth, imgWidth)];
                    [btnFunc.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    [btnFunc.imageView setClipsToBounds:YES];
                    [btnFunc sd_setImageWithURL:[NSURL URLWithString:imgURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_banner_list"]];
                    [btnFunc setTag:tIndex];
                    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                    [self.contentView addSubview:btnFunc];
                }
            }
        }
    }
    
    //创建“地址”
    if(!IsStringEmpty(model.address)) {
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, model.cellH-55, SCREEN_WIDTH-20, 20)];
        [btnFunc setTitle:model.address forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT12];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnFunc setImage:[UIImage imageNamed:@"quanzi_icon_location"] forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.contentView addSubview:btnFunc];
    }
    
    //创建“评论区块”
    for (int i=0; i<2; i++) {
        self.btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140+65*i, model.cellH-30, 65, 20)];
        if(i==0) {
            //评论
            NSString *commStr = model.comment_num;
            
            NSInteger commNum = 0;
            if(!IsStringEmpty(commStr)) {
                commNum = [commStr intValue];
            }
            if(commNum>1000) {
                commStr = @"1000+";
            }
            
            [self.btnFunc setTitle:commStr forState:UIControlStateNormal];
            [self.btnFunc setImage:[UIImage imageNamed:@"campus_comment"] forState:UIControlStateNormal];
        }else if(i==1) {
            //点赞
            NSString *praiseStr = model.praise_num;
            
            NSInteger praiseNum = 0;
            if(!IsStringEmpty(praiseStr)) {
                praiseNum = [praiseStr intValue];
            }
            if(praiseNum>1000) {
                praiseStr = @"1000+";
            }
            [self.btnFunc setTitle:praiseStr forState:UIControlStateNormal];
            if([model.is_praise isEqualToString:@"1"]) {
                //已点赞
                [self.btnFunc setImage:[UIImage imageNamed:@"praise_yes"] forState:UIControlStateNormal];
            }else if([model.is_praise isEqualToString:@"2"]) {
                //未点赞
                [self.btnFunc setImage:[UIImage imageNamed:@"praise_no"] forState:UIControlStateNormal];
            }
            WS(weakSelf);
            [self.btnFunc addTouch:^{
                [weakSelf setPraiseNum:model btnSender:weakSelf.btnFunc];
            }];
        }
        [self.btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
        [self.btnFunc.titleLabel setFont:FONT12];
        [self.btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        [self.btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.btnFunc setTag:100+i];
        [self.contentView addSubview:self.btnFunc];
    }
    
}

/**
 *  功能按钮点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    if([self.delegate respondsToSelector:@selector(XPQuanziDynamicImageClick:tIndex:)]) {
        [self.delegate XPQuanziDynamicImageClick:self.imgArr tIndex:btnSender.tag];
    }
}

/**
 *  设置点赞信息
 */
- (void)setPraiseNum:(XPQuanziModel *)model btnSender:(UIButton *)btnSender {
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    //如果已经点赞过就跳过
    if([model.is_praise isEqualToString:@"1"]) return;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"dynamic" forKey:@"app"];
    [param setValue:@"praise" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [param setValue:model.dynamic_id forKey:@"dynamic_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"点赞成功" toView:nil];
            
            NSInteger praiseNum = 0;
            if(!IsStringEmpty(model.praise_num)) {
                praiseNum = [model.praise_num intValue];
            }
            praiseNum += 1;
            
            //设置一点赞标识、及点赞值
            model.is_praise = @"1";
            model.praise_num = [NSString stringWithFormat:@"%zd",praiseNum];
            
            [btnSender setTitle:[NSString stringWithFormat:@"%zd",praiseNum] forState:UIControlStateNormal];
            [btnSender setImage:[UIImage imageNamed:@"praise_yes"] forState:UIControlStateNormal];
        }else{
            [MBProgressHUD showError:msg toView:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

/**
 *  设置点赞、评论等信息
 */
- (void)setCommNum:(NSInteger)commNum {
    for (UIView *view in self.contentView.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btnFunc = (UIButton *)view;
            if(btnFunc.tag==100) {
                //评论数
                [btnFunc setTitle:[NSString stringWithFormat:@"%zd",commNum] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
