//
//  KSearchSuggestionViewController.h
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuggestSelectBlock)(NSString *search);
@interface KSearchSuggestionViewController : BaseTableViewController

@property (nonatomic, copy) SuggestSelectBlock searchBlock;

- (void)searchTestChangeWithTest:(NSString *)test;

@end
