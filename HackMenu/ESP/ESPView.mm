#import <Foundation/Foundation.h>
#import "ESPView.h"
#import "ESP.h"
#import "CaptainHook.h"
#import "SCLAlertView.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define kTest   0
#define g 0.86602540378444


@interface ESPView()
@property (nonatomic,  strong) UILabel *numberLabel;
@property (nonatomic,  strong) CAShapeLayer *drawLayer;
@property (nonatomic,  strong) CAShapeLayer *hpLayer;
@property (nonatomic,  strong) CAShapeLayer *disLayer;
@property (nonatomic,  strong) CAShapeLayer *wjLayer;
@property (nonatomic,  strong) NSArray *rects;
@property (nonatomic,  strong) NSArray *hpData;
@property (nonatomic,  strong) NSArray *disData;
@property (nonatomic,  strong) NSArray *data1;
@property (nonatomic,  strong) NSArray *data2;
@property (nonatomic,  strong) NSArray *data3;
@property (nonatomic,  strong) NSArray *data4;
@property (nonatomic,  strong) NSArray *data5;
@property (nonatomic,  strong) NSArray *data6;
@property (nonatomic,  strong) NSArray *data7;
@property (nonatomic,  strong) NSArray *data8;
@property (nonatomic,  strong) NSArray *nameData;
@property (nonatomic,  weak) NSTimer *timer;
@property (nonatomic, copy) NSString *Name;
@end
static CATextLayer *mzLabel[100];//名字+距离
CGRect rect ;
CGFloat xue;
CGFloat dis ;
BOOL kaiguan = NO;
BOOL kaiguan1 = YES;
BOOL kaiguan2 = YES;
BOOL kaiguan3 = YES;
BOOL kaiguan4 = YES;
BOOL kaiguan5 = YES;
BOOL kaiguan6 = YES;



//UIButton *closeButton;
//UIView *menuView;
//UIButton *menuButton;
//UIButton *menuButton

@implementation ESPView
#pragma mark -------------------------------------视图-------------------------------------------

+ (void)load1
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         ESPView *view = [ESPView DrawView];
        [view show];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:view];
    });
}
+ (instancetype)DrawView
{
    return [[ESPView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self.layer addSublayer:self.drawLayer];
        [self.layer addSublayer:self.hpLayer];
        [self.layer addSublayer:self.disLayer];
        [self.layer addSublayer:self.wjLayer];
        [self addSubview:self.numberLabel];
        for (NSInteger i = 0; i < 100; i++) {

      NSMutableDictionary*newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];

            //名字+距离
            mzLabel[i] = [CATextLayer layer];
            mzLabel[i].actions = newActions;
            mzLabel[i].string = @"";
            mzLabel[i].bounds = CGRectMake(0, 0, 300, 30);//160
            mzLabel[i].fontSize = 9;//字体的大小
            mzLabel[i].wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
            mzLabel[i].alignmentMode = kCAAlignmentCenter;//字体的对齐方式
            //mzLabel[i].foregroundColor =[UIColor whiteColor].CGColor;
            mzLabel[i].position = CGPointMake(-100, -100);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
            mzLabel[i].contentsScale = [UIScreen mainScreen].scale;//解决文字模糊
            [self.layer addSublayer:mzLabel[i]];
}
    }
    return self;
}

#pragma mark -------------------------------------事件-------------------------------------------


- (void)clear{
    
    for (NSInteger i = 0; i < 100; i++) {
        
   
        
        mzLabel[i].string = @"";
 
        
    }
}
- (void)show
{
    self.hidden = NO;
    self.timer.fireDate = [NSDate distantPast];
}


- (void)hide
{
    self.hidden = YES;
    self.timer.fireDate = [NSDate distantFuture];

}


    

- (void)configWithData:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData nameData:(NSArray *)nameData data1:(NSArray *)data1  data2:(NSArray *)data2 data3:(NSArray *)data3 data4:(NSArray *)data4 data5:(NSArray *)data5 data6:(NSArray *)data6 data7:(NSArray *)data7 data8:(NSArray *)data8


