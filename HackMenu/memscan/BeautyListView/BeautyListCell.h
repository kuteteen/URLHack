//
//  BeautyListCell.h
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BeautyListModel;

@interface BeautyListCell : UITableViewCell

@property (nonatomic,  strong) BeautyListModel *model;

+ (CGFloat)cellWidth;
+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
