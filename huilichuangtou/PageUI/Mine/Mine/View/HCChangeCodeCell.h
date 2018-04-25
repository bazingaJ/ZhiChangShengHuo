//
//  HCChangeCodeCell.h
//  huilichuangtou
//
//  Created by yunduopu-ios-2 on 2018/4/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCChangeCodeCell : UITableViewCell

/**
 cell1
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
@property (weak, nonatomic) IBOutlet UITextField *contentTF1;

/**
 cell2
 */
@property (weak, nonatomic) IBOutlet UITextField *contentTF2;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@end