{
    
    _rects = rects;
    _hpData = hpData;
    _disData = disData;
    _nameData = nameData;
    _data1 =  data1;
    _data2 =  data2;
    _data3 =  data3;
    _data4 =  data4;
    _data5 =  data5;
    _data6 =  data6;
    _data7 =  data7;
    _data8 =  data8;
   
   if(kaiguan1==YES){
    
    _numberLabel.text =  [ NSString stringWithFormat:@"附近有%d个玩家" ,(int)(_rects.count)];

}
    
    
    
    [self clear];
    [self drawAction];
  

}

- (void)drawAction
{
    
 
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *hpPath = [UIBezierPath bezierPath];
    UIBezierPath *disPath = [UIBezierPath bezierPath];
    UIBezierPath *wjPath = [UIBezierPath bezierPath];
  
    for (NSInteger i = 0; i < _rects.count; i++) {
        
        NSValue *val0  = _rects[i];
        NSNumber *val1 = _hpData[i];
        NSNumber *val2 = _disData[i];
        NSValue *d1  = _data1[i];
        NSValue *d2  = _data2[i];
        NSValue *d3  = _data3[i];
        NSValue *d4  = _data4[i];
        NSValue *d5  = _data5[i];
        NSValue *d6  = _data6[i];
        NSValue *d7  = _data7[i];
        NSValue *d8  = _data8[i];
           _Name = _nameData[i];
        
        
        CGRect rect = [val0 CGRectValue];
        CGFloat xue = [val1 floatValue];
        CGFloat dis = [val2 floatValue];
        CGRect rect1 = [d1 CGRectValue];
        CGRect rect2 = [d2 CGRectValue];
        CGRect rect3 = [d3 CGRectValue];
        CGRect rect4 = [d4 CGRectValue];
        CGRect rect5 = [d5 CGRectValue];
        CGRect rect6 = [d6 CGRectValue];
        CGRect rect7 = [d7 CGRectValue];
        CGRect rect8 = [d8 CGRectValue];
        
        
        
        CGFloat headx = rect1.origin.x/kScale;
        CGFloat heady = rect1.origin.y/kScale;
        CGFloat Spinex = rect1.size.width/kScale;
        CGFloat Spiney = rect1.size.height/kScale;
        CGFloat pelvisx = rect2.origin.x/kScale;
        CGFloat pelvisy = rect2.origin.y/kScale;
        CGFloat leftShoulderx = rect2.size.width/kScale;
        CGFloat leftShouldery = rect2.size.height/kScale;
        CGFloat leftElbowx = rect3.origin.x/kScale;
        CGFloat leftElbowy = rect3.origin.y/kScale;
        CGFloat leftHandx = rect3.size.width/kScale;
        CGFloat leftHandy = rect3.size.height/kScale;
        CGFloat rightShoulderx = rect4.origin.x/kScale;
        CGFloat rightShouldery = rect4.origin.y/kScale;
        CGFloat rightElbowx = rect4.size.width/kScale;
        CGFloat rightElbowy = rect4.size.height/kScale;
        CGFloat rightHandx = rect5.origin.x/kScale;
        CGFloat rightHandy = rect5.origin.y/kScale;
        CGFloat leftPelvisx = rect5.size.width/kScale;
        CGFloat leftPelvisy = rect5.size.height/kScale;
        CGFloat leftKneex = rect6.origin.x/kScale;
        CGFloat leftKneey = rect6.origin.y/kScale;
        CGFloat leftFootx = rect6.size.width/kScale;
        CGFloat leftFooty = rect6.size.height/kScale;
        CGFloat rightPelvisx = rect7.origin.x/kScale;
        CGFloat rightPelvisy = rect7.origin.y/kScale;
        CGFloat rightKneex = rect7.size.width/kScale;
        CGFloat rightKneey = rect7.size.height/kScale;
        CGFloat rightFootx = rect8.origin.x/kScale;
        CGFloat rightFooty = rect8.origin.y/kScale;
       
        
        
        
        float xd = rect.origin.x+rect.size.width/2;//人物X坐标
        float yd = rect.origin.y;//人物Y坐标
        
        CGFloat w = rect.size.width;
        CGFloat h = rect.size.height;
        CGFloat x = rect.origin.x;
        CGFloat y = rect.origin.y;
if(kaiguan6==YES){
        //射线
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:CGPointMake(kWidth*0.5, 52)];
        [line addLineToPoint:CGPointMake(headx, heady)];
        [path appendPath:line];
 //中间圆
        UIBezierPath *yuanPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kWidth/2,kHeight/2) radius:40 startAngle:(0) endAngle:M_PI*2 clockwise:true];

        [path appendPath:yuanPath];
    
}
        
        //名字是距离
     mzLabel[i] .position = CGPointMake(xd-5, yd-7);
     mzLabel[i] .string = [NSString stringWithFormat:@"%@[%d 米]",_Name,(int)dis];
       CGRect wjRect = CGRectMake(xd-0, yd-0,0 , 0);
       UIBezierPath *wjBz = [UIBezierPath bezierPathWithRect:wjRect];

        
