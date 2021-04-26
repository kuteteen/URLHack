#import "LRKeychain.h"
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <AVFoundation/AVFoundation.h>
#import <AdSupport/ASIdentifierManager.h>
#import "CaptainHook.h"
#import "defines.h"
#import "MF_Base64Additions.h"
#import "NSDictionary+StichingStringkeyValue.h"
#import "NSString+MD5.h"
#import "NSString+URLCode.h"
#import "UserInfoManager.h"
#import "Config.h"
#import "DES3Utill.h"
#import "UIAlertView+Blocks.h"
#import <Foundation/Foundation.h>
#import "SCLAlertView.h"
#import "Gongneng.h"

@interface VerifyEntry ()<UIAlertViewDelegate>
@property (nonatomic, strong) dispatch_source_t timer;//  注意:此处应该使用强引用strong

@property (nonatomic, assign) long num;
@end
#pragma mark BSPHP功能
@implementation VerifyEntry

+ (instancetype)MySharedInstance
{
    static VerifyEntry *sharedSingleton;
    
    if (!sharedSingleton)
    {
        static dispatch_once_t oncePPM;
        dispatch_once(&oncePPM, ^
                      {
                          sharedSingleton = [[VerifyEntry alloc] init];
                      });
    }
    
    return sharedSingleton;
}

- (NSString*)getIDFA
{
    ASIdentifierManager *as = [ASIdentifierManager sharedManager];
    return as.advertisingIdentifier.UUIDString;
}

- (void)showAlertMsg:(NSString *)show error:(BOOL)error
{
    
    DisPatchGetMainQueueBegin();
    SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
    if (error) {
        [alert showError:@"" subTitle:show closeButtonTitle:@"确定" duration:2];
    }else{
        [alert showWarning:show subTitle:@"信息" closeButtonTitle:@"确定" duration:2];
        
    }
    DisPatchGetMainQueueEnd();
}

- (void)startProcessActivateProcess:(NSString *)code finish:(void (^)(NSDictionary *done))finish
{
    
    
    
    NSString * strmutualkey = NULL;
    strmutualkey  = [DES3Utill decrypt:LD_KEY gkey:LD_AAAA];
    
    NSString * strhost = NULL;
    strhost  = [DES3Utill decrypt:LD_API gkey:LD_AAAA];
    
    
    
    //授权码验证
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"api"] = @"login.ic";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    param[@"BSphpSeSsL"] = [dateStr MD5Digest];
    NSDate *date = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * nowDate = [date dateByAddingTimeInterval:interval];
    NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
    param[@"date"] = nowDateStr;
    param[@"md5"] = @"";
    param[@"mutualkey"] = strmutualkey;
    param[@"icid"] = code;
    param[@"icpwd"] = @"";
    param[@"key"] = [self getIDFA];
    param[@"maxoror"] = [self getIDFA];
    
    [NetTool Post_AppendURL:strhost myparameters:param mysuccess:^(id responseObject)
        {
          
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if(!dict){
                exit(0);//没数据 直接闪退 不用复制机器码码
            }
            if (dict)
            {
                NSString *dataString = dict[@"response"][@"data"];
                NSRange range = [dataString rangeOfString:@"|1081|"];
                if(![dataString containsString:[self getIDFA]]){
                    [self showAlertMsg:@"授权失败,请购买授权码" error:YES];
                    [self processActivate];
                }
                else if (range.location != NSNotFound)
                {
                    NSString *activationDID = [[NSUserDefaults standardUserDefaults]objectForKey:@"activationDeviceID"];
                    if (![activationDID isEqualToString:code])
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"activationDeviceID"];
                    }
                    
                    UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
                    NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                    if (arr.count >= 6)
                    {
                        manager.state01 = arr[0];
                        manager.state1081 = arr[1];
                        manager.deviceID = arr[2];
                        manager.returnData = arr[3];
                        manager.expirationTime = arr[4];
                        manager.activationTime = arr[5];
                        
                        DisPatchGetMainQueueBegin();
                        
                        NSString *showMsg = [NSString stringWithFormat:@"  授权成功，到期时间： %@", arr[4]];
                        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                        [alert addTimerToButtonIndex:0 reverse:YES];
                        [alert addButton:@"确定" actionBlock:^{
                            
                            [NSObject Banben321];
                            [NSObject Ding];
                        }];
                        [alert showWarning:@"验证成功" subTitle:showMsg closeButtonTitle:nil duration:0.0f];
                    
                        DisPatchGetMainQueueEnd();
                    }
                }
                else
                {
                    NSString *messageStr = dict[@"response"][@"data"];
                    UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
                    manager.state01 = nil;
                    manager.state1081 = nil;
                    manager.deviceID = nil;
                    manager.returnData = nil;
                    manager.expirationTime = nil;
                    manager.activationTime = nil;
                    [self showAlertMsg:messageStr error:YES];
                    [self processActivate];
                }
            }
        } myfailure:^(NSError *error)
        {
            [self processActivate];
        }];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *CONFIRM = @"授权";
    
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if (YES == [btnTitle isEqualToString:CONFIRM])
    {
        UITextField *tf = [alertView textFieldAtIndex:0];
        if (nil == tf.text || 0 == tf.text.length)
        {
            [self processActivate];
            return ;
        }
        
        [self startProcessActivateProcess:tf.text finish:nil];
    }
    else
    {
        [self processActivate];
    }
}

