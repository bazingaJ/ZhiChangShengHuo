//
//  HCHomeViewController.m
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "HCHomeViewController.h"
#import "HCEquityCell.h"
#import "HCTouziCell.h"
#import "HCXiangmuEquityDetailViewController.h"
#import "HCXiangmuTouziDetailViewController.h"
#import "HCAdModel.h"
#import "HCNewsModel.h"
#import "HCHomeViewController+Version.h"
#import "HCXiangmuEquityViewController.h"
#import "HCXiangmuTouziViewController.h"
#import "HCSearchViewController.h"
#import "HCActivityCell.h"
#import "HCActivityDetailViewController.h"

@interface HCHomeViewController ()

@end

@implementation HCHomeViewController

- (HCHomeTopView *)topView {
    if(!_topView) {
        _topView = [[HCHomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        _topView.delegate = self;
    }
    return _topView;
}

- (NSMutableArray *)equityArr {
    if(!_equityArr) {
        _equityArr = [NSMutableArray array];
    }
    return _equityArr;
}

- (NSMutableArray *)touziArr {
    if(!_touziArr) {
        _touziArr = [NSMutableArray array];
    }
    return _touziArr;
}

- (NSMutableArray *)adArr {
    if(!_adArr) {
        _adArr = [NSMutableArray array];
    }
    return _adArr;
}

- (NSMutableArray *)newsArr {
    if(!_newsArr) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}

- (NSMutableArray *)activityArr {
    if(!_activityArr) {
        _activityArr = [NSMutableArray array];
    }
    return _activityArr;
}

- (void)viewDidLoad {
    [self setBottomH:49];
    [self setLeftButtonItemHidden:YES];
    if(APP_DELEGATE.isOK) {
        [self setRightButtonItemImageName:@"icon_search"];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"致昌生活";
    
    self.tableView.tableHeaderView = [self topView];
    
    //版本检测
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkSystemVersion];
    });
    
}