//ID颜色
        [wjPath appendPath:wjBz];
if((int)dis>0&&(int)dis<=100 ){ mzLabel[i].foregroundColor =[UIColor colorWithRed: 255.00 green: 255.00 blue: 255.00 alpha: 1.00].CGColor;}
if((int)dis>100&&(int)dis<=150 ){ mzLabel[i].foregroundColor =[UIColor colorWithRed: 255.00 green: 255.00 blue: 255.00 alpha: 1.00].CGColor;}
if((int)dis>150&&(int)dis<=300 ){ mzLabel[i].foregroundColor =[UIColor colorWithRed: 255.00 green: 255.00 blue: 255.00 alpha: 1.00].CGColor;}
if((int)dis>300&&(int)dis<=400 ){ mzLabel[i].foregroundColor =[UIColor colorWithRed: 255.00 green: 255.00 blue: 255.00 alpha: 1.00].CGColor;}
//_wjLayer.fillColor =  [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.20].CGColor;


 UIBezierPath *sjx = [UIBezierPath bezierPath];
        [sjx moveToPoint:CGPointMake(xd-2, yd-2.5)];
        [sjx addLineToPoint:CGPointMake(xd+2, yd-2.5)];
        [sjx addLineToPoint:CGPointMake(xd, yd-1.75)];
        [sjx closePath];
        [disPath appendPath:sjx];
        
            
        //变色射线颜色
           if((int)dis>0&&(int)dis<=100 ){ _drawLayer.strokeColor =  [UIColor colorWithRed: 1 green: 0.00 blue: 0.00 alpha: 1.00].CGColor;};
           
            if((int)dis>100&&(int)dis<=150 ){ _drawLayer.strokeColor =  [UIColor colorWithRed: 0.00 green: 0.00 blue: 0.50 alpha: 1.00].CGColor;};
           
            if((int)dis>150&&(int)dis<=300 ){ _drawLayer.strokeColor =  [UIColor colorWithRed: 0.00 green: 0.00 blue: 1.00 alpha: 1.00].CGColor;};
           
            if((int)dis>300&&(int)dis<=350 ){ _drawLayer.strokeColor =  [UIColor colorWithRed: 0 green: 1.00 blue: 0.00 alpha: 1.00].CGColor;};
        

