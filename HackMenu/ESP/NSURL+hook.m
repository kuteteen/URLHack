
#import "NSURL+hook.h"
#import <objc/runtime.h>

@implementation NSURL (hook)

+(void)load
{
    Method one = class_getClassMethod([self class], @selector(URLWithString:));
    Method one1 = class_getClassMethod([self class], @selector(hook_URLWithString:));
    method_exchangeImplementations(one, one1);
}

+(instancetype)hook_URLWithString:(NSString *)Str
{
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {

    NSString *filepath9= [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/ShadowTrackerExtra/Saved/Logs"];
    NSFileManager *fileManager9= [NSFileManager defaultManager];
    [fileManager9 removeItemAtPath:filepath9 error:nil];
            }];
    
        //域名拦截
        if ([Str containsString:@"http://cs.mbgame.gamesafe.qq.com:80"]) {
        return [NSURL hook_URLWithString:@" "];
        //头像
        }else if ([Str containsString:@"https://img.ssl.msdk.qq.com/notice/"]) {
        return [NSURL hook_URLWithString:@"http://103.45.182.104/HK.png"];
        }else if ([Str containsString:@"http://down.qq.com/jdqssy/billboard/CG010/"]) {
        return [NSURL hook_URLWithString:@"http://103.45.182.104/HK.png"];
        }else if ([Str containsString:@"gtimg.cn/"]) {
        return [NSURL hook_URLWithString:@"http://103.45.182.104/HK.png"];
        }else if ([Str containsString:@"thirdwx.qlogo.cn/"]) {
        return [NSURL hook_URLWithString:@"http://103.45.182.104/HK.png"];
        }else if ([Str containsString:@"thirdqq.qlogo.cn/"]) {
        return [NSURL hook_URLWithString:@"http://103.45.182.104/HK.png"];
        //其他
        }else if ([Str containsString:@"http://cs.mbgame.gamesafe.qq.com:443"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"jsonatm.broker.tplay.qq.com:5692"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://cs.mbgame.gamesafe.qq.com:10012"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://nggproxy.3g.qq.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"idcconfig.gcloud.qq.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"https://stat.tpns.sh.tencent.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://guid.guid.tpns.sh.tencent.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://stat.guid.tpns.sh.tencent.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"https://stat.tpns.sh.tencent.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"ttps://gpcloud.tgpa.qq.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://cloudctrl.gcloud.qq.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://ios.bugly.qq.com"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://sqlobby.pg.qq.com:17500"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://wxlobby.pg.qq.com:17500"]) {
        return [NSURL hook_URLWithString:@""];
        }else if ([Str containsString:@"http://pubgmhdprobe.tgpa.qq.com"]) {
        return [NSURL hook_URLWithString:@""];
        //主拦截
        }else if ([Str containsString:@"https://down.anticheatexpert.com/iedsafe/Client/ios/2131/config3.xml"]) {
        return [NSURL hook_URLWithString:@"http://www.6igg.com/config/config3.txt"];
        }else if ([Str containsString:@"https://down.anticheatexpert.com/iedsafe/Client/ios/2131/config2.xml"]) {
        return [NSURL hook_URLWithString:@"http://www.6igg.com/config/config2.txt"];
        }else {
        return [NSURL hook_URLWithString:Str];
    }
}

@end

