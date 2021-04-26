#import <Foundation/Foundation.h>
//全局配置BSPHP
//下面信息通过软件后台>软件>对应软件设置上获得
//全局服务器地址
#define  LD_API  @"0CNDJZhaOLhkH6B4ZsSGqrLmgXguLO7UxvBBJqPIwjk3yzw+N9wg6TOWsGScNuA5t8v8LNgoC8yCh8huK6C3H6cqkVJfEaH2Xb8D+QvLNn0="

//通信key
#define LD_KEY @"MTrMTukoBlK0fIjUz/HFDPAbmHX9Z1mfWoToR8DWJzuUl8XiUOCphw=="

//通信密码
#define LD_APIPASS @"Hg25uiTdETvoheGy1f6Uf+Y0fOX165ZF"
//默认无修改
#define LD_AAAA @"123456781234567812345678"
//远程菜单
//QQ飞飞车pqrGPtGQWD46tXNw0D/F5T0AhXHudnKfH0VQ5tMgsyU9MEjXAMKKCA==
//王者pqrGPtGQWD46tXNw0D/F5T0AhXHudnKfx8SpJ05NV2xi+eupx7CFnO1JTJeqmJOY
#define LD_URL @"pqrGPtGQWD46tXNw0D/F5T0AhXHudnKfx8SpJ05NV2xi+eupx7CFnO1JTJeqmJOY"
//签名in进认证
#define LD_IN @"WuPGcbaGD6Wm/ke9206Kbg=="
//签名to本地认证
#define LD_TO @"WuPGcbaGD6Wm/ke9206Kbg=="

#define LD_VERSION @"UkbNLorRmb8="
//图标地址
#define ICON @"http://8.136.104.148/ZQQ.jpg"
//几秒显示图标
#define TIME 10
//开关大小
#define ANNIU 0.95
//图标大小
#define ICONDX 40
//菜单地址
#define CDURL @"https://iosgods.cn/cj.json";
@interface NetTool : NSObject

/**
 *  AFN异步发送post请求，返回原生数据
 *
 *  @param appendURL 追加URL
 *  @param param     参数字典
 *  @param success   成功Block
 *  @param failure   失败Block
 *
 *  @return NSURLSessionDataTask任务类型
 */
+ (NSURLSessionDataTask *)__attribute__((optnone))Post_AppendURL:(NSString *)appendURL myparameters:(NSDictionary *)param mysuccess:(void (^)(id responseObject))success myfailure:(void (^)(NSError *error))failure;
@end
