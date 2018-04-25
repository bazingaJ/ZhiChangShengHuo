//
//  XPQuanDetailViewController.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XPQuanDetailViewController.h"
#import "XPQuanziFeedbackViewController.h"
#import "HCWKWebExViewController.h"

@interface XPQuanDetailViewController () {
    XPQuanziModel *quanziModel;
    
    NSInteger commNum;
    NSInteger praiseNum;
}

@end

@implementation XPQuanDetailViewController

- (XPKeyboardAutomaticView *)keyboardView {
    if(!_keyboardView) {
        _keyboardView = [[XPKeyboardAutomaticView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds), SCREEN_WIDTH, 210)];
        _keyboardView.delegate = self;
        _keyboardView.view = self.view;
        _keyboardView.limitNum = 100;
        _keyboardView.placeHolder = @"评论(请输入100字以内的文字)";
        [self.view addSubview:_keyboardView];
    }
    return _keyboardView;
}

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详情";
    
    //创建“底部导航条”
    XPQuanziCommentView *commentView = [[XPQuanziCommentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    commentView.delegate = self;
    [self.view addSubview:commentView];
    
}

- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    if(self.callBlock) {
        self.callBlock(quanziModel);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!quanziModel) return 0;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==1) {
        return self.dataArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==1) {
        return 40;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //动态
            return quanziModel.cellH;
            
            break;
        case 1: {
            //评论列表
            XPQuanziCommentModel *model;
            if(self.dataArr.count) {
                model = [self.dataArr objectAtIndex:indexPath.row];
            }
            return model.cellH;
            
            break;
        }
            
        default:
            break;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section!=1) return [UIView new];
    
    //创建“背景层”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    //创建“评论条数”
    self.lblCommentNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    [self.lblCommentNum setTextColor:[UIColor blackColor]];
    [self.lblCommentNum setTextAlignment:NSTextAlignmentLeft];
    [self.lblCommentNum setFont:FONT17];
    [backView addSubview:self.lblCommentNum];
    
    //设置评论信息
    [self setCommentNum];
    
    return backView;
}

- (void)setCommentNum {
    NSString *commStr = [NSString stringWithFormat:@"评论 ( %zd条)",commNum];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commStr];
    //字体颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:COLOR9 range:NSMakeRange(2, [commStr length]-2)];
    //字体大小
    [attrStr addAttribute:NSFontAttributeName
                    value:FONT12
                    range:NSMakeRange(2, [commStr length]-2)];
    self.lblCommentNum.attributedText = attrStr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        //动态
        static NSString *cellIndentifier = @"XPQuanziCellEx";
        XPQuanziCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[XPQuanziCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        [cell setDelegate:self];
        [cell setQuanziModel:quanziModel];
        
        return cell;
        
    }else{
        //评论
        static NSString *cellIndentifier = @"XPQuanziCommentCell";
        XPQuanziCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[XPQuanziCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        XPQuanziCommentModel *model;
        if(self.dataArr.count) {
            model = [self.dataArr objectAtIndex:indexPath.row];
        }
        [cell setQuanziCommentModel:model];
        
        return cell;
    }
}

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
    XPQuanziFeedbackViewController *feedBackView = [[XPQuanziFeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedBackView animated:YES];
}

- (void)XPQuanziCommentViewBottomBarClick:(NSInteger)tIndex {
    NSLog(@"评论");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    //评论
    [self.keyboardView.tbxComment.textView becomeFirstResponder];
    
}