/**
 *  搜索按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"搜索按钮");
    
    HCSearchViewController *searchView = [[HCSearchViewController alloc] init];
    [self.navigationController pushViewController:searchView animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!APP_DELEGATE.isOK) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!APP_DELEGATE.isOK) {
        return self.activityArr.count;
    }
    switch (section) {
        case 0:
            //股权众筹
            return self.equityArr.count;
            
            break;
        case 1:
            //投资项目
            return self.touziArr.count;
            
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!APP_DELEGATE.isOK) {
        return 115;
    }
    switch (indexPath.section) {
        case 0:
            //股权众筹
            return 180;
            
            break;
        case 1:
            //投资项目
            return 130;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    if(!APP_DELEGATE.isOK) {
        
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-65, 20)];
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT16];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnFunc setTitle:@"热门活动" forState:UIControlStateNormal];
        [btnFunc setImage:[UIImage imageNamed:@"home_icon_touzi"] forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [backView addSubview:btnFunc];
    }else{
        
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-65, 20)];
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT16];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        if(section==0) {
            [btnFunc setTitle:@"股权众筹" forState:UIControlStateNormal];
            [btnFunc setImage:[UIImage imageNamed:@"home_icon_equity"] forState:UIControlStateNormal];
        }else if(section==1) {
            [btnFunc setTitle:@"投资项目" forState:UIControlStateNormal];
            [btnFunc setImage:[UIImage imageNamed:@"home_icon_touzi"] forState:UIControlStateNormal];
        }
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [backView addSubview:btnFunc];
        
        //创建“更多”
        UIButton *btnFunc2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-55, 0, 45, 40)];
        [btnFunc2 setTitle:@"更多" forState:UIControlStateNormal];
        [btnFunc2 setTitleColor:COLOR9 forState:UIControlStateNormal];
        [btnFunc2.titleLabel setFont:FONT14];
        [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btnFunc2 addTouch:^{
            if(section==0) {
                //股权众筹
                HCXiangmuEquityViewController *equityView = [[HCXiangmuEquityViewController alloc] init];
                [equityView setTitle:@"股权众筹"];
                [equityView setIsHome:YES];
                [self.navigationController pushViewController:equityView animated:YES];
                
            }else if(section==1) {
                //投资项目
                HCXiangmuTouziViewController *touziView = [[HCXiangmuTouziViewController alloc] init];
                [touziView setTitle:@"投资项目"];
                [touziView setIsHome:YES];
                [self.navigationController pushViewController:touziView animated:YES];
            }
        }];
        [backView addSubview:btnFunc2];
    }
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [backView addSubview:lineView];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!APP_DELEGATE.isOK) {
        static NSString *cellIndentifier = @"HCActivityCell";
        HCActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HCActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        HCActivityModel *model;
        if(self.activityArr.count) {
            model = [self.activityArr objectAtIndex:indexPath.row];
        }
        [cell setActivityModel:model];
        
        return cell;
    }else{
        if(indexPath.section==0) {
            static NSString *cellIndentifier = @"HCEquityCell";
            HCEquityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[HCEquityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
            HCEquityModel *model;
            if(self.equityArr.count) {
                model = [self.equityArr objectAtIndex:indexPath.row];
            }
            [cell setEquityModel:model];
            
            //创建“分割线”
            if(indexPath.row<[self.equityArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 10)];
                [lineView setBackgroundColor:BACK_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            return cell;
        }else{
            static NSString *cellIndentifier = @"HCTouziCell";
            HCTouziCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[HCTouziCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
            HCTouziModel *model;
            if(self.touziArr.count) {
                model = [self.touziArr objectAtIndex:indexPath.row];
            }
            [cell setTouziModel:model];
            
            //创建“分割线”
            if(indexPath.row<[self.touziArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 10)];
                [lineView setBackgroundColor:BACK_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!APP_DELEGATE.isOK) {
        HCActivityModel *model;
        if(self.activityArr.count) {
            model = [self.activityArr objectAtIndex:indexPath.row];
        }
        if(!model) return;
        
        //活动详情
        HCActivityDetailViewController *activityView = [[HCActivityDetailViewController alloc] init];
        activityView.activityModel = model;
        [self.navigationController pushViewController:activityView animated:YES];
    }else{
        switch (indexPath.section) {
            case 0: {
                //股权众筹
                HCEquityModel *model;
                if(self.equityArr.count) {
                    model = [self.equityArr objectAtIndex:indexPath.row];
                }
                if(!model) return;
                
                //跳转至详情
                HCXiangmuEquityDetailViewController *webView = [[HCXiangmuEquityDetailViewController alloc] init];
                if([model.buy_status isEqualToString:@"1"]) {
                    //预热中
                    [webView setTabH:45];
                }
                [webView setUrl:model.detail_url];
                [webView setEquityModel:model];
                [self.navigationController pushViewController:webView animated:YES];
                
                break;
            }
            case 1: {
                //投资项目
                HCTouziModel *model;
                if(self.touziArr.count) {
                    model = [self.touziArr objectAtIndex:indexPath.row];
                }
                if(!model) return;
                
                //跳转至详情
                HCXiangmuTouziDetailViewController *webView = [[HCXiangmuTouziDetailViewController alloc] init];
                if([model.buy_status isEqualToString:@"1"]) {
                    //预热中
                    [webView setTabH:45];
                }
                [webView setUrl:model.detail_url];
                [webView setTouziModel:model];
                [self.navigationController pushViewController:webView animated:YES];
                
                break;
            }
                
            default:
                break;
        }
    }
    
}

/**
 *  广告点击委托代理
 */
- (void)HCHomeTopViewAdDidSelectItemAtIndex:(NSInteger)tIndex {
    NSLog(@"广告点击委托代理");
}

/**
 *  资讯点击委托代理
 */
- (void)HCHomeTopViewNewsDidSelectItemAtIndex:(NSInteger)tIndex {
    NSLog(@"资讯点击委托代理：%zd",tIndex);
    
    HCNewsModel *model;
    if(self.newsArr.count) {
        model = [self.newsArr objectAtIndex:tIndex];
    }
    if(!model) return;
    
    //资讯详情
    HCWKWebViewController *webView = [[HCWKWebViewController alloc] init];
    [webView setTitle:@"详情"];
    [webView setUrl:model.url];
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"index" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                //广告
                self.adArr = [HCAdModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"ad_list"]];
                //设置广告
                if(self.adArr.count) {
                    NSMutableArray *itemArr = [NSMutableArray array];
                    for (int i=0; i<self.adArr.count; i++) {
                        HCAdModel *adModel = [self.adArr objectAtIndex:i];
                        if(!adModel || !adModel.cover_url.length) continue;
                        [itemArr addObject:adModel.cover_url];
                    }
                    self.topView.cycleScrollView.imageURLStringsGroup = [itemArr copy];
                }
                
                //资讯
                self.newsArr = [HCNewsModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"news_list"]];
                self.topView.newsArr = self.newsArr;
                
//                //推荐新闻
//                self.newsList = [HCNewsModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"news_list2"]];
                
                //活动
                self.activityArr = [HCActivityModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"activity_list"]];
                
                //众筹
                self.equityArr = [HCEquityModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"crowd_list"]];
                
                //投资
                self.touziArr = [HCTouziModel mj_objectArrayWithKeyValuesArray:[dataDic objectForKey:@"invest_list"]];
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
