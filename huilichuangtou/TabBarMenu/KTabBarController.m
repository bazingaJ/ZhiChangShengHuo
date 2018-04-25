//
//  KTabBarController.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "KTabBarController.h"
#import "HCHomeViewController.h"
#import "HCXiangmuViewController.h"
#import "HCNewsViewController.h"
#import "HCMineViewController.h"
#import "XBTabBar.h"
#import "XPQuanziViewController.h"

@interface KTabBarController () {
    XBTabBar *tabBar;
}

@end

@implementation KTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundColor = WHITE_COLOR;
    self.tabBar.barTintColor = WHITE_COLOR;
    
    //首页
    HCHomeViewController *homeView = [[HCHomeViewController alloc] init];
    homeView.tabBarItem.tag = 1;
    [self addChildController:homeView title:@"首页" imageName:@"tabbar_home_normal" selectedImageName:@"tabbar_home_selected"];
    
    //项目
    if(APP_DELEGATE.isOK) {
        HCXiangmuViewController *xiangmuView = [[HCXiangmuViewController alloc] init];
        xiangmuView.tabBarItem.tag = 2;
        [self addChildController:xiangmuView title:@"项目" imageName:@"tabbar_xiangmu_normal" selectedImageName:@"tabbar_xiangmu_selected"];
    }
    
    //资讯
    HCNewsViewController *newsView = [[HCNewsViewController alloc] init];
    newsView.tabBarItem.tag = 3;
    [self addChildController:newsView title:@"资讯" imageName:@"tabbar_news_normal" selectedImageName:@"tabbar_news_selected"];
    
    //圈子
    if(!APP_DELEGATE.isOK) {
        XPQuanziViewController *quanziView = [[XPQuanziViewController alloc] init];
        quanziView.tabBarItem.tag = 4;
        [self addChildController:quanziView title:@"圈子" imageName:@"tabbar_quanzi_normal" selectedImageName:@"tabbar_quanzi_selected"];
    }
    
    //我的
    HCMineViewController *mineView = [[HCMineViewController alloc] init];
    mineView.tabBarItem.tag = 5;
    [self addChildController:mineView title:@"我的" imageName:@"tabbar_mine_normal" selectedImageName:@"tabbar_mine_selected"];
    
}

- (void)addChildController:(UIViewController *)vc title:(NSString *)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName {
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置一下选中tabbar文字颜色
    [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorFromRGBWith16HEX(0x999999) }forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : ORANGE_COLOR} forState:UIControlStateSelected];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"您点击了按钮");
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
