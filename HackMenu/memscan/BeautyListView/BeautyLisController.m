//
//  BeautyLisController.m
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import "BeautyLisController.h"
#import "BeautyListView.h"

@interface BeautyLisController ()
@property (nonatomic,  strong) BeautyListView *listView;
@end

@implementation BeautyLisController

- (void)viewDidLoad {
    [super viewDidLoad];

    BeautyListView *listView = [[BeautyListView alloc] initWithFrame:CGRectMake(0, 0, [BeautyListCell cellWidth], 250) config:(
    {
        YMTableViewConfig *config = [[YMTableViewConfig alloc] init];
        
//        config.identity = @"花满庭";
        config.rowHeight = [BeautyListCell cellHeight];
        config.cellClass = [BeautyListCell class];
        config.modelClass = [BeautyListModel class];
        config.ctrl = self;
        
        config;
    })];
    
    listView.center = self.view.center;
    [self.view addSubview:listView];
    _listView = listView;
    
    // 消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;//点击其他地方次数消失
    [self.view addGestureRecognizer:tap];
    
}

#pragma mark - 消失
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