- (void)processActivate
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (![UserInfoManager shareUserInfoManager].deviceID) {
                exit(0);
            }
        });
    });
    SCLAlertView *alert =  [[SCLAlertView alloc] initWithNewWindow];
    alert.shouldDismissOnTapOutside = NO;
    SCLTextView *textF =   [alert addTextField:@"请在30秒内填写授权码"setDefaultText:nil];
    [alert alertDismissAnimationIsCompleted:^{
        if (textF.text.length==0) {
            [self processActivate];
        }else{
        [self startProcessActivateProcess:textF.text finish:nil];
        }
    }];
    [alert addButton:@"自助购买" actionBlock:^{
        //
        NSString *urlStr = [NSString stringWithFormat:@"http://zuiqing.z74d.cn"];[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        exit(0);
    }];
    [alert showSuccess:@"授权" subTitle:@"请输入您的授权码" closeButtonTitle:@"授权" duration:30];
    
}

@end
#pragma mark  BS验证流程
@implementation NSObject (hook)

- (BOOL)Bsphp
{
    NSString * strmutualkey = NULL;
    strmutualkey  = [DES3Utill decrypt:LD_KEY gkey:LD_AAAA];
    NSString * strhost = NULL;
    strhost  = [DES3Utill decrypt:LD_API gkey:LD_AAAA];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       if([[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"] != nil)
                       {
                           NSMutableDictionary *param = [NSMutableDictionary dictionary];
                           param[@"api"] = @"login.ic";
                           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                           [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
                           NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
                           param[@"BSphpSeSsL"] = [dateStr MD5Digest];
                           NSDate *date = [NSDate date];
                           NSTimeZone * zone = [NSTimeZone systemTimeZone];
                           NSInteger interval = [zone secondsFromGMTForDate:date];
                           NSDate * nowDate = [date dateByAddingTimeInterval:interval];
                           NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
                           param[@"date"] = nowDateStr;
                           param[@"md5"] = @"";
                           param[@"mutualkey"] = strmutualkey;
                           param[@"icid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"];
                           param[@"icpwd"] = @"";
                           param[@"key"] = [[VerifyEntry MySharedInstance] getIDFA];
                           param[@"maxoror"] = [[VerifyEntry MySharedInstance] getIDFA];
                           [NetTool Post_AppendURL:strhost myparameters:param mysuccess:^(id responseObject)
                            {
                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                     options:NSJSONReadingMutableContainers
                                                                                       error:nil];
                                if (dict)
                                {
                                    NSString *dataString = dict[@"response"][@"data"];
                                    NSRange range = [dataString rangeOfString:@"|1081|"];
                                         
                                    
                                    if (range.location != NSNotFound)
                                    {
                                        UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
                                        NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                                        
                                        
                                        {
                                            manager.state01 = arr[0];
                                            manager.state1081 = arr[1];
                                            manager.deviceID = arr[2];
                                            manager.returnData = arr[3];
                                            manager.expirationTime = arr[4];
                                            manager.activationTime = arr[5];
                                            
                                           
                                            if(manager.deviceID != [[VerifyEntry MySharedInstance] getIDFA])
                                            {
                                                
                                                
                                                manager.state01 = nil;
                                                manager.state1081 = nil;
                                                manager.deviceID = nil;
                                                manager.returnData = nil;
                                                manager.expirationTime = nil;
                                                manager.activationTime = nil;
                                                //已经有卡密没到期
                                                
                                                DisPatchGetMainQueueBegin();
                                                NSString *showMsg = [NSString stringWithFormat:@"过期时间: %@", arr[4]];
                                                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                                [alert addTimerToButtonIndex:0 reverse:YES];
                                                [alert addButton:@"确定" actionBlock:^{
                                                    
                                                    [NSObject Banben321];
                                                    [NSObject Ding];
                                                }];
                                                [alert showWarning:@"验证成功" subTitle:showMsg closeButtonTitle:nil duration:0.0f];
                                                DisPatchGetMainQueueEnd();
                                                
                                                
                                            }
                                        }
                                    }
                                    else
                                    {
                                        UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
                                        manager.state01 = nil;
                                        manager.state1081 = nil;
                                        manager.deviceID = nil;
                                        manager.returnData = nil;
                                        manager.expirationTime = nil;
                                        manager.activationTime = nil;
                                        
                                        //到期返回激活
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                                       {
                                                           [[VerifyEntry MySharedInstance] processActivate];
                                            
                                                       });
                                    }
                                }
                            } myfailure:^(NSError *error)
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                               {
                                                   [[VerifyEntry MySharedInstance] processActivate];
                                               });
                            }];
                       }
                       else
                       {
                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                          {
                                              [[VerifyEntry MySharedInstance] processActivate];
                              
                                          });
                       }
                   });
    return 0;
}
- (BOOL)Ding
{
    NSString * strmutualkey = NULL;
    strmutualkey  = [DES3Utill decrypt:LD_KEY gkey:LD_AAAA];
    NSString * strhost = NULL;
    strhost  = [DES3Utill decrypt:LD_API gkey:LD_AAAA];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       if([[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"] != nil)
                       {
                           NSMutableDictionary *param = [NSMutableDictionary dictionary];
                           param[@"api"] = @"login.ic";
                           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                           [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
                           NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
                           param[@"BSphpSeSsL"] = [dateStr MD5Digest];
                           NSDate *date = [NSDate date];
                           NSTimeZone * zone = [NSTimeZone systemTimeZone];
                           NSInteger interval = [zone secondsFromGMTForDate:date];
                           NSDate * nowDate = [date dateByAddingTimeInterval:interval];
                           NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
                           param[@"date"] = nowDateStr;
                           param[@"md5"] = @"";
                           param[@"mutualkey"] = strmutualkey;
                           param[@"icid"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"activationDeviceID"];
                           param[@"icpwd"] = @"";
                           param[@"key"] = [[VerifyEntry MySharedInstance] getIDFA];
                           param[@"maxoror"] = [[VerifyEntry MySharedInstance] getIDFA];
                           [NetTool Post_AppendURL:strhost myparameters:param mysuccess:^(id responseObject)
                            {
                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                     options:NSJSONReadingMutableContainers
                                                                                       error:nil];
                                if (dict)
                                {
                                    NSString *dataString = dict[@"response"][@"data"];
                                    NSRange range = [dataString rangeOfString:@"|1081|"];
                                         
                                    
                                    if (range.location != NSNotFound)
                                    {
                                        UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
                                        NSArray *arr = [dataString componentsSeparatedByString:@"|"];
                                        
                                        
                                        {
                                            manager.state01 = arr[0];
                                            manager.state1081 = arr[1];
                                            manager.deviceID = arr[2];
                                            manager.returnData = arr[3];
                                            manager.expirationTime = arr[4];
                                            manager.activationTime = arr[5];
                                            
                                           
                                            if(manager.deviceID != [[VerifyEntry MySharedInstance] getIDFA])
                                            {
                                                
                                                
                                                manager.state01 = nil;
                                                manager.state1081 = nil;
                                                manager.deviceID = nil;
                                                manager.returnData = nil;
                                                manager.expirationTime = nil;
                                                manager.activationTime = nil;
                                                //已经有卡密没到期
                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                    [self Ding];
                                                });
                                                
                                                
                                                
                                            }
                                        }
                                    }
                                    else
                                    {
                                        UserInfoManager *manager =   [UserInfoManager shareUserInfoManager];
                                        manager.state01 = nil;
                                        manager.state1081 = nil;
                                        manager.deviceID = nil;
                                        manager.returnData = nil;
                                        manager.expirationTime = nil;
                                        manager.activationTime = nil;
                                        //到期返回激活
                                        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                        [alert addTimerToButtonIndex:0 reverse:YES];
                                        [alert addButton:@"前往购买" actionBlock:^{
                                            //到期前10秒提示去续费
                                            NSString *urlStr = [NSString stringWithFormat:@"https://iospubg.cn/发卡网"];[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                                            
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                //10秒后到期游戏闪退
                                                exit(0);
                                            });
                                        }];
                                        [alert showWarning:@"温馨提示" subTitle:@"到期🈚️法使用！㊗️您天天开心用卡愉快！" closeButtonTitle:@"确定" duration:10.0f];
                                        //关闭提示后20秒也闪退 防止关闭提示接着用
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            exit(0);
                                        });
                                        
                                        //结束提示
                                                       
                                    }
                                }
                            } myfailure:^(NSError *error)
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                               {
                                                   [[VerifyEntry MySharedInstance] processActivate];
                                    
                                               });
                            }];
                       }
                       else
                       {
                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                          {
                                              [[VerifyEntry MySharedInstance] processActivate];
                              
                              
                                          });
                       }
                   });
    return 0;
}
//检测是否开启了VPN否则终止进程
- (BOOL)Banben321{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [NSObject VPNtishitiao];//代理检测
        NSString * strmutualkey = NULL;
        strmutualkey  = [DES3Utill decrypt:LD_KEY gkey:LD_AAAA];
        NSString * strhost = NULL;
        strhost  = [DES3Utill decrypt:LD_API gkey:LD_AAAA];
        NSString * version = NULL;
        version  = [DES3Utill decrypt:LD_VERSION gkey:LD_AAAA];
        NSString *localv = version;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"api"] =@"v.in";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
        param[@"BSphpSeSsL"] = [dateStr MD5Digest];
        NSDate *date = [NSDate date];
        NSTimeZone * zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        NSDate * nowDate = [date dateByAddingTimeInterval:interval];
        NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
        param[@"date"] = nowDateStr;
        param[@"md5"] = @"";
        param[@"mutualkey"] = strmutualkey;
        //开始检测版本
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [NetTool Post_AppendURL:strhost myparameters:param mysuccess:^(id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (dict) {
                    NSString *version = dict[@"response"][@"data"];
                    BOOL result = [version isEqualToString:localv];
                    if (result) {
                        //版本通过检测获取公告
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                                       {
                                           NSMutableDictionary *param = [NSMutableDictionary dictionary];
                                           param[@"api"] = @"gg.in";
                                           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                                           [dateFormatter setDateFormat:@"yyyy-MM-dd#HH:mm:ss"];
                                           NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
                                           param[@"BSphpSeSsL"] = [dateStr MD5Digest];
                                           NSDate *date = [NSDate date];
                                           NSTimeZone * zone = [NSTimeZone systemTimeZone];
                                           NSInteger interval = [zone secondsFromGMTForDate:date];
                                           NSDate * nowDate = [date dateByAddingTimeInterval:interval];
                                           NSString *nowDateStr = [[nowDate description] stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
                                           param[@"date"] = nowDateStr;
                                           param[@"md5"] = @"";
                                           param[@"mutualkey"] = strmutualkey;
                                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                              
                                               [NetTool Post_AppendURL:strhost myparameters:param mysuccess:^(id responseObject) {
                                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                                   if (dict) {
                                                       NSString *message = dict[@"response"][@"data"];
                                                       if ([message rangeOfString:@"NULL"].location == NSNotFound)
                                                       {
                                                           SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                                           [alert addTimerToButtonIndex:0 reverse:YES];
                                                           alert.horizontalButtons = YES;
                                                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                                           {
                                                               SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                                               [alert addTimerToButtonIndex:0 reverse:YES];
                                                               alert.horizontalButtons = YES;
                                                               [alert showWarning:@"公告" subTitle:message closeButtonTitle:@"关闭" duration:10];
                                                               
                                                           }
                                                                          );}
                                                        
                                                      
                                                   }
                                               } myfailure:^(NSError *error) {
                                                   SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                                   [alert addTimerToButtonIndex:0 reverse:YES];
                                                   [alert showWarning:@"温馨提示" subTitle:(@"公告信息获取失败!") closeButtonTitle:@"确定" duration:0.0f];
                                               }];
                                           });
                                       });
                    }else{
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                        [alert addTimerToButtonIndex:0 reverse:YES];
                        alert.horizontalButtons = YES;
                        // 拒绝按钮
                        [alert addButton:@"残忍拒绝" actionBlock:^{
                            exit(0);
                        }];
                           
                        // 下载按钮
                        [alert addButton:@"前往下载" actionBlock:^{
                            //
                            NSString *urlStr = [NSString stringWithFormat:@"https://iospubg.cn/wzry.html"];[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                            exit(0);
                        }];
                        [alert showWarning:@"发现新版本" subTitle:@"当前版本已过期,请及时更新版本！" closeButtonTitle:nil duration:0.0f];
                        //以下为不提示拒绝和下载按钮
                        /*[alert showWarning:@"温馨提示" subTitle:(@"当前版本已过期,请及时更新版本！") closeButtonTitle:nil duration:0.0f]; // Warning
                         //结束进程
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         exit(0);
                         });*/
                     });
                    }
                }
            } myfailure:^(NSError *error) {
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert addButton:@"退出倒计时" actionBlock:^{
                    exit(0);
                }];
                [alert showWarning:@"温馨提示" subTitle:(@"网络连接失败！请重启应用！") closeButtonTitle:nil duration:10];
            }];
        });
    });
    NSLog(@"未检测到代理");
    return NO;
}

//在验证处开启VPN检测、有提示条
- (BOOL)VPNtishitiao{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSLog(@"\n%@",proxies);
    
    NSDictionary *settings = proxies[0];
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        NSLog(@"未检测到代理");
        return NO;
    }
    else
    {
        [self showMessage:[NSString stringWithFormat:@"检测到您开启了vpn,请关闭..."] duration:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    exit(0);
        });
        NSLog(@"检测到代理");
        return YES;
    }
}
//在验证处开启VPN检测、直接给予闪退
- (BOOL)VPNzhijiesantui{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSLog(@"\n%@",proxies);
    
    NSDictionary *settings = proxies[0];
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        NSLog(@"未检测到代理");
        return NO;
    }
    else
    {
        exit(0);
        
        return YES;
    }
}

#pragma mark  提示条
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blueColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(207, 999)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes context:nil].size;
    
    label.frame = CGRectMake(10, 5, labelSize.width +20, labelSize.height);
    label.text = message;
    label.textColor = [UIColor redColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor blueColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    
    showview.frame = CGRectMake((screenSize.width - labelSize.width - 20)/2,
                                screenSize.height - 300,
                                labelSize.width+40,
                                labelSize.height+10);
    [UIView animateWithDuration:time animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}
@end



