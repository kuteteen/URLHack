//
//  BeautyListView.m
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import "BeautyListView.h"
#import "BeautyListModel.h"
#import "Config.h"
@interface BeautyListView()
@property (nonatomic,  strong) UIVisualEffectView *blurView;
@property (nonatomic,  strong) UILabel *label;
@property (nonatomic,  assign) CGPoint  point;
@property (nonatomic,  assign) double *count;
@end

@implementation BeautyListView

#pragma mark -------------------------------------视图-------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame config:(YMTableViewConfig *)config
{
    self = [super initWithFrame:frame config:config];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.tableFooterView = self.label;
        //self.tableView.scrollEnabled = NO;
        //self.tableView.separatorInset = UIEdgeInsetsZero;
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(20, 10, 20, 10)];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutManager:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsMake(20, 10, 20, 10)];
        }
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.blurView];
        [self sendSubviewToBack:self.blurView];
        
        [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
        
        [self setupData];
    }
    return self;
}

- (UIVisualEffectView *)blurView{
    if (!_blurView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = self.bounds;
        _blurView = blurView;
        
        blurView.layer.mask = ({
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:blurView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            layer;
        });
    }
    return _blurView;
}

- (void)setupData
{
    //解析服务器版本
    NSError *error;
    NSString *txturl = CDURL;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:txturl]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSString *gongneng = [json objectForKey:@"功能菜单"];
    NSArray *array = [gongneng componentsSeparatedByString:@","];
    //主标题
    _title = [json objectForKey:@"主标题"];
   
    
NSArray*opens=@[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    
    for (NSInteger i = 0; i < array.count; i++) {
        BeautyListModel *model = [[BeautyListModel alloc] init];
        model.title = array[i];
        model.Style = [opens[i] integerValue];
        [self.dataArray addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /// 单点击
    BeautyListModel *model = self.dataArray[indexPath.row];
    if ([model.title isEqualToString:@"1"]) {
        
        // 提醒事
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!view) {
        self.layer.borderColor = [[UIColor whiteColor] CGColor];//描边颜色
        self.layer.borderWidth = 0.05f;//描边粗细
        self.backgroundColor = [UIColor clearColor];//背景颜色
        self.alpha = 50.0f;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 10;
        
        self.alpha = 50.0f;
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        view.tintColor= [UIColor greenColor];
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
        view.textLabel.text = _title;
        [view.textLabel setTextColor:[UIColor whiteColor]];
    }
    
    return view;
}

- (void)panAction:(UIGestureRecognizer *)gesture
{
    CGPoint p = [gesture locationInView:gesture.view];
    self.center = CGPointMake(self.center.x + p.x - self.bounds.size.width * 0.5, self.center.y + p.y - self.bounds.size.height * 0.5);
}

- (UILabel *)label{
    if (!_label) {
        //解析服务器版本
        NSError *error;
        NSString *txturl = CDURL;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:txturl]];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        _futitle = [json objectForKey:@"副标题"];
        UILabel *label = [[UILabel alloc] init];
        
        label.text = [NSString stringWithFormat:@"%@", _futitle];
        label.textColor = [UIColor greenColor];//字体颜色greenColor绿色whiteColor白色 其他颜色百度
        label.font = [UIFont systemFontOfSize:15];//字体大小
        [label sizeToFit];
        label.center = self.tableView.center;
        
        _label = label;
    }
    return _label;
}



@end
