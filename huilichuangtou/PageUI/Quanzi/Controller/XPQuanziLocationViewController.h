//
//  XPQuanziLocationViewController.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

typedef void(^SelectLocationSuccessBlock)(AMapPOI *poi);

@interface XPQuanziLocationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic,strong)   AMapPOI                      *oldPoi;
@property (nonatomic,copy  )   SelectLocationSuccessBlock   successBlock;

@property (nonatomic,strong) AMapSearchAPI  *search;
@property (nonatomic,assign) BOOL needInsertOldAddress;
@property (nonatomic,assign) BOOL isSelectCity;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageCount;

@property (nonatomic, assign) CGFloat lng;
@property (nonatomic, assign) CGFloat lat;

@end
