//
//  HCVerticalScrollView.h
//  huilichuangtou
//
//  Created by 相约在冬季 on 2017/10/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemAdModel : NSObject

@property (nonatomic, assign) NSInteger tag1;
@property (nonatomic, strong) NSString *title1;
@property (nonatomic, assign) NSInteger tag2;
@property (nonatomic, strong) NSString *title2;

@end

@interface HintView : UIView

@property (nonatomic, copy) ItemAdModel * item;

@property (nonatomic, copy) void(^callBack)(NSInteger tIndex);

@end

@interface HCVerticalScrollView : UIView

@property (nonatomic, copy) NSArray * items;

@property (nonatomic, assign) BOOL autoscroll;
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, copy) void (^didSelectItemAtIndex)(NSUInteger index);


@end
