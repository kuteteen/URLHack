
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESPView : UIView

+ (instancetype)DrawView;

- (void)show;
- (void)hide;
- (void)clear;
- (void)configWithData:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData nameData:(NSArray *)nameData data1:(NSArray *)data1  data2:(NSArray *)data2 data3:(NSArray *)data3 data4:(NSArray *)data4 data5:(NSArray *)data5 data6:(NSArray *)data6 data7:(NSArray *)data7 data8:(NSArray *)data8;  

@end

NS_ASSUME_NONNULL_END
