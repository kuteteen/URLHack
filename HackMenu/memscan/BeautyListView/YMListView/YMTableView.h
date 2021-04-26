//
//  YMTableView.h
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMListViewConfig.h"
#import "YMListViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMTableViewConfig : YMListViewConfig
@property (nonatomic,  assign) CGFloat  rowHeight;                  // 行高
@property (nonatomic,  assign) CGFloat  sectionHeaderHeight;        // 组头高
@property (nonatomic,  assign) CGFloat  sectionFooterHeight;        // 组尾高
@end

@interface YMTableView : UIView<UITableViewDelegate,UITableViewDataSource,YMListViewProtocol>

@property (nonatomic,  strong) UITableView *tableView;
@property (nonatomic,  strong) NSMutableArray *dataArray;

@property (nonatomic,  strong,  readonly) YMTableViewConfig *config;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame config:(__kindof YMTableViewConfig *)config NS_DESIGNATED_INITIALIZER;
- (double)dataArraycount;
@end

NS_ASSUME_NONNULL_END
