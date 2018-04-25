//
//  KSearchResultListViewController.h
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSearchResultListViewController : BaseTableViewController

/**
 *  分类ID
 */
@property (nonatomic, assign) NSInteger type;
/**
 *  搜索关键字
 */
@property (nonatomic, strong) NSString *searchStr;

@end
