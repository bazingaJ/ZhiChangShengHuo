//
//  KSearchView.h
//  Kivii
//
//  Created by 相约在冬季 on 2017/8/14.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapActionBlock)(NSString *str);
@interface KSearchView : UIView

@property (nonatomic, copy) TapActionBlock tapAction;

- (id)initWithFrame:(CGRect)frame hotArr:(NSMutableArray *)hotArr historyArr:(NSMutableArray *)historyArr;

@end
