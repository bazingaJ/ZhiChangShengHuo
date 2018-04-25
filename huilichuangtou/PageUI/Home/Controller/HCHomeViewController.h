//
//  HCHomeViewController.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/9.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCHomeTopView.h"

@interface HCHomeViewController : BaseTableViewController<HCHomeTopViewDelegate>

@property (nonatomic, strong) HCHomeTopView *topView;
@property (nonatomic, strong) NSMutableArray *equityArr;
@property (nonatomic, strong) NSMutableArray *touziArr;
@property (nonatomic, strong) NSMutableArray *adArr;
@property (nonatomic, strong) NSMutableArray *newsArr;
@property (nonatomic, strong) NSMutableArray *activityArr;

@end