- (void)XPKeyboardAutomaticViewClick:(NSString *)content withTag:(NSInteger)tag index:(NSInteger)index {
    if(index==1) {
        NSLog(@"您点击了发送按钮");
        if(IsStringEmpty(content)) {
            [MBProgressHUD showError:@"评论内容不能为空" toView:self.view];
            return;
        }
        
        UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"友情提醒" message:@"点击【同意】,即代表您已阅读并同意《圈子使用协议》，平台即将对您发布的内容进行审核，如有不良内容，平台有权删除您发布的内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"同意");
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:@"dynamic" forKey:@"app"];
            [param setValue:@"comment" forKey:@"act"];
            [param setValue:self.dynamic_id forKey:@"dynamic_id"];
            [param setValue:content forKey:@"content"];
            [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
            [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                NSString *msg = [json objectForKey:@"msg"];
                NSString *code = [json objectForKey:@"code"];
                if([code isEqualToString:SUCCESS]) {
                    [self.view endEditing:YES];
                    [MBProgressHUD showSuccess:@"评论成功" toView:self.view];
                    
                    NSDictionary *dataDic = [json objectForKey:@"data"];
                    XPQuanziModel *model = [XPQuanziModel mj_objectWithKeyValues:dataDic];
                    [self.dataArr insertObject:model atIndex:0];
                    
                    //设置评论数
                    commNum += 1;
                    [self setCommentNum];
                    
                    quanziModel.comment_num = [NSString stringWithFormat:@"%zd",commNum];
                    
                    //更新当前单元格的评论数
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    XPQuanziCell *cell = (XPQuanziCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                    [cell setCommNum:commNum];
                    
                    if(self.dataArr.count<=1) {
                        [self.tableView reloadData];
                    }else{
                        //插入最新评论
                        [self.tableView beginUpdates];
                        NSMutableArray *insertion = [[NSMutableArray alloc] init];
                        [insertion addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
                        [self.tableView insertRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationRight];
                        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                        [self.tableView endUpdates];
                    }
                }else{
                    [MBProgressHUD showError:msg toView:self.view];
                }
            } failure:^(NSError *error) {
                NSLog(@"%@",[error description]);
            }];
            
        }];
        [aler addAction:cancelAction];
        [aler addAction:okAction];
        [self presentViewController:aler animated:YES completion:nil];
        
    }else if(index==2) {
        //协议
        HCWKWebExViewController *aboutView = [[HCWKWebExViewController alloc] init];
        aboutView.title = @"致昌生活平台用户内容产生使用协议";
        //aboutView.contentStr = contentStr;
        [self.navigationController pushViewController:aboutView animated:YES];
    }
}

- (void)getDataList:(BOOL)isMore {
    
    if(!isMore) {
        //获取圈子详情信息
        [self getQuanziDetailInfo];
    }else{
        //获取更多评论信息
        [self getCampusCommentList];
    }
    
}

/**
 *  获取校园新鲜事详情
 */
- (void)getQuanziDetailInfo {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"dynamic" forKey:@"app"];
    [param setValue:@"detail" forKey:@"act"];
    [param setValue:self.dynamic_id forKey:@"dynamic_id"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            quanziModel = [XPQuanziModel mj_objectWithKeyValues:dataDic];

            //获取评论信息
            NSDictionary *commDic = [dataDic objectForKey:@"comment_list"];
            if(commDic && [commDic count]>0) {
                NSArray *commArr = [commDic objectForKey:@"list"];
                self.dataArr = [XPQuanziCommentModel mj_objectArrayWithKeyValuesArray:commArr];
            }
            
            //当前总数
            NSString *dataNum = [commDic objectForKey:@"count"];
            if(!IsStringEmpty(dataNum)) {
                self.totalNum = [dataNum integerValue];
            }else{
                self.totalNum = 0;
            }

            //评论数
            commNum = 0;
            if(!IsStringEmpty(quanziModel.comment_num)) {
                commNum = [quanziModel.comment_num intValue];
            }

            //点赞数
            praiseNum = 0;
            if(!IsStringEmpty(quanziModel.praise_num)) {
                praiseNum = [quanziModel.praise_num intValue];
            }

        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}

/**
 *  获取评论列表
 */
- (void)getCampusCommentList {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"dynamic" forKey:@"app"];
    [param setValue:@"getCommentList" forKey:@"act"];
    [param setValue:self.dynamic_id forKey:@"dynamic_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[XPQuanziCommentModel mj_objectWithKeyValues:itemDic]];
                }
            }
            
            //当前总数
            NSString *dataNum = [dataDic objectForKey:@"count"];
            if(!IsStringEmpty(dataNum)) {
                self.totalNum = [dataNum integerValue];
            }else{
                self.totalNum = 0;
            }
            
        }
        [self.tableView reloadData];
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
