//
//  HCXiangmuViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCXiangmuViewController.h"
#import "HCXiangmuEquityViewController.h"
#import "HCXiangmuTouziViewController.h"

@interface HCXiangmuViewController () {
    NSInteger pageIndex;
}

@property (nonatomic, strong) HCXiangmuEquityViewController *equityView;
@property (nonatomic, strong) HCXiangmuTouziViewController *touziView;
@property (nonatomic ,strong) UIViewController *currentVC;

@end

@implementation HCXiangmuViewController

- (HCXiangmuEquityViewController *)equityView {
    if(!_equityView) {
        _equityView = [[HCXiangmuEquityViewController alloc] init];
        _equityView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_equityView];
    }
    return _equityView;
}

- (HCXiangmuTouziViewController *)touziView {
    if(!_touziView) {
        _touziView = [[HCXiangmuTouziViewController alloc] init];
        _touziView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_touziView];
    }
    return _touziView;
}


- (void)viewDidLoad {
    [self setLeftButtonItemHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)];
    [self.navigationItem setTitleView:backView];
    
    //创建“按钮”
    NSArray *titleArr = @[@"投资项目",@"股权众筹"];
    CGFloat tWidth = SCREEN_WIDTH/[titleArr count];
    for (int i=0; i<[titleArr count]; i++) {
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*i, 15, tWidth, 20)];
        [btnFunc setTitle:titleArr[i] forState:UIControlStateNormal];
        if(i==0) {
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if(i==1) {
            [btnFunc setTitleColor:[UIColor colorWithWhite:1 alpha:0.7] forState:UIControlStateNormal];
        }
        [btnFunc.titleLabel setFont:FONT16];
        [btnFunc setTag:i+1];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btnFunc];
    }
    
    pageIndex = 2;
    
    //设置默认控制器
    self.currentVC = self.touziView;
    [self.view addSubview:self.touziView.view];
    
}

- (void)btnFuncClick:(UIButton *)btnSender {
    if(btnSender.tag!=pageIndex) return;
    
    for (UIView *view in btnSender.superview.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btnFunc = (UIButton *)view;
            [btnFunc setTitleColor:[UIColor colorWithWhite:1 alpha:0.7] forState:UIControlStateNormal];
        }
    }
    
    if(pageIndex==1) {
        //投资项目
        
        [btnSender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self replaceController:self.currentVC newController:self.touziView];
        pageIndex = 2;
    }else if(pageIndex==2){
        //股权众筹
        
        [btnSender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self replaceController:self.currentVC newController:self.equityView];
        pageIndex = 1;
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间
     *  options                 动画效果
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
