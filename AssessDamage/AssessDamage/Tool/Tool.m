//
//  Tool.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "Tool.h"

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



@end
