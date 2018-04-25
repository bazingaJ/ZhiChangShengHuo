//
//  XPQuanziTagsViewController.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/30.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPQuanziTagsViewController : BaseTableViewController

@property (nonatomic, copy) void(^callBack)(NSString *tag_id, NSString *tag_name);

@end
