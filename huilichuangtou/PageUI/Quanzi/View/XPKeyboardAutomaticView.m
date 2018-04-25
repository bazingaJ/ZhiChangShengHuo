//
//  YBKeyboardAutomaticView.m
//  jiuyebang
//
//  Created by 相约在冬季 on 2017/4/10.
//  Copyright © 2017年 jiuyebang. All rights reserved.
//

#import "XPKeyboardAutomaticView.h"
#import "XHToast.h"

static NSString const *placeHolderStr = @"请输入少于300字的内容...";

@implementation XPKeyboardAutomaticView

//初始化
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, CGRectGetMinY(frame), self.frame.size.width, CGRectGetHeight(frame));
        
        //创建View
        [self createView];
        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _originalFrame = frame;
}

//_originalFrame的set方法  因为会调用setFrame  所以就不在此做赋值；
-(void)setOriginalFrame:(CGRect)originalFrame {
    self.frame = CGRectMake(0, CGRectGetMinY(originalFrame), self.frame.size.width, CGRectGetHeight(originalFrame));
}

//释放销毁
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//创建视图
- (void)createView {
    //创建“顶部分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self addSubview:lineView];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 35, 25)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:UIColorFromRGBWith16HEX(0x999999) forState:UIControlStateNormal];
    [btnCancel.titleLabel setFont:FONT15];
    [btnCancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnCancel setTag:0];
    [btnCancel addTarget:self action:@selector(btnKeyboardPressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnCancel];
    
    //创建“评论”
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH-120, 25)];
    [self.lblTitle setText:@"评论"];
    [self.lblTitle setTextColor:COLOR3];
    [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
    [self.lblTitle setFont:FONT16];
    [self addSubview:self.lblTitle];
    
    //创建“发送按钮”
    UIButton *btnSend = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 10, 35, 25)];
    [btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [btnSend setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [btnSend.titleLabel setFont:FONT15];
    [btnSend setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnSend setTag:1];
    [btnSend addTarget:self action:@selector(btnKeyboardPressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnSend];
    
    //创建“评论输入框”
    self.tbxComment = [[ZTELimitTextView alloc] initWithFrame:CGRectMake(10, 45, self.frame.size.width-20, 115)];
    self.tbxComment.limitNum = self.limitNum;
    //self.tbxComment.placeHolder = self.placeHolder;
    [self.tbxComment.layer setCornerRadius:5.0];
    [self.tbxComment.layer setBorderWidth:0.5];
    [self.tbxComment.layer setBorderColor:LINE_COLOR.CGColor];
    [self.tbxComment setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.tbxComment];
    
    NSString *titleStr = @"点击【发布】,代表您已阅读并同意《圈子使用协议》";
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 170, SCREEN_WIDTH-20, 30)];
    [btnFunc setTitle:titleStr forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR6 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc setImage:[UIImage imageNamed:@"quanzi_location_selected"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btnFunc setTag:2];
    [btnFunc addTarget:self action:@selector(btnKeyboardPressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnFunc];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
    //字体颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:MAIN_COLOR
                    range:NSMakeRange(titleStr.length-8, 8)];
    //            //字体大小
    //            [attrStr addAttribute:NSFontAttributeName
    //                            value:FONT13
    //                            range:NSMakeRange(0, 1)];
    btnFunc.titleLabel.attributedText = attrStr;
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.lblTitle setText:title];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;

    //self.tbxComment.placeHolder = IsStringEmpty(_placeHolder) ? placeHolderStr : _placeHolder;
}

- (void)setLimitNum:(NSInteger)limitNum {
    _limitNum = limitNum;
    
    self.tbxComment.limitNum = self.limitNum;
}

//发布按钮事件
- (void)btnKeyboardPressClick:(UIButton *)btnSender {
    //[self resignFirstResponder];
    if(btnSender.tag==0) {
        //取消
        [self dismissKey];
    }else{
//        NSString *commStr = [NSString stringByTrimmingCharactersInSetEx:self.tbxComment.textView.text];
//        if(IsStringEmpty(commStr)) {
//            [XHToast showCenterWithText:@"输入的内容不能为空"];
//            return;
//        }else if([commStr length]>300) {
//            [XHToast showCenterWithText:@"输入的内容不能超过300个字符"];
//            return;
//        }
        //判断是否包含表情字符
//        if([NSString stringContainsEmoji:commStr] && !_is_QuanZi) {
//            //底部显示+自定义距顶端距离
//            [XHToast showCenterWithText:@"评论的内容不能包含表情"];
//            return;
//        }
        [self.delegate XPKeyboardAutomaticViewClick:self.tbxComment.textView.text withTag:self.tag index:btnSender.tag];
        [self dismissKey];
    }
}

- (void)dismissKey {
    [_view endEditing:YES];
    [self.tbxComment.textView setText:@""];
    //self.tbxComment.placeHolder = IsStringEmpty(_placeHolder) ? placeHolderStr : _placeHolder;
}

- (void)keyboardWillShow:(NSNotification*)notification{
    //获取焦点

    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    NSLog(@"%f-%f-%f-%f",_keyboardRect.origin.y,_keyboardRect.size.height,[self getHeighOfWindow]-CGRectGetMaxY(self.frame),CGRectGetMinY(self.frame));
    
    //如果self在键盘之下 才做偏移
    if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)] >= _keyboardRect.origin.y) {
        //没有偏移 就说明键盘没出来，使用动画
        if (self.frame.origin.y == self.originalFrame.origin.y) {
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-NAVIGATION_BAR_HEIGHT);
                             } completion:nil];
        }else{
            self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-NAVIGATION_BAR_HEIGHT);
        }
    }else{
        
    }
}

//隐藏键盘
- (void)keyboardWillHide:(NSNotification*)notification{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, 0);
                     } completion:nil];
}

//将坐标点y 在window和superview转化  方便和键盘的坐标比对
-(float)convertYFromWindow:(float)Y {
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
    return o.y;
}


-(float)convertYToWindow:(float)Y {
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return o.y;
}

-(float)getHeighOfWindow {
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate.window.frame.size.height;
}

-(BOOL)resignFirstResponder {
    return [super resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
