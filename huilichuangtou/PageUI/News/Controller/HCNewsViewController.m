//
//  HCNewsViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCNewsViewController.h"
#import "HCPagesViewController.h"
#import "HCNewsListViewController.h"
#import "HCCateModel.h"

@interface HCNewsViewController ()

@end

@implementation HCNewsViewController

- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [self setLeftButtonItemHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *titleArr = [NSMutableArray array];
    
    HCCateModel *model = [HCCateModel new];
    model.cate_id = @"0";
    model.cate_name = @"全部";
    [self.dataArr addObject:model];
    
    [titleArr addObject:@"全部"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"news" forKey:@"app"];
    [param setValue:@"getNewsCate" forKey:@"act"];
    NSDictionary *dataDic = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [dataDic objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSArray *dataList = [dataDic objectForKey:@"data"];
        
        for (NSDictionary *itemDic in dataList) {
            HCCateModel *model = [HCCateModel mj_objectWithKeyValues:itemDic];
            if(!model) continue;
            [self.dataArr addObject:model];
            
            [titleArr addObject:model.cate_name];
        }
        
    }

    HCPagesViewController *pages = [[HCPagesViewController alloc] init];
    pages.pageScrollView.backgroundColor = [UIColor whiteColor];
    pages.topBar.scrollView.backgroundColor =[UIColor whiteColor];
    pages.topBar.itemTitleColor =COLOR9;
    pages.topBar.lineView.backgroundColor =MAIN_COLOR;
    pages.view.frame = self.view.bounds;
    pages.showToNavigationBar = NO;
    pages.selectedIndex = 0;
    pages.topBar.selectedItemTitleColor = MAIN_COLOR;
    pages.topBar.itemTitles = titleArr;
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < pages.topBar.itemTitles.count; i++) {
        HCCateModel *model = [self.dataArr objectAtIndex:i];
        if(!model) continue;
        
        //新闻列表
        HCNewsListViewController *topicVC = [[HCNewsListViewController alloc] init];
        topicVC.cate_id = model.cate_id;
        [array addObject:topicVC];
    }
    pages.viewControllers = array.copy;
    [self addChildViewController:pages];
    [self.view addSubview:pages.view];
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
