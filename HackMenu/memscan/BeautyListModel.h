//
//  BeautyListModel.h
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeautyListModel : NSObject
@property (nonatomic,  copy) NSString *title;

/// 1 - Switch
@property (nonatomic,  assign) NSInteger  Style;
@property (nonatomic,  assign) BOOL  open;
@property (nonatomic,  assign) NSInteger  slider;
@property (nonatomic, retain) NSString *myName;

///
+ (void)handleEvent:(NSString *)title open:(BOOL)open;

@end

NS_ASSUME_NONNULL_END
