//
//  ViewController.m
//  Code
//
//  Created by 佚名 on 2020/10/15.
//  Copyright © 2020 佚名. All rights reserved.
//

#import "ViewController.h"
#import "YMDragView.h"
#import "BeautyLisController.h"
#import "Config.h"
@interface ViewController ()
@property (nonatomic, strong) BeautyLisController *vna;
@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

static BOOL MenDeal;
static ViewController *extraInfo;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TIME* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        extraInfo =  [ViewController new];
        [extraInfo tapIconView];
        [extraInfo initTapGes];
    });
}
-(void)initTapGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 2; // 点击次数
    tap.numberOfTouchesRequired = 3; // 手指数
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController.view addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapIconView)];
}
-(void)tapIconView
{
    NSString *deviceName=[[UIDevice currentDevice]name];
    YMDragView *view = [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController.view viewWithTag:100];
    if (!view) {
        view = [[YMDragView alloc] init];
        view.tag = 100;
        
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController.view addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onConsoleButtonTapped:)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
    }
    
    if (!MenDeal) {
        // 显示
        view.hidden = NO;
      
    } else {
        // 显示
        view.hidden = YES;
    
    }
    
    MenDeal = !MenDeal;
}
-(void)onConsoleButtonTapped:(id)sender
{
    if (!_vna) {
        BeautyLisController *vc = [[BeautyLisController alloc] init];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        _vna = vc;
    }
    UIViewController *vc = [[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController;
    [vc presentViewController:_vna animated:YES completion:nil];
}



@end
