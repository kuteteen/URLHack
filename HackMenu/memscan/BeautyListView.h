//
//  BeautyListView.h
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import "YMTableView.h"
#import "BeautyListCell.h"
#import "BeautyListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BeautyListView : YMTableView
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *futitle;
@end

NS_ASSUME_NONNULL_END
