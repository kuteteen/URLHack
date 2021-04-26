//
//  YMTableView.m
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import "YMTableView.h"

@implementation YMTableViewConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellClass = [UITableViewCell class];
    }
    return self;
}
@end

@interface YMTableView()
@property (nonatomic,  strong) YMTableViewConfig *config;
@property (nonatomic,  assign) BOOL  hasLoadData;
@end

@implementation YMTableView

#pragma mark -------------------------------------视图-------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame config:(YMTableViewConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        _config = config;
        _dataArray = @[].mutableCopy;
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.tableView];
}

#pragma mark -------------------------------------事件-------------------------------------------

#pragma mark - public

#pragma mark --- 首次加载数据，只加载一次
- (void)loadData{}
- (void)refreshData{}
- (void)beginRefresh:(BOOL)isPullDown{}
- (void)endRefresh:(BOOL)isPullDown count:(NSInteger)count{}

#pragma mark --- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (double)dataArraycount
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = NSStringFromClass(_config.cellClass);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.accessibilityIdentifier = _config.identity;
    if (_config.modelClass) {
        [cell setValue:_dataArray[indexPath.row] forKey:@"model"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:0];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.backgroundColor = [UIColor whiteColor];
        _tableView = tableView;
        
        if (_config.rowHeight > 0) {
            _tableView.rowHeight = _config.rowHeight;
        }
        if (_config.sectionHeaderHeight > 0) {
            _tableView.sectionHeaderHeight = _config.sectionHeaderHeight;
        }
        if (_config.sectionFooterHeight > 0) {
            _tableView.sectionFooterHeight = _config.sectionFooterHeight;
        }
        
        NSString *ID = NSStringFromClass(_config.cellClass);
        if (_config.cellIsNib) {
            [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
        }else{
            [tableView registerClass:_config.cellClass forCellReuseIdentifier:ID];
        }
    }
    return _tableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
