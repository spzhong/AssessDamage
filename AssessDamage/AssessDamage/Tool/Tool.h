//
//  Tool.h
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+(NSArray *)readConfig;
+(NSDictionary*)readConfigWithKey:(NSString *)key;
//转json
+ (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

+(NSArray *)readStandardWorkHours;

+(NSArray *)readNoBrand;

@end
