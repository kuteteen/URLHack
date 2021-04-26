
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ESPDataFetchDataBlock)(NSArray *data, NSArray *hpData, NSArray *disData,NSArray *nameData,NSArray *data1,NSArray *data2,NSArray *data3,NSArray *data4,NSArray *data5,NSArray *data6,NSArray *data7,NSArray *data8);
//NSArray *nameData,NSArray *rjData,NSArray *dwidData);
@interface ESPData : NSObject

+ (instancetype)data;

- (void)fetchData:(ESPDataFetchDataBlock)block;

@end

NS_ASSUME_NONNULL_END
