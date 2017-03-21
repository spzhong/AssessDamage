//
//  NSMutableDictionary+DCKit.m
//  Pods
//
//  Created by 黄登登 on 2017/2/10.
//
//

#import "NSMutableDictionary+DCKit.h"
#import "DCUtilsMacro.h"

@implementation NSMutableDictionary (DCKit)

-(void)dc_setObject:(id)value KeyNotEmpty:(NSString *)key
{
    if (value) {
        [self setObject:value forKey:key];
    }else
    {
        DCLog(@"\n\n~~参数   %@ : 为空",key);
    }
}

@end