if(kaiguan5==YES){
    //方框
     //左上角
        UIBezierPath *line1 = [UIBezierPath bezierPath];
       [line1 moveToPoint:CGPointMake(x, y)];
        [line1 addLineToPoint:CGPointMake(x-w/2,y)];
        [path appendPath:line1];
       UIBezierPath *line2 = [UIBezierPath bezierPath];
       [line2 moveToPoint:CGPointMake(x-w/2, y)];
        [line2 addLineToPoint:CGPointMake(x-w/2, y+h/4)];
        [path appendPath:line2];
//右上角
//
      UIBezierPath *line3 = [UIBezierPath bezierPath];
        [line3 moveToPoint:CGPointMake(x+w*0.75, y)];
        [line3 addLineToPoint:CGPointMake(x+w*1.25, y)];

        [path appendPath:line3];

      UIBezierPath *line4 = [UIBezierPath bezierPath];
        [line4 moveToPoint:CGPointMake(x+w*1.25, y)];
        [line4 addLineToPoint:CGPointMake(x+w*1.25, y+h/4)];

        [path appendPath:line4];

     //左下角
        UIBezierPath *line5 = [UIBezierPath bezierPath];
       [line5 moveToPoint:CGPointMake(x, y+h+4)];
        [line5 addLineToPoint:CGPointMake(x-w/2,y+h+4)];
        [path appendPath:line5];
       UIBezierPath *line6 = [UIBezierPath bezierPath];
       [line6 moveToPoint:CGPointMake(x-w/2, y+h+4)];
        [line6 addLineToPoint:CGPointMake(x-w/2, y+(h+4)*0.75)];
        [path appendPath:line6];
//右下角

      UIBezierPath *line7 = [UIBezierPath bezierPath];
        [line7 moveToPoint:CGPointMake(x+w*0.75, y+h+4)];
        [line7 addLineToPoint:CGPointMake(x+w*1.25, y+h+4)];

        [path appendPath:line7];

      UIBezierPath *line8 = [UIBezierPath bezierPath];
        [line8 moveToPoint:CGPointMake(x+w*1.25, y+h+4)];
        [line8 addLineToPoint:CGPointMake(x+w*1.25, y+(h+4)*0.75)];

        [path appendPath:line8];
     
     
         }
    
    
    
    
 
if(kaiguan2==YES){
//骨骼
        UIBezierPath *line1 = [UIBezierPath bezierPath];
        [line1 moveToPoint:CGPointMake(headx, heady)];
        [line1 addLineToPoint:CGPointMake(Spinex, Spiney)];
        [disPath appendPath:line1];
        
        UIBezierPath *line2 = [UIBezierPath bezierPath];
        [line2 moveToPoint:CGPointMake(Spinex, Spiney)];
        [line2 addLineToPoint:CGPointMake(pelvisx, pelvisy)];
        [disPath appendPath:line2];
        
        
        UIBezierPath *line3 = [UIBezierPath bezierPath];
        [line3 moveToPoint:CGPointMake(Spinex, Spiney)];
        [line3 addLineToPoint:CGPointMake(leftShoulderx, leftShouldery)];
        [disPath appendPath:line3];
        
        UIBezierPath *line4 = [UIBezierPath bezierPath];
        [line4 moveToPoint:CGPointMake(leftShoulderx, leftShouldery)];
        [line4 addLineToPoint:CGPointMake(leftElbowx, leftElbowy)];
        [disPath appendPath:line4];
        
        UIBezierPath *line5 = [UIBezierPath bezierPath];
        [line5 moveToPoint:CGPointMake(leftElbowx, leftElbowy)];
        [line5 addLineToPoint:CGPointMake(leftHandx, leftHandy)];
        [disPath appendPath:line5];
        
        UIBezierPath *line6 = [UIBezierPath bezierPath];
        [line6 moveToPoint:CGPointMake(Spinex, Spiney)];
        [line6 addLineToPoint:CGPointMake(rightShoulderx, rightShouldery)];
        [disPath appendPath:line6];
        
        UIBezierPath *line7 = [UIBezierPath bezierPath];
        [line7 moveToPoint:CGPointMake(rightShoulderx, rightShouldery)];
        [line7 addLineToPoint:CGPointMake(rightElbowx, rightElbowy)];
        [disPath appendPath:line7];
        
        UIBezierPath *line8 = [UIBezierPath bezierPath];
        [line8 moveToPoint:CGPointMake(rightElbowx, rightElbowy)];
        [line8 addLineToPoint:CGPointMake(rightHandx, rightHandy)];
        [disPath appendPath:line8];
        
        UIBezierPath *line9 = [UIBezierPath bezierPath];
        [line9 moveToPoint:CGPointMake(pelvisx, pelvisy)];
        [line9 addLineToPoint:CGPointMake(leftPelvisx, leftPelvisy)];
        [disPath appendPath:line9];
        
        UIBezierPath *line10 = [UIBezierPath bezierPath];
        [line10 moveToPoint:CGPointMake(leftPelvisx, leftPelvisy)];
        [line10 addLineToPoint:CGPointMake(leftKneex, leftKneey)];
        [disPath appendPath:line10];
        
        UIBezierPath *line11 = [UIBezierPath bezierPath];
        [line11 moveToPoint:CGPointMake(leftKneex, leftKneey)];
        [line11 addLineToPoint:CGPointMake(leftFootx, leftFooty)];
        [disPath appendPath:line11];
        
        UIBezierPath *line12 = [UIBezierPath bezierPath];
        [line12 moveToPoint:CGPointMake(pelvisx, pelvisy)];
        [line12 addLineToPoint:CGPointMake(rightPelvisx, rightPelvisy)];
        [disPath appendPath:line12];
        
        UIBezierPath *line13 = [UIBezierPath bezierPath];
        [line13 moveToPoint:CGPointMake(rightPelvisx, rightPelvisy)];
        [line13 addLineToPoint:CGPointMake(rightKneex, rightKneey)];
        [disPath appendPath:line13];
        
        UIBezierPath *line14 = [UIBezierPath bezierPath];
        [line14 moveToPoint:CGPointMake(rightKneex, rightKneey)];
        [line14 addLineToPoint:CGPointMake(rightFootx, rightFooty)];
        [disPath appendPath:line14];
        
}
        
        // 血量
