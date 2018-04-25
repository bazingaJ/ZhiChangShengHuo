//
//  XPLocationCell.h
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/10/23.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface XPLocationCell : UITableViewCell

- (void)setLocationModel:(AMapPOI *)model uid:(NSString *)uid;

@end
