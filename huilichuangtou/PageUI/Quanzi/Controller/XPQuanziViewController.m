//
//  XPQuanziViewController.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/24.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziViewController.h"
#import "HCPagesViewController.h"
#import "XPQuanziListViewController.h"
#import "XPCateModel.h"

@interface XPQuanziViewController () {
    NSString *cateId;
}

@end

@implementation XPQuanziViewController

- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [self setLeftButtonItemHidden:YES];
    [self setRightButtonItemImageName:@"quanzi_icon_publish"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"圈子";
    
    //默认选中第一个
    NSInteger tIndex = 0;
    
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@"全部"];
    
    XPCateModel *model = [XPCateModel new];
    model.cate_id = @"0";
    model.cate_name = @"全部";
    [self.dataArr addObject:model];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"dynamic" forKey:@"app"];
    [param setValue:@"getCateList" forKey:@"act"];
    NSDictionary *dataDic = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [dataDic objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSArray *dataList = [dataDic objectForKey:@"data"];
        
        NSInteger i = 1;
        for (NSDictionary *itemDic in dataList) {
            XPCateModel *model = [XPCateModel mj_objectWithKeyValues:itemDic];
            if(!model) continue;
            [self.dataArr addObject:model];

            if([model.cate_id isEqualToString:self.cate_id]) {
                tIndex = i;
            }else{
                i++;
            }
            [titleArr addObject:model.cate_name];
        }
    }
    
    HCPagesViewController *pages = [[HCPagesViewController alloc] init];
    pages.pageScrollView.backgroundColor = [UIColor whiteColor];
    pages.topBar.scrollView.backgroundColor =[UIColor whiteColor];
    pages.topBar.itemTitleColor = COLOR9;
    pages.topBar.lineView.backgroundColor = MAIN_COLOR;
    pages.view.frame = self.view.bounds;
    pages.showToNavigationBar = NO;
    pages.selectedIndex = tIndex;
    pages.topBar.selectedItemTitleColor = MAIN_COLOR;
    pages.topBar.itemTitles = titleArr;
    pages.callBack = ^(NSInteger tIndex) {
        NSLog(@"索引值为：%zd",tIndex);
        
        XPCateModel *model = [self.dataArr objectAtIndex:tIndex];
        
        //分类ID
        cateId = model.cate_id;
        
    };
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < pages.topBar.itemTitles.count; i++) {
        XPCateModel *model = [self.dataArr objectAtIndex:i];
        if(!model) continue;
        
        //圈子列表
        XPQuanziListViewController *topicVC = [[XPQuanziListViewController alloc] init];
        topicVC.cate_id = model.cate_id;
        [array addObject:topicVC];
    }
    pages.viewControllers = array.copy;
    [self addChildViewController:pages];
    [self.view addSubview:pages.view];
    
}

/**
 *  发布按钮点击事件
 */
- (void)rightButtonItemClick {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:cateId forKey:@"QUANZI_CATE_ID"];
    [[NSNotificationCenter defaultCenter] postNotificationName:QUANZI_PUBLISH_NOTIFICATION object:nil userInfo:dataDic];
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