if(kaiguan3==YES){
        //血量长短
        CGRect hpRect = CGRectMake(xd-20, yd-5, xue*0.4,  3);
        UIBezierPath *hpBz = [UIBezierPath bezierPathWithRect:hpRect];
        [hpPath appendPath:hpBz];
}
    }
    self.drawLayer.path = path.CGPath;
    self.hpLayer.path = hpPath.CGPath;
    self.disLayer.path = disPath.CGPath;
    self.wjLayer.path = wjPath.CGPath;
}//;

- (void)doTheJob
{
    //if (kaiguan==YES){
        [[ESPData data] fetchData:^(NSArray * _Nonnull data, NSArray * _Nonnull hpData, NSArray * _Nonnull disData,  NSArray * _Nonnull nameData,NSArray * _Nonnull data1, NSArray * _Nonnull data2, NSArray * _Nonnull data3, NSArray * _Nonnull data4, NSArray * _Nonnull data5, NSArray * _Nonnull data6, NSArray * _Nonnull data7, NSArray * _Nonnull data8) {
            [self configWithData:data hpData:hpData disData:disData nameData:nameData
             data1:data1 data2:data2 data3:data3 data4:data4 data5:data5 data6:data6 data7:data7 data8:data8];
        }];
    //}
}

#pragma mark -------------------------------------懒加载-----------------------------------------
//人数
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(kWidth/2-75, 20, 150, 40);
        label.text = @"iOsGoDsCn";
        label.textColor = [UIColor yellowColor];//人数颜色
        label.font = [UIFont boldSystemFontOfSize:20];
        label.shadowColor = [UIColor whiteColor];

        label.shadowOffset = CGSizeMake(0.5,1.1);
        _numberLabel = label;
    }
    return _numberLabel;
}
//射线
- (CAShapeLayer *)drawLayer{
    if (!_drawLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor yellowColor].CGColor;//射线颜色
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 1.0;//射线宽度
        _drawLayer = shapeLayer;
    }
    return _drawLayer;
}
//血量
- (CAShapeLayer *)hpLayer{
    if (!_hpLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor purpleColor].CGColor;//血量颜色
        //shapeLayer.fillColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 1.00].CGColor;
        _hpLayer = shapeLayer;
    }
    return _hpLayer;
}
//骨骼
- (CAShapeLayer *)disLayer{
    if (!_disLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor yellowColor].CGColor;//骨骼颜色
        shapeLayer.fillColor = [UIColor yellowColor].CGColor;
         shapeLayer.lineWidth = 0.5;
        _disLayer = shapeLayer;
    }
    return _disLayer;
}
//玩家框
- (CAShapeLayer *)wjLayer{
    if (!_wjLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        
        
        _wjLayer = shapeLayer;
    }
    return _wjLayer;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self doTheJob];
        }];
    }
    return _timer;
}

@end
