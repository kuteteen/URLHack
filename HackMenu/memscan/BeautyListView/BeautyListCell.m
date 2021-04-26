//
//  BeautyListCell.m
//  BeautyList
//
//  Created by 李良林 on 2020/12/6.
//  Copyright © 2020 李良林. All rights reserved.
//

#import "BeautyListCell.h"
#import "BeautyListModel.h"
#import "Config.h"
@interface BeautyListCell()
@property (nonatomic,  strong) UILabel *titleLabel;
@property (nonatomic,  strong) UISwitch *swit;
@property (nonatomic,  strong) UISwitch *swit2;
@property (nonatomic,  strong) UISlider *slider;
@property (nonatomic,  strong) UIButton *button;
@end

@implementation BeautyListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        
        [self setupViews];
    }
    return self;
}

#pragma mark -------------------------------------视图-------------------------------------------

- (void)setupViews
{
    // 添加自定义视图
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark -------------------------------------事件-------------------------------------------

+ (CGFloat)cellHeight
{
    return 50;
}

+ (CGFloat)cellWidth
{
    return 250;
}

- (void)setModel:(BeautyListModel *)model
{
    _model = model;
    
    self.textLabel.text = model.title;
    
    if (model.Style == 1) {
        self.accessoryView = self.swit;
        self.swit.on = model.open;
        [self.swit setOn:model.open animated:YES];
    }
}

- (void)switChange:(UISwitch *)swit
{
    _model.open = swit.isOn;
    [BeautyListModel handleEvent:_model.title open:_model.open];
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UISwitch *)swit{
    if (!_swit) {
        _swit = [[UISwitch alloc] init];
        _swit.transform = CGAffineTransformMakeScale(ANNIU,ANNIU);
        [_swit addTarget:self action:@selector(switChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _swit;
}

@end
