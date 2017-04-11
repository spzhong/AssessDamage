//
//  Tool.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "Tool.h"
#import "ErrorLog+CoreDataClass.h"

@implementation Tool

+(NSArray *)readConfig{
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"]];
    
    return array;
}


+(NSArray *)readStandardWorkHours{
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StandardWorkHours" ofType:@"plist"]];
    
    return array;
}


+(NSArray *)readNoBrand{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NoBrand" ofType:@"plist"]];
    
    return array;

}

+(NSDictionary*)readConfigWithKey:(NSString *)key{
    NSArray *array = [Tool readConfig];
    for (NSMutableDictionary *dic in array) {
        if ([dic[@"url"] isEqualToString:key]) {
            return dic;
        }
    }
    return nil;
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */

+ (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
    
}


//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


+(void)saveToErrorLog:(NSString *)url withPost:(NSMutableDictionary *)post withLog:(NSMutableDictionary *)diclog withDsc:(NSString *)des{
    //进行将错误的信息记录
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ErrorLog" inManagedObjectContext:[CoreData getDele].managedObjectContext];
    ErrorLog *errorLog = (ErrorLog *)[[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:[CoreData getDele].managedObjectContext];
    errorLog.userId = CurrUser.userId;
    errorLog.time = [NSDate date];
    errorLog.url = url;
    errorLog.postDicString = [Tool dictionaryToJson:post];
    errorLog.errorLog = [Tool dictionaryToJson:diclog];
    errorLog.des = des;
    [CoreData save_coredata];
    //进行将错误的信息记录
}


//NSString    *name;              // e.g. "My iPhone"
//@property(nonatomic,readonly,strong) NSString    *model;             // e.g. @"iPhone", @"iPod touch"
//@property(nonatomic,readonly,strong) NSString    *localizedModel;    // localized version of model
//@property(nonatomic,readonly,strong) NSString    *systemName;        // e.g. @"iOS"
//@property(nonatomic,readonly,strong) NSString    *systemVersion;


//获取设备信息
+(NSMutableDictionary *)deviceInfo{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    UIDevice *device = [UIDevice currentDevice];
    [dic setValue:device.name forKey:@"name"];
    [dic setValue:device.model forKey:@"model"];
    [dic setValue:device.systemName forKey:@"systemName"];
    [dic setValue:device.systemVersion forKey:@"systemVersion"];
    return dic;
}
@end
