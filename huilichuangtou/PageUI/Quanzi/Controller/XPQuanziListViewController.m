//
//  XPQuanziListViewController.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanziListViewController.h"
#import "XPQuanDetailViewController.h"
#import "XPQuanziPublishViewController.h"
#import "XPQuanziFeedbackViewController.h"

@interface XPQuanziListViewController ()

@end

@implementation XPQuanziListViewController

- (void)viewDidLoad {
    [self setTopH:44];
    [self setBottomH:49];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"圈子";
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quanziPublishNotification:) name:QUANZI_PUBLISH_NOTIFICATION object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    //销毁通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *   圈子发布通知
 */
- (void)quanziPublishNotification:(NSNotification *)notification {
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    NSDictionary *dataDic = [notification userInfo];
    NSString *cateId = [dataDic objectForKey:@"QUANZI_CATE_ID"];
    if([cateId isEqualToString:self.cate_id]) {
        XPQuanziPublishViewController *publishView = [[XPQuanziPublishViewController alloc] init];
        publishView.callBack = ^(NSDictionary *dataDic) {
            XPQuanziModel *model = [XPQuanziModel mj_objectWithKeyValues:dataDic];
            [self.dataArr insertObject:model atIndex:0];
            
            if(self.dataArr.count==1) {
                [self.tableView.mj_header beginRefreshing];
            }else{
                //插入到第一行
                [self.tableView beginUpdates];
                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
                [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationRight];
                [self.tableView endUpdates];
            }
            
        };
        [self.navigationController pushViewController:publishView animated:YES];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XPQuanziModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    return model.cellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section==[self.dataArr count]-1) {
        return 10;
    }
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"XPQuanziCell";
    XPQuanziCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[XPQuanziCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    XPQuanziModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setDelegate:self];
    [cell setQuanziModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XPQuanziModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    //跳转至详情
    XPQuanDetailViewController *detailView = [[XPQuanDetailViewController alloc] init];
    detailView.dynamic_id = model.dynamic_id;
    detailView.callBlock = ^(XPQuanziModel *quanziModel) {
        NSLog(@"回调成功");
        //刷新当前单元格
        model.comment_num = quanziModel.comment_num;
        model.praise_num = quanziModel.praise_num;
        model.is_praise = quanziModel.is_praise;

        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    };
    [self.navigationController pushViewController:detailView animated:YES];

}

//委托代理
- (void)XPQuanziDynamicImageClick:(NSMutableArray *)imgArr tIndex:(NSInteger)tIndex {
    NSMutableArray *photoArr = [NSMutableArray array];
    for (NSString *imgURL in imgArr) {
        ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
        photo.photoURL = [NSURL URLWithString:imgURL];
        [photoArr addObject:photo];
    }
    
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.photos = photoArr;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndex = tIndex;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

/**
 *  举报委托代理
 */
- (void)XPQuanziDynamicJuBaoClick:(XPQuanziModel *)model {
    NSLog(@"举报委托代理");
    
    XPQuanziFeedbackViewController *feedBackView = [[XPQuanziFeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedBackView animated:YES];
    
}

/**
 *  获取圈子列表
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"dynamic" forKey:@"app"];
    [param setValue:@"getList" forKey:@"act"];
    [param setValue:self.cate_id forKey:@"cate_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[XPQuanziModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
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
