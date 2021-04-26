#import "BeautyListModel.h"
#include <JRMemory/MemScan.h>
#include "Config.h"
#include "SCLAlertView.h"
@implementation BeautyListModel


+ (void)handleEvent:(NSString *)title open:(BOOL)open
{
    //解析服务器版本
    NSError *error;
    NSString *txturl = CDURL;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:txturl]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString *name = [json objectForKey:@"功能菜单"];
    NSArray *array = [name componentsSeparatedByString:@","];
    
    
    NSArray *caidan = [json objectForKey:@"菜单"];

    for (int ii= 0 ; ii< caidan.count; ii++) {
//        NSString *gongnengdata = caidan[i];
        NSString *sousuodata = [caidan[ii] objectForKey:@"搜索"];
        NSArray *sousuo = [sousuodata componentsSeparatedByString:@","];
        
        NSString *geshidata = [caidan[ii] objectForKey:@"格式"];
        NSArray *geshi = [geshidata componentsSeparatedByString:@","];
        
        NSString *fanweidata = [caidan[ii] objectForKey:@"范围"];
        NSArray *fanwei = [fanweidata componentsSeparatedByString:@","];
        
        NSString *xiugaidata = [caidan[ii] objectForKey:@"修改"];
        NSArray *xiugai = [xiugaidata componentsSeparatedByString:@","];
        
        NSString *tiaojiandata = [caidan[ii] objectForKey:@"条件"];
        NSArray *tiaojian = [tiaojiandata componentsSeparatedByString:@","];
        
        NSString *xiugaigeshidata = [caidan[ii] objectForKey:@"修改格式"];
        NSArray *xiugaigeshi = [xiugaigeshidata componentsSeparatedByString:@","];
        
        
        if ([title isEqualToString:array[ii]]){
               if (open) {
                   
                   // 开启功能
                   dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
                   dispatch_async(queue, ^{
                       JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                        AddrRange range = (AddrRange){0x100000000,0x160000000};
                        //第一个搜索
                        if(sousuo[0]!=nil){
                            if ([geshi[0] isEqual:@"Double"]) {
                            double search = [sousuo[0] doubleValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_Double);
                                
                        }
                            else if ([geshi[0] isEqual:@"Float"]) {
                            float search = [sousuo[0] floatValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_Float);
                                
                        }
                            else if ([geshi[0] isEqual:@"I8"]) {
                            SInt8 search = [sousuo[0] intValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_SByte);
                        }
                            else if ([geshi[0] isEqual:@"I16"]) {
                            SInt16 search = [sousuo[0] intValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_SShort);
                        }
                            else if ([geshi[0] isEqual:@"I32"]) {
                            SInt32 search = [sousuo[0] intValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_SInt);
                        }
                            else if ([geshi[0] isEqual:@"I64"]) {
                            SInt64 search = [sousuo[0] longLongValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_SLong);
                        }
                            else if ([geshi[0] isEqual:@"U8"]) {
                            uint8_t search = [sousuo[0] unsignedIntValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_UByte);
                        }
                            else if ([geshi[0] isEqual:@"U16"]) {
                            uint16_t search = [sousuo[0] unsignedIntValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_UShort);
                        }
                            else if ([geshi[0] isEqual:@"U32"]) {
                            uint32_t search = [sousuo[0] unsignedIntValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
                        }
                            else if ([geshi[0] isEqual:@"U64"]) {
                            uint64_t search = [sousuo[0] unsignedLongLongValue];
                            engine.JRScanMemory(range, &search, JR_Search_Type_ULong);
                        }
                        }
                        //联合第二个搜索
                        else if(sousuo[1]!=nil){
                                if ([geshi[1] isEqual:@"Double"]) {
                                double search = [sousuo[0] doubleValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Double);
                            }
                                else if ([geshi[1] isEqual:@"Float"]) {
                                float search = [sousuo[0] floatValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Float);
                            }
                                else if ([geshi[1] isEqual:@"I8"]) {
                                SInt8 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SByte);
                            }
                                else if ([geshi[1] isEqual:@"I16"]) {
                                SInt16 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SShort);
                            }
                                else if ([geshi[1] isEqual:@"I32"]) {
                                SInt32 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SInt);
                            }
                                else if ([geshi[1] isEqual:@"I64"]) {
                                SInt64 search = [sousuo[0] longLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SLong);
                            }
                                else if ([geshi[1] isEqual:@"U8"]) {
                                uint8_t search = [sousuo[0] doubleValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UByte);
                            }
                                else if ([geshi[1] isEqual:@"U16"]) {
                                uint16_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UShort);
                            }
                                else if ([geshi[1] isEqual:@"U32"]) {
                                uint32_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UInt);
                            }
                                else if ([geshi[1] isEqual:@"U64"]) {
                                uint64_t search = [sousuo[0] unsignedLongLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_ULong);
                            }
                            }
                        //联合第三个搜索
                        else if(sousuo[2]!=nil){
                                if ([geshi[2] isEqual:@"Double"]) {
                                double search = [sousuo[0] doubleValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Double);
                            }
                                else if ([geshi[2] isEqual:@"Float"]) {
                                float search = [sousuo[0] floatValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Float);
                            }
                                else if ([geshi[2] isEqual:@"I8"]) {
                                SInt8 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SByte);
                            }
                                else if ([geshi[2] isEqual:@"I16"]) {
                                SInt16 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SShort);
                            }
                                else if ([geshi[2] isEqual:@"I32"]) {
                                SInt32 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SInt);
                            }
                                else if ([geshi[2] isEqual:@"I64"]) {
                                SInt64 search = [sousuo[0] longLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SLong);
                            }
                                else if ([geshi[2] isEqual:@"U8"]) {
                                uint8_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UByte);
                            }
                                else if ([geshi[2] isEqual:@"U16"]) {
                                uint16_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UShort);
                            }
                                else if ([geshi[2] isEqual:@"U32"]) {
                                uint32_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UInt);
                            }
                                else if ([geshi[2] isEqual:@"U64"]) {
                                uint64_t search = [sousuo[0] unsignedLongLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_ULong);
                            }
                            }
                        //联合第四个搜索
                        else if(sousuo[3]!=nil){
                                if ([geshi[3] isEqual:@"Double"]) {
                                double search = [sousuo[0] doubleValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Double);
                            }
                                else if ([geshi[3] isEqual:@"Float"]) {
                                float search = [sousuo[0] floatValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Float);
                            }
                                else if ([geshi[3] isEqual:@"I8"]) {
                                SInt8 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SByte);
                            }
                                else if ([geshi[3] isEqual:@"I16"]) {
                                SInt16 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SShort);
                            }
                                else if ([geshi[3] isEqual:@"I32"]) {
                                SInt32 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SInt);
                            }
                                else if ([geshi[3] isEqual:@"I64"]) {
                                SInt64 search = [sousuo[0] longLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SLong);
                            }
                                else if ([geshi[3] isEqual:@"U8"]) {
                                uint8_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UByte);
                            }
                                else if ([geshi[3] isEqual:@"U16"]) {
                                uint16_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UShort);
                            }
                                else if ([geshi[3] isEqual:@"U32"]) {
                                uint32_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UInt);
                            }
                                else if ([geshi[3] isEqual:@"U64"]) {
                                uint64_t search = [sousuo[0] unsignedLongLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_ULong);
                            }
                            }
                        //联合第五个搜索
                        else if(sousuo[4]!=nil){
                                if ([geshi[4] isEqual:@"Double"]) {
                                double search = [sousuo[0] doubleValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Double);
                            }
                                if ([geshi[4] isEqual:@"Float"]) {
                                float search = [sousuo[0] floatValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_Float);
                            }
                                if ([geshi[4] isEqual:@"I8"]) {
                                SInt8 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SByte);
                            }
                                if ([geshi[4] isEqual:@"I16"]) {
                                SInt16 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SShort);
                            }
                                if ([geshi[4] isEqual:@"I32"]) {
                                SInt32 search = [sousuo[0] intValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SInt);
                            }
                                if ([geshi[4] isEqual:@"I64"]) {
                                SInt64 search = [sousuo[0] longLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_SLong);
                            }
                                if ([geshi[4] isEqual:@"U8"]) {
                                uint8_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UByte);
                            }
                                if ([geshi[4] isEqual:@"U16"]) {
                                uint16_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UShort);
                            }
                                if ([geshi[4] isEqual:@"U32"]) {
                                uint32_t search = [sousuo[0] unsignedIntValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_UInt);
                            }
                                if ([geshi[4] isEqual:@"U64"]) {
                                uint64_t search = [sousuo[0] unsignedLongLongValue];
                                engine.JRNearBySearch(0x100, &search, JR_Search_Type_ULong);
                            }
                            }
                       if(sousuo.count>1){
                           //最后一个精确搜索
                           if(sousuo[sousuo.count]!=nil){
                               if ([geshi[sousuo.count] isEqual:@"Double"]) {
                               double search = [sousuo[0] doubleValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_Double);
                           }
                               if ([geshi[sousuo.count] isEqual:@"Float"]) {
                               float search = [sousuo[0] floatValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_Float);
                           }
                               if ([geshi[sousuo.count] isEqual:@"I8"]) {
                               SInt8 search = [sousuo[0] intValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_SByte);
                           }
                               if ([geshi[sousuo.count] isEqual:@"I16"]) {
                               SInt16 search = [sousuo[0] intValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_SShort);
                           }
                               if ([geshi[sousuo.count] isEqual:@"I32"]) {
                               SInt32 search = [sousuo[0] intValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_SInt);
                           }
                               if ([geshi[sousuo.count] isEqual:@"I64"]) {
                               SInt64 search = [sousuo[0] longLongValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_SLong);
                           }
                               if ([geshi[sousuo.count] isEqual:@"U8"]) {
                               uint8_t search = [sousuo[0] unsignedIntValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_UByte);
                           }
                               if ([geshi[sousuo.count] isEqual:@"U16"]) {
                               uint16_t search = [sousuo[0] unsignedIntValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_UShort);
                           }
                               if ([geshi[sousuo.count] isEqual:@"U32"]) {
                               uint32_t search = [sousuo[0] unsignedIntValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
                           }
                               if ([geshi[sousuo.count] isEqual:@"U64"]) {
                               uint64_t search = [sousuo[0] unsignedLongLongValue];
                               engine.JRScanMemory(range, &search, JR_Search_Type_ULong);
                           }
                           }
                       }
                        //最后修改
                        vector<void*>results = engine.getAllResults();
                        if(xiugaigeshi.count>1){
                            for(int i = 0;i<results.size();i++){
                                //第一个条件1全改
                                if ([xiugaigeshi[0] isEqual:@"Double"]) {
                                    double modify1 = [xiugai[0] doubleValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_Double);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"Float"]) {
                                    float modify1 = [xiugai[0] floatValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_Float);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"I8"]) {
                                    SInt8 modify1 = [xiugai[0] intValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_SByte);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"I16"]) {
                                    SInt16 modify1 = [xiugai[0] intValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_SShort);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"I32"]) {
                                    SInt32 modify1 = [xiugai[0] intValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_SInt);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"I64"]) {
                                    uint64_t modify1 = [xiugai[0] unsignedLongLongValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_SLong);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"U8"]) {
                                    uint8_t modify1 = [xiugai[0] unsignedIntValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_UByte);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"U16"]) {
                                    uint16_t modify1 = [xiugai[0] unsignedIntValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_UShort);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"U32"]) {
                                    uint32_t modify1 = [xiugai[0] unsignedIntValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_UInt);
                                }
                                else if ([xiugaigeshi[0] isEqual:@"U64"]) {
                                    uint64_t modify1 = [xiugai[0] unsignedLongLongValue];
                                    if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify1,JR_Search_Type_ULong);
                                }
                                //第一个条件2全改
                                if ([xiugaigeshi[1] isEqual:@"Double"]) {
                                    double modify2 = [xiugai[1] doubleValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_Double);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"Float"]) {
                                    float modify2 = [xiugai[1] floatValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_Float);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"I8"]) {
                                    SInt8 modify2 = [xiugai[1] unsignedIntValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_SByte);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"I16"]) {
                                    SInt16 modify2 = [xiugai[1] unsignedIntValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_SShort);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"I32"]) {
                                    SInt32 modify2 = [xiugai[1] unsignedIntValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_SInt);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"I64"]) {
                                    uint64_t modify2 = [xiugai[1] unsignedLongLongValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_SLong);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"U8"]) {
                                    uint8_t modify2 = [xiugai[1] unsignedIntValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_UByte);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"U16"]) {
                                    uint16_t modify2 = [xiugai[1] unsignedIntValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_UShort);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"U32"]) {
                                    uint32_t modify2 = [xiugai[1] unsignedIntValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_UInt);
                                }
                                else if ([xiugaigeshi[1] isEqual:@"U64"]) {
                                    uint64_t modify2 = [xiugai[1] unsignedLongLongValue];
                                    if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_ULong);
                                }
                                //第一个条件3全改
                                if ([xiugaigeshi[2] isEqual:@"Double"]) {
                                    double modify3 = [xiugai[2] doubleValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_Double);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"Float"]) {
                                    float modify3 = [xiugai[2] floatValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_Float);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"I8"]) {
                                    SInt8 modify3 = [xiugai[2] unsignedIntValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_SByte);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"I16"]) {
                                    SInt16 modify3 = [xiugai[2] unsignedIntValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_SShort);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"I32"]) {
                                    SInt32 modify3 = [xiugai[2] unsignedIntValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_SInt);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"I64"]) {
                                    uint64_t modify3 = [xiugai[2] unsignedLongLongValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_SLong);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"U8"]) {
                                    uint8_t modify3 = [xiugai[2] unsignedIntValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_UByte);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"U16"]) {
                                    uint16_t modify3 = [xiugai[2] unsignedIntValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_UShort);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"U32"]) {
                                    uint32_t modify3 = [xiugai[2] unsignedIntValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_UInt);
                                }
                                else if ([xiugaigeshi[2] isEqual:@"U64"]) {
                                    uint64_t modify3 = [xiugai[2] unsignedLongLongValue];
                                    if(tiaojian[2])engine.JRWriteMemory((unsigned long long)(results[i]),&modify3,JR_Search_Type_ULong);
                                }
                                //第一个条件4全改
                                
                            }
                        }
                        //只有一个全改
                        if (xiugaigeshi.count==1) {
                            if ([xiugaigeshi[0] isEqual:@"Double"]) {
                                double modify = [xiugai[0] doubleValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Double);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"Float"]) {
                                float modify = [xiugai[0] floatValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"U8"]) {
                                uint8_t modify = [xiugai[0] unsignedIntValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UByte);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"U16"]) {
                                uint16_t modify = [xiugai[0] unsignedIntValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UShort);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"U32"]) {
                                uint32_t modify = [xiugai[0] unsignedIntValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"U64"]) {
                                uint64_t modify = [xiugai[0] unsignedLongValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_ULong);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"I8"]) {
                                SInt8 modify = [xiugai[0] intValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SByte);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"I16"]) {
                                SInt16 modify = [xiugai[0] intValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SShort);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"I32"]) {
                                SInt32 modify = [xiugai[0] intValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SInt);
                                }
                            }
                            else if ([xiugaigeshi[0] isEqual:@"I64"]) {
                                SInt64 modify = [xiugai[0] longLongValue];
                                for(int i = 0;i<results.size();i++){
                                        engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SLong);
                                }
                            }
                        }

                   });
                   
               }else{
                   
               }
               
           }
    }
    
    
}

@end
    
